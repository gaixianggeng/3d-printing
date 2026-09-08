"""配置产品摄影场景。通过 Blender MCP 分别渲染 hero / front / rear / exploded。"""
import bpy
import math
from pathlib import Path
from mathutils import Vector

OUT = Path(__file__).resolve().parent
scene = bpy.context.scene
col = bpy.data.collections['N1_03_Studio']
for obj in list(col.objects):
    bpy.data.objects.remove(obj, do_unlink=True)

def put(obj, name):
    obj.name = name
    for c in list(obj.users_collection):
        c.objects.unlink(obj)
    col.objects.link(obj)
    return obj

def aim(obj, target):
    obj.rotation_euler = (Vector(target)-obj.location).to_track_quat('-Z', 'Y').to_euler()

bpy.ops.mesh.primitive_plane_add(size=20000, location=(0, 0, -0.15))
floor = put(bpy.context.object, 'N1 studio • warm neutral surface')
mat = bpy.data.materials.get('N1 • studio ground') or bpy.data.materials.new('N1 • studio ground')
mat.use_nodes = True
p = mat.node_tree.nodes.get('Principled BSDF')
p.inputs['Base Color'].default_value = (0.24, 0.213, 0.18, 1)
p.inputs['Roughness'].default_value = 0.78
floor.data.materials.append(mat)
groove_mat = bpy.data.materials.get('N1 • vinyl grooves') or bpy.data.materials.new('N1 • vinyl grooves')
groove_mat.use_nodes = True
groove_mat.node_tree.nodes['Principled BSDF'].inputs['Base Color'].default_value = (0.027,0.030,0.028,1)
groove_mat.node_tree.nodes['Principled BSDF'].inputs['Roughness'].default_value = 0.46
for obj in bpy.data.objects:
    if obj.name.startswith('UI • vinyl groove'):
        obj.data.materials.clear()
        obj.data.materials.append(groove_mat)

for name, loc, power, size, color in [
    ('Large softbox', (-220, -340, 420), 3200000, 360, (1.0, 0.94, 0.85)),
    ('Fill', (300, -120, 230), 1500000, 290, (0.85, 0.91, 1.0)),
    ('Top rim', (60, 260, 380), 2700000, 270, (1.0, 0.92, 0.81)),
]:
    data = bpy.data.lights.new('N1 studio • '+name, 'AREA')
    data.energy = power
    data.shape = 'DISK'
    data.size = size
    data.color = color
    obj = bpy.data.objects.new(data.name, data)
    col.objects.link(obj)
    obj.location = loc
    aim(obj, (0, 15, 70))

world = bpy.data.worlds.get('N1 studio world') or bpy.data.worlds.new('N1 studio world')
world.use_nodes = True
world.node_tree.nodes['Background'].inputs['Color'].default_value = (0.29, 0.29, 0.29, 1)
world.node_tree.nodes['Background'].inputs['Strength'].default_value = 0.3
scene.world = world
data = bpy.data.cameras.new('N1 presentation camera')
camera = bpy.data.objects.new(data.name, data)
col.objects.link(camera)
data.type = 'ORTHO'
data.clip_end = 5000
data.lens = 58
scene.camera = camera

scene.render.engine = 'CYCLES'
scene.cycles.samples = 32
scene.cycles.use_denoising = True
scene.cycles.max_bounces = 6
try:
    preferences = bpy.context.preferences.addons['cycles'].preferences
    preferences.compute_device_type = 'METAL'
    preferences.get_devices()
    for device in preferences.devices:
        device.use = device.type == 'METAL'
    if any(d.type == 'METAL' for d in preferences.devices):
        scene.cycles.device = 'GPU'
except Exception:
    scene.cycles.device = 'CPU'
scene.render.resolution_x = 1600
scene.render.resolution_y = 1060
scene.render.resolution_percentage = 100
scene.render.image_settings.file_format = 'PNG'
scene.render.film_transparent = False
scene.view_settings.view_transform = 'AgX'
scene.view_settings.look = 'AgX - Medium High Contrast'
scene.view_settings.exposure = 0

def set_view(name):
    # 每张图先回到同一装配状态，避免累计位移。
    for cname in ('N1_01_Printable', 'N1_02_Visual_only'):
        for obj in bpy.data.collections[cname].objects:
            if 'assembly_location' in obj:
                obj.location = obj['assembly_location']
                obj.rotation_euler = obj['assembly_rotation']
            obj.hide_render = False
            obj.hide_set(False)
    if name == 'front':
        camera.location = (0, -760, 178)
        aim(camera, (0, 20, 77))
        camera.data.ortho_scale = 384
        scene.render.resolution_y = 980
    elif name == 'rear':
        camera.location = (-320, 580, 300)
        aim(camera, (0, 25, 76))
        camera.data.ortho_scale = 412
        scene.render.resolution_y = 1080
    elif name == 'exploded':
        for obj in bpy.data.collections['N1_01_Printable'].objects:
            if obj.name.startswith('01_'):
                obj.location.y -= 35
            elif obj.name.startswith('02_'):
                obj.location.y += 42
            elif obj.name.startswith('03_'):
                obj.location.x -= 30
                obj.location.y += 35
            elif obj.name.startswith('04_'):
                obj.location.x += 30
                obj.location.y += 35
            elif obj.name.startswith('05_'):
                obj.location.y += 75
                obj.location.z += 22
            elif obj.name.startswith('06_'):
                obj.location.y += 110
            elif obj.name.startswith(('07_', '08_')):
                obj.location.y -= 60
        # 图例和五金是视觉附件，拆件图隐藏它们以便看清实际零件。
        for obj in bpy.data.collections['N1_02_Visual_only'].objects:
            if obj.type == 'EMPTY':
                continue
            if obj.name.startswith(('Nokia', 'Tablet', 'Active', 'UI', 'Display')):
                obj.location.y += 15
                if obj.name.startswith(('Active', 'UI', 'Display')):
                    obj.hide_render = True
            else:
                obj.hide_render = True
        camera.location = (360, -620, 365)
        aim(camera, (0, 37, 85))
        camera.data.ortho_scale = 505
        scene.render.resolution_y = 1140
    else:
        camera.location = (265, -740, 287)
        aim(camera, (0, 19, 77))
        camera.data.ortho_scale = 415
        scene.render.resolution_y = 1060
    scene.render.filepath = str(OUT/(name+'.png'))
    bpy.context.view_layer.update()
    for screen in bpy.data.screens:
        for area in screen.areas:
            if area.type == 'VIEW_3D':
                space = area.spaces.active
                space.clip_end = 5000
                space.region_3d.view_perspective = 'CAMERA'
                space.overlay.show_overlays = False
                space.shading.type = 'MATERIAL'

bpy.app.driver_namespace['n1_set_view'] = set_view
set_view('hero')
bpy.ops.wm.save_as_mainfile(filepath=str(OUT/'n1_reference_v3.blend'))
print('Studio ready:', scene.render.engine, scene.cycles.device)
