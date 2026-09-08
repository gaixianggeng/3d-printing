"""通过 Blender MCP 执行。尺寸统一使用毫米，保留旧 OpenSCAD 设计。"""
import bpy
import bmesh
import math
from mathutils import Vector, Matrix
from pathlib import Path

OUT = Path(__file__).resolve().parent
OUT.mkdir(parents=True, exist_ok=True)
# 装饰区中心取外壳外缘与屏幕开窗边缘的中点，与背面零件的分界无关。
PANEL_CENTER = (320/2 + 162.5/2)/2
BUTTON_X = (PANEL_CENTER-13, PANEL_CENTER, PANEL_CENTER+13)
# USB 朝右时，音量键在左上长边；左压片向中间移，避免挡住按键通道。
KEEPER_X = {-1: -30, 1: 65}
# 左上角让出连续的按键通道，固定螺丝改到完整顶边，避免产生孤立角块。
CRADLE_FIX_X = lambda side, z: -12 if side == -1 and z > 100 else side*96
# 缺口是依据实物照片布置的宽松避让范围，不是按键的实测尺寸。
VOLUME_ACCESS = (-91, -45, 143, 157)
POWER_ACCESS = (-123, -98, 110, 143)

# 只替换本脚本的集合；初次运行时移除已经核对过的 Blender 默认物体。
for col in list(bpy.data.collections):
    if col.name.startswith('N1_'):
        for obj in list(col.objects):
            bpy.data.objects.remove(obj, do_unlink=True)
        bpy.data.collections.remove(col)
for name in ('Cube', 'Camera', 'Light'):
    obj = bpy.data.objects.get(name)
    if obj:
        bpy.data.objects.remove(obj, do_unlink=True)

scene = bpy.context.scene
scene.unit_settings.system = 'METRIC'
scene.unit_settings.scale_length = 0.001
scene.unit_settings.length_unit = 'MILLIMETERS'

def collection(name):
    c = bpy.data.collections.new(name)
    scene.collection.children.link(c)
    return c

parts = collection('N1_01_Printable')
details = collection('N1_02_Visual_only')
studio = collection('N1_03_Studio')
working = parts

def put(obj, name, material=None, target=None):
    obj.name = name
    for c in list(obj.users_collection):
        c.objects.unlink(obj)
    (target or working).objects.link(obj)
    if material:
        obj.data.materials.append(material)
    return obj

def material(name, color, roughness=0.4, metallic=0, emission=0):
    m = bpy.data.materials.get(name) or bpy.data.materials.new(name)
    m.diffuse_color = (*color, 1)
    m.use_nodes = True
    p = m.node_tree.nodes.get('Principled BSDF')
    p.inputs['Base Color'].default_value = (*color, 1)
    p.inputs['Roughness'].default_value = roughness
    p.inputs['Metallic'].default_value = metallic
    if emission:
        p.inputs['Emission Color'].default_value = (*color, 1)
        p.inputs['Emission Strength'].default_value = emission
    return m

ivory = material('N1 • warm chalk', (0.79, 0.765, 0.70), 0.32)
knob_mat = material('N1 • porcelain controls', (0.87, 0.85, 0.79), 0.29)
charcoal = material('N1 • graphite', (0.018, 0.021, 0.020), 0.46)
rubber = material('N1 • rubber', (0.014, 0.016, 0.015), 0.8)
silver = material('N1 • bead blasted aluminium', (0.36, 0.38, 0.37), 0.33, 0.65)
ink = material('N1 • legend ink', (0.09, 0.095, 0.088), 0.75)
display_black = material('N1 • display black', (0.005, 0.006, 0.006), 0.38)
ui_white = material('N1 • display text', (0.81, 0.80, 0.72), 0.7, emission=0.55)
ui_dim = material('N1 • display muted', (0.28, 0.31, 0.29), 0.8, emission=0.45)
ui_green = material('N1 • status green', (0.33, 0.53, 0.36), 0.7, emission=0.5)
ui_ochre = material('N1 • ochre', (0.60, 0.27, 0.10), 0.7, emission=0.4)
groove_mat = material('N1 • vinyl grooves', (0.027, 0.030, 0.028), 0.46)

def active(obj):
    bpy.ops.object.select_all(action='DESELECT')
    obj.select_set(True)
    bpy.context.view_layer.objects.active = obj

def normals(obj):
    bm = bmesh.new()
    bm.from_mesh(obj.data)
    bmesh.ops.recalc_face_normals(bm, faces=list(bm.faces))
    bm.to_mesh(obj.data)
    bm.free()
    obj.data.update()

