"""检查打印网格，导出以毫米计的 STL；不导出平板、界面和五金预览。"""
import bpy
import bmesh
import json
import math
from pathlib import Path
from mathutils import Matrix, Vector

OUT = Path(__file__).resolve().parent
STL = OUT/'stl'
STL.mkdir(exist_ok=True)
col = bpy.data.collections['N1_01_Printable']
expected_files = {obj.name+'.stl' for obj in col.objects}
for old_export in STL.glob('*.stl'):
    if old_export.name not in expected_files:
        old_export.unlink()
report = []
failed = []
for obj in col.objects:
    bm = bmesh.new()
    bm.from_mesh(obj.data)
    bmesh.ops.recalc_face_normals(bm, faces=list(bm.faces))
    bm.to_mesh(obj.data)
    volume = bm.calc_volume(signed=True)
    bad_edges = sum(not e.is_manifold for e in bm.edges)
    remaining = set(bm.verts)
    components = 0
    while remaining:
        components += 1
        stack = [remaining.pop()]
        while stack:
            vert = stack.pop()
            for edge in vert.link_edges:
                other = edge.other_vert(vert)
                if other in remaining:
                    remaining.remove(other)
                    stack.append(other)
    bm.free()
    # 只保留零件自身的变换，去掉展示用的整机后倾。
    copy = obj.copy()
    copy.data = obj.data.copy()
    copy.parent = None
    bpy.context.scene.collection.objects.link(copy)
    local = Matrix.LocRotScale(Vector(obj['assembly_location']), obj.rotation_euler.to_quaternion(), Vector((1,1,1)))
    # 整块面板在平台内旋转 45° 竖立，其他零件按正面朝下导出。
    orientation = Matrix.Rotation(math.pi/4, 4, 'Z') if obj.name == '01_Continuous_front' else Matrix.Rotation(math.pi/2, 4, 'X')
    copy.matrix_world = orientation @ local
    bpy.context.view_layer.update()
    points = [copy.matrix_world @ Vector(p) for p in copy.bound_box]
    minimum = Vector(tuple(min(p[i] for p in points) for i in range(3)))
    maximum = Vector(tuple(max(p[i] for p in points) for i in range(3)))
    size = maximum-minimum
    copy.location -= Vector(((minimum.x+maximum.x)/2, (minimum.y+maximum.y)/2, minimum.z))
    bpy.ops.object.select_all(action='DESELECT')
    copy.select_set(True)
    bpy.context.view_layer.objects.active = copy
    bpy.context.view_layer.update()
    dest = STL/(obj.name+'.stl')
    bpy.ops.wm.stl_export(filepath=str(dest), export_selected_objects=True, global_scale=1.0, use_scene_unit=False, apply_modifiers=True)
    data = {'part': obj.name, 'non_manifold_edges': bad_edges, 'connected_components': components,
            'volume_mm3': round(volume, 2), 'print_bounds_mm': [round(v,2) for v in size],
            'fits_256_bed': size.x < 256 and size.y < 256, 'file': str(dest.relative_to(OUT))}
    if obj.name == '01_Continuous_front':
        data['orientation'] = 'Upright, Z rotation 45 degrees; 8 mm brim and window support required.'
        data['bounds_with_8mm_brim'] = [round(size.x+16,2), round(size.y+16,2)]
    report.append(data)
    if bad_edges or components != 1 or volume <= 0 or not data['fits_256_bed']:
        failed.append(data)
    bpy.data.objects.remove(copy, do_unlink=True)

# 与平板实体做相交体积检查，直接排除壳体或压片穿入机身。
tablet = bpy.data.objects['Nokia N1 • 200.7 × 138.6 × 6.9 mm']
def intersection_volume(obj, target):
    copy = obj.copy()
    copy.data = obj.data.copy()
    bpy.context.scene.collection.objects.link(copy)
    bpy.ops.object.select_all(action='DESELECT')
    copy.select_set(True)
    bpy.context.view_layer.objects.active = copy
    mod = copy.modifiers.new('Tablet interference check', 'BOOLEAN')
    mod.operation = 'INTERSECT'
    mod.solver = 'EXACT'
    mod.object = target
    bpy.ops.object.modifier_apply(modifier=mod.name)
    bm = bmesh.new()
    bm.from_mesh(copy.data)
    amount = abs(bm.calc_volume()) if bm.faces else 0
    bm.free()
    bpy.data.objects.remove(copy, do_unlink=True)
    return amount

collisions = []
for obj in col.objects:
    amount = intersection_volume(obj, tablet)
    if amount > 0.05:
        collisions.append({'part': obj.name, 'intersection_mm3': round(amount,3)})

def local_bounds(obj):
    pts = [obj.matrix_basis @ Vector(p) for p in obj.bound_box]
    return [min(p[i] for p in pts) for i in range(3)], [max(p[i] for p in pts) for i in range(3)]

part_collisions = []
objects = list(col.objects)
for i, a in enumerate(objects):
    amin, amax = local_bounds(a)
    for b in objects[i+1:]:
        bmin, bmax = local_bounds(b)
        if all(min(amax[j],bmax[j])-max(amin[j],bmin[j]) > 0.01 for j in range(3)):
            amount = intersection_volume(a, b)
            if amount > 0.05:
                part_collisions.append({'parts': [a.name,b.name], 'intersection_mm3': round(amount,3)})

output = {'blender': bpy.app.version_string, 'part_count': len(report), 'parts': report,
          'failed_parts': failed, 'tablet_collisions': collisions, 'part_collisions': part_collisions,
          'scope': 'Mesh topology, positive volume, 256 mm XY bed bounds, tablet solid collision and pairwise print-part collisions. Physical fit, strength and slicing are not validated.'}
(OUT/'validation.json').write_text(json.dumps(output, ensure_ascii=False, indent=2))
print(json.dumps({'part_count': len(report), 'failed_parts': failed, 'tablet_collisions': collisions, 'part_collisions': part_collisions}, ensure_ascii=False))
bpy.ops.wm.save_as_mainfile(filepath=str(OUT/'n1_reference_v3.blend'))
if failed or collisions or part_collisions:
    raise RuntimeError('模型检查未通过，请先查看 validation.json，暂勿打印。')