def mesh(name, vertices, faces, material=None, target=None):
    data = bpy.data.meshes.new(name)
    data.from_pydata(vertices, [], faces)
    data.update()
    obj = bpy.data.objects.new(name, data)
    (target or working).objects.link(obj)
    if material:
        data.materials.append(material)
    normals(obj)
    return obj

def box(name, dimensions, location, material=None, bevel=0):
    bpy.ops.mesh.primitive_cube_add(size=1, location=location)
    obj = put(bpy.context.object, name, material)
    obj.dimensions = dimensions
    active(obj)
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    if bevel:
        soften(obj, bevel)
    return obj

def soften(obj, width=0.35, segments=3):
    m = obj.modifiers.new('Small manufactured edge', 'BEVEL')
    m.width = width
    m.segments = segments
    active(obj)
    bpy.ops.object.modifier_apply(modifier=m.name)
    return obj

def panel(name, w, h, depth, center, radius=2, material=None, steps=8):
    # 前视平面为 X/Z，Y 正方向始终指向背面，避免沿用旧模型的镜像坐标。
    x, y, z = center
    pts = []
    for cx, cz, start in [(w/2-radius, h/2-radius, 0), (-w/2+radius, h/2-radius, 90),
                          (-w/2+radius, -h/2+radius, 180), (w/2-radius, -h/2+radius, 270)]:
        for k in range(steps+1):
            a = math.radians(start + k*90/steps)
            pts.append((x+cx+radius*math.cos(a), z+cz+radius*math.sin(a)))
    n = len(pts)
    verts = [(a, y+d, b) for d in (-depth/2, depth/2) for a, b in pts]
    faces = [tuple(reversed(range(n))), tuple(range(n, 2*n))]
    faces += [(i, (i+1)%n, (i+1)%n+n, i+n) for i in range(n)]
    return mesh(name, verts, faces, material)

def cyl(name, radius, depth, loc, material=None, axis='Y', vertices=64):
    bpy.ops.mesh.primitive_cylinder_add(vertices=vertices, radius=radius, depth=depth, location=loc)
    obj = put(bpy.context.object, name, material)
    if axis == 'Y':
        obj.rotation_euler[0] = math.pi/2
    elif axis == 'X':
        obj.rotation_euler[1] = math.pi/2
    active(obj)
    bpy.ops.object.transform_apply(location=False, rotation=True, scale=True)
    return obj

def boolean(obj, cutter, operation='DIFFERENCE'):
    active(obj)
    m = obj.modifiers.new(operation, 'BOOLEAN')
    m.operation = operation
    m.solver = 'EXACT'
    m.object = cutter
    bpy.ops.object.modifier_apply(modifier=m.name)
    bpy.data.objects.remove(cutter, do_unlink=True)
    return obj

def union(obj, other):
    return boolean(obj, other, 'UNION')

def hole_array(name, positions, radius, y0, y1, n=20):
    verts, faces = [], []
    for x, z in positions:
        base = len(verts)
        for y in (y0, y1):
            verts += [(x+radius*math.cos(2*math.pi*i/n), y, z+radius*math.sin(2*math.pi*i/n)) for i in range(n)]
        faces += [tuple(base+i for i in reversed(range(n))), tuple(base+n+i for i in range(n))]
        faces += [(base+i, base+(i+1)%n, base+(i+1)%n+n, base+i+n) for i in range(n)]
    return mesh(name, verts, faces)

def prism_x(name, width, yz, material=None):
    n = len(yz)
    verts = [(x, y, z) for x in (-width/2, width/2) for y, z in yz]
    faces = [tuple(reversed(range(n))), tuple(range(n, 2*n))]
    faces += [(i, (i+1)%n, (i+1)%n+n, i+n) for i in range(n)]
    return mesh(name, verts, faces, material)

# 连续的整块正面，不在屏幕两侧切缝。返回边只深 10.8 mm，便于斜向竖印。
shell = panel('01_Continuous_front', 320, 154, 10.8, (0, 5.4, 77), 3.2, ivory)
boolean(shell, panel('Rear hollow', 313.6, 147.6, 12, (0, 9.2, 77), 2.0))
boolean(shell, panel('Display aperture', 162.5, 122.4, 20, (0, 5, 77), 3.4))
for side in (-1, 1):
    for z in (3.7, 150.3):
        union(shell, cyl('Cradle fixing boss', 3.5, 7.7, (CRADLE_FIX_X(side, z), 6.95, z)))
        boolean(shell, cyl('Cradle M3 pilot', 1.35, 7, (CRADLE_FIX_X(side, z), 7.5, z)))
    for z in (17, 137):
        union(shell, cyl('Rear cover fixing boss', 4.0, 7.7, (side*150, 6.95, z)))
        boolean(shell, cyl('Rear cover M3 pilot', 1.35, 7, (side*150, 7.5, z)))
boolean(shell, box('Cable bottom exit', (13, 14, 8), (139, 8, 1)))
holes = [(-PANEL_CENTER+(i-5)*3.6, 82+(j-14)*3.6) for i in range(11) for j in range(29)]
boolean(shell, hole_array('319 grille holes', holes, 0.95, -1, 4.2))
for x in range(-80, 81, 8):
    boolean(shell, box('Upper ventilation', (2, 5.5, 8), (x, 7, 153)))

# 旋钮均为独立装饰转件，盲孔不会贯穿出正面之外的多余结构。
for x, z, r, depth in [(PANEL_CENTER, 97, 7.3, 9.5)] + [(x, 34, 3.1, 6.0) for x in BUTTON_X]:
    # 螺柱从面板内部相交，避免两个同平面端盖产生重复面。
    union(shell, cyl('Control socket boss', r, depth-3.0, (x, (depth+3.0)/2, z)))
    bore = 3.25 if z == 97 else 1.65
    bore_depth = 7.0 if z == 97 else 4.2
    boolean(shell, cyl('Blind control socket', bore, bore_depth+0.3, (x, (bore_depth-0.3)/2, z)))

# 只移除背面返回边；保留 3.2 mm 正面，音量键可以从后上方触达。
boolean(shell, box('Volume rear access', (46, 18, 14), (-68, 12.4, 150)))
soften(shell, 0.20, 2)
shell['print_part'] = True

# 平板固定架是背面的单独闭环零件；显示窗口和实际机身不依赖装饰区分块。
cradle = panel('02_Tablet_cradle', 212.8, 151.8, 6.4, (0, 14.3, 77), 2.6, ivory)
union(cradle, panel('Front guide ring', 208.8, 147, 7.8, (0, 7.4, 77), 3.5))
boolean(cradle, panel('Tablet clearance', 201.6, 139.5, 24, (0, 10, 77), 6.2))
for x in (-58, 58):
    union(cradle, box('Bottom rear capture', (18, 6.2, 6), (x, 14.4, 9.8)))
for side in (-1, 1):
    for z in (3.7, 150.3):
        # 前部为面板螺柱让位，后部留下螺丝的承压面。
        boolean(cradle, cyl('Facade boss clearance', 3.9, 8, (CRADLE_FIX_X(side, z), 7.0, z)))
        boolean(cradle, cyl('Cradle through screw', 1.7, 20, (CRADLE_FIX_X(side, z), 12, z)))
    boolean(cradle, cyl('Keeper pilot', 1.35, 7, (KEEPER_X[side], 14.7, 149)))
    boolean(cradle, cyl('Stand pilot', 1.35, 7, (side*103.3, 14.7, 55)))
boolean(cradle, box('USB-C right channel', (20, 23, 16), (109, 11.5, 77)))
# 保留底边的承重槽和其余三边的限位；按键区域不承受夹紧力。
boolean(cradle, box('Volume access notch', (46, 24, 14), (-68, 12, 150)))
boolean(cradle, box('Power access notch', (25, 24, 33), (-110.5, 12, 126.5)))
boolean(cradle, box('Open button corner', (20, 32, 16), (-101, 12, 151)))
# 两侧均有接口开口时，后方连接桥把上下固定架连成一个实体。
# 桥的最前面位于 Y=25.2，完整保留原 USB 通道到 Y=23 的空间。
for z in (65, 89):
    union(cradle, box('USB rear bridge anchor', (6.4, 12.2, 6), (103.2, 23.1, z)))
union(cradle, box('USB rear structural bridge', (6.4, 4, 30), (103.2, 27.2, 77)))
soften(cradle, 0.15, 2)
cradle['print_part'] = True

for side in (-1, 1):
    obj = panel('03_Left_rear_cover' if side == -1 else '04_Right_rear_cover', 51.6, 151.8, 2.4, (side*132.6, 12.3, 77), 2.4, ivory)
    for z in (17, 137):
        boolean(obj, cyl('Cover through screw', 1.7, 5, (side*150, 12.3, z)))
    if side == -1:
        # 后盖内侧缺口为手指留出空间，与固定架的电源键通道连通。
        boolean(obj, box('Power rear finger access', (25, 8, 33), (-110.5, 12, 126.5)))
    if side == 1:
        boolean(obj, box('USB access notch', (16, 6, 16), (109, 12.3, 77)))
        boolean(obj, box('Cable exit notch', (13, 6, 7), (139, 12.3, 2)))
    obj['print_part'] = True
    obj = panel(f'05_Top_keeper_{side}', 12, 16, 2.6, (KEEPER_X[side], 19.1, 144.5), 1.5, ivory)
    boolean(obj, cyl('M3 clearance', 1.7, 5, (KEEPER_X[side], 19.1, 149)))
    union(obj, box('Keeper contact toe', (10, 6.7, 5), (KEEPER_X[side], 14.65, 140.5)))
    obj['print_part'] = True

angle = math.radians(8)
ground_z = lambda y: math.tan(angle)*y - 7/math.cos(angle)
stand = prism_x('06_Rear_easel', 180, [(19, 53), (23, 56), (81, ground_z(81)+3.1), (76, ground_z(76)+1.5)], ivory)
union(stand, box('Stand mounting beam', (216, 6, 12), (0, 20.8, 55)))
union(stand, prism_x('Stand foot', 186, [(73, ground_z(73)), (86, ground_z(86)), (86, ground_z(86)+3.6), (73, ground_z(73)+3.6)]))
for side in (-1, 1):
    boolean(stand, cyl('Stand through screw', 1.7, 9, (side*103.3, 20.8, 55)))
soften(stand, 0.35, 3)
stand['print_part'] = True

knob = cyl('07_Main_dial', 20, 6, (PANEL_CENTER, -3.6, 97), knob_mat, vertices=128)
soften(knob, 0.65, 5)
union(knob, cyl('Main dial shaft', 3.0, 6.8, (PANEL_CENTER, 2.65, 97)))
knob['print_part'] = True
for i, x in enumerate(BUTTON_X):
    obj = cyl(f'08_Button_{i+1}', 3.5, 2.4, (x, -1.8, 34), knob_mat)
    soften(obj, 0.3, 3)
    union(obj, cyl('Button stem', 1.4, 4.2, (x, 1.25, 34)))
    obj['print_part'] = True

# 之后的物体仅用于装配预览，不混入 STL。
working = details
tablet = panel('Nokia N1 • 200.7 × 138.6 × 6.9 mm', 200.7, 138.6, 6.9, (0, 7.45, 77), 6.0, silver)
front_glass = panel('Tablet black bezel', 199.4, 137.4, 0.35, (0, 3.83, 77), 5.5, charcoal)
screen = panel('Active display • 160.53 × 120.4 mm', 160.53, 120.4, 0.1, (0, 3.60, 77), 2.4, display_black)
panel('Grille shadow backing • visual only', 41, 108, 0.20, (-PANEL_CENTER, 3.36, 82), 1, charcoal)

font = bpy.data.fonts.load('/System/Library/Fonts/Supplemental/Arial.ttf', check_existing=True)
def label(name, text, x, z, size, mat=ink, y=-0.14, align='LEFT'):
    curve = bpy.data.curves.new(name, 'FONT')
    curve.body = text
    curve.size = size
    curve.font = font
    curve.align_x = align
    curve.space_character = 1.1
    obj = bpy.data.objects.new(name, curve)
    details.objects.link(obj)
    obj.location = (x, y, z)
    obj.rotation_euler[0] = math.pi/2
    curve.materials.append(mat)
    return obj

label('Front wordmark', 'N1', -PANEL_CENTER-18, 12.5, 5.0)
label('Front descriptor', 'DESK TERMINAL', -PANEL_CENTER-7, 12.5, 2.0)
for x, text in zip(BUTTON_X, ('HOME', 'AMBIENT', 'AGENT')):
    label('Control legend '+text, text, x, 24.7, 1.8, align='CENTER')
cyl('Dial index', 0.6, 0.06, (PANEL_CENTER-11.6, -6.63, 88), ink, vertices=24)
label('Dial reference', 'VOLUME', PANEL_CENTER, 67, 1.8, align='CENTER')

# 真实 4:3 画幅上的静态界面，仅用于检视外壳比例。
label('Display time', '09:30', -70, 121, 8.6, ui_white, 3.49)
label('Display date', 'MON, 05.26', -69.7, 113.8, 2.6, ui_dim, 3.49)
label('Display status', 'CODEX', 67, 125, 2.3, ui_dim, 3.49, 'RIGHT')
label('Display online', 'ONLINE', 67, 119, 3.1, ui_green, 3.49, 'RIGHT')
label('Display playing', 'NOW PLAYING', -70, 102, 2.3, ui_dim, 3.49)
record = cyl('UI • vinyl record', 25, 0.05, (20, 3.49, 75), charcoal, vertices=128)
for r in (12, 15, 18, 21, 24):
    bpy.ops.mesh.primitive_torus_add(major_radius=r, minor_radius=0.09, major_segments=96, minor_segments=8, location=(20, 3.44, 75), rotation=(math.pi/2, 0, 0))
    put(bpy.context.object, 'UI • vinyl groove', groove_mat)
cyl('UI • vinyl label', 8, 0.05, (20, 3.38, 75), ui_ochre)
cyl('UI • spindle', 1.1, 0.05, (20, 3.32, 75), display_black)
box('UI • album square', (39, 0.08, 45), (-31, 3.23, 75), ui_white)
box('UI • album block', (22, 0.08, 22), (-39.5, 3.13, 86.5), ui_ochre)
label('UI album typography', 'SIDE / A', -48, 57, 4.3, display_black, 3.04)
label('UI song title', 'Quiet mornings', -70, 41, 4.2, ui_white, 3.49)
label('UI song artist', 'DESK SESSIONS  /  VOL. 01', -70, 34.6, 2.4, ui_dim, 3.49)
box('UI • progress track', (112, 0.04, 0.4), (-6, 3.48, 27), ui_dim)
box('UI • progress fill', (48, 0.04, 0.5), (-38, 3.38, 27), ui_white)
cyl('UI • playhead', 0.8, 0.04, (-14, 3.32, 27), ui_white)
label('UI elapsed', '02:34', -70, 21, 2.0, ui_dim, 3.49)
label('UI duration', '06:58', 66, 21, 2.0, ui_dim, 3.49, 'RIGHT')

# 预览螺丝与脚垫；这些物体不属于打印件。
for side in (-1, 1):
    for z in (3.7, 150.3):
        cyl('Hardware • M3 cradle screw', 2.7, 1.8, (CRADLE_FIX_X(side, z), 18.5, z), silver, vertices=32)
    for z in (17, 137):
        cyl('Hardware • M3 rear cover screw', 2.7, 1.8, (side*150, 14.5, z), silver, vertices=32)
    s = cyl('Hardware • M3 keeper screw', 2.7, 1.8, (KEEPER_X[side], 21.4, 149), silver, vertices=32)
    boolean(s, box('Screw slot', (3.8, 1.1, 0.65), (KEEPER_X[side], 22.2, 149)))
    cyl('Hardware • M3 stand screw', 2.7, 1.8, (side*103.3, 24.8, 55), silver, vertices=32)
    box('Rubber front foot', (20, 13, 6.5), (side*132, 5, -3.1), rubber, 1.4)

root = bpy.data.objects.new('N1 • assembled at 8 degrees', None)
details.objects.link(root)
root.rotation_euler[0] = -angle
root.location.z = 7
for col in (parts, details):
    for obj in list(col.objects):
        if obj == root:
            continue
        obj.parent = root
        obj['assembly_location'] = list(obj.location)
        obj['assembly_rotation'] = list(obj.rotation_euler)
        if obj.type == 'MESH':
            # 平面保持平整；小圆角由真实几何提供，不用全局平滑掩盖硬边。
            obj.data.update()

scene['design_note'] = 'Continuous 320 × 154 × 10.8 mm front; separate rear tablet cradle; Nokia N1 landscape; 8° lean; decorative controls; mock display.'
scene['button_fit'] = 'USB right; volume upper-left; power left-upper. Generous relief based on photos, not measured button dimensions. Trial fit required.'
scene['tablet_fit'] = '200.7 × 138.6 × 6.9 mm; trial fit required before full print.'
scene['mcp_workflow'] = 'Created via blender-mcp 1.9.1 execute_blender_code, telemetry disabled.'
scene['model_revision'] = 'N1 Reference V4'
bpy.app.driver_namespace['n1_helpers'] = dict(globals())
bpy.ops.wm.save_as_mainfile(filepath=str(OUT/'n1_reference_v4.blend'))
print('N1 model created:', len(parts.objects), 'printable objects;', len(details.objects), 'visual objects')
