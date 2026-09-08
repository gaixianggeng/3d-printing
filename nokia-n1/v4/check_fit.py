"""检查名义机身的六向限位、按键通道与安装路径；不代替实物尺寸验证。"""
import bpy,bmesh,json
from pathlib import Path
from mathutils import Vector
OUT=Path(__file__).resolve().parent
col=bpy.data.collections['N1_01_Printable']
tablet=bpy.data.objects['Nokia N1 • 200.7 × 138.6 × 6.9 mm']
shell=bpy.data.objects['01_Continuous_front'];cradle=bpy.data.objects['02_Tablet_cradle']
active=bpy.context.view_layer.objects.active
selected=list(bpy.context.selected_objects)
def volume(a,b):
 c=a.copy();c.data=a.data.copy();bpy.context.scene.collection.objects.link(c)
 bpy.context.view_layer.objects.active=c
 m=c.modifiers.new('Fit intersection','BOOLEAN');m.operation='INTERSECT';m.solver='EXACT';m.object=b
 bpy.ops.object.modifier_apply(modifier=m.name)
 bm=bmesh.new();bm.from_mesh(c.data);v=abs(bm.calc_volume())if bm.faces else 0;bm.free()
 mesh=c.data;bpy.data.objects.remove(c,do_unlink=True);bpy.data.meshes.remove(mesh)
 return v
proxy=tablet.copy();proxy.data=tablet.data.copy();bpy.context.scene.collection.objects.link(proxy)
base=tablet.location.copy()
results={}
try:
 for name,delta in [('nominal',(0,0,0)),('left',(-.8,0,0)),('right',(.8,0,0)),('down',(0,0,-.8)),('up',(0,0,.8)),('forward',(0,-1.1,0)),('back',(0,.8,0))]:
  proxy.location=base+Vector(delta);bpy.context.view_layer.update()
  hits={o.name:round(v,3)for o in col.objects if (v:=volume(o,proxy))>.05}
  results[name]=hits
 assert not results['nominal'],results['nominal']
 assert all(results[d]for d in ['left','right','down','up','forward','back']),results
 # 两个体积表示宽松的按键避让区域，不表示已测量的按键外形。
 proxy.location=base
 def box(name,lo,hi):
  bpy.ops.mesh.primitive_cube_add(size=1)
  o=bpy.context.object;o.name=name;o.parent=tablet.parent
  o.location=Vector([(lo[i]+hi[i])/2 for i in range(3)])
  o.dimensions=Vector([hi[i]-lo[i]for i in range(3)])
  bpy.ops.object.transform_apply(location=False,rotation=False,scale=True)
  bpy.context.view_layer.update();return o
 channels={}
 for name,lo,hi in [('volume',(-90,4,146.4),(-46,22,155)),('power',(-122,4,111),(-100.5,22,142))]:
  block=box(name,lo,hi)
  hits={o.name:round(v,3)for o in col.objects if (v:=volume(o,block))>.05}
  channels[name]=hits
  data=block.data;bpy.data.objects.remove(block,do_unlink=True);bpy.data.meshes.remove(data)
 assert not any(channels.values()),channels
 # 安装顺序：先把屏幕朝下放在面板背面，再从后方套上固定架。
 paths=[]
 for offset in [70,30,12,6,2,0]:
  proxy.location=base+Vector((0,offset,0));bpy.context.view_layer.update()
  paths.append({'stage':'tablet_to_front','rear_offset_mm':offset,'intersection_mm3':round(volume(shell,proxy),3)})
 proxy.location=base;bpy.context.view_layer.update()
 carrier=cradle.copy();carrier.data=cradle.data.copy();bpy.context.scene.collection.objects.link(carrier)
 try:
  for offset in [70,30,12,6,2,0]:
   carrier.location=cradle.location+Vector((0,offset,0));bpy.context.view_layer.update()
   paths.append({'stage':'cradle_over_tablet','rear_offset_mm':offset,'intersection_mm3':round(volume(carrier,proxy)+volume(carrier,shell),3)})
 finally:
  data=carrier.data;bpy.data.objects.remove(carrier,do_unlink=True);bpy.data.meshes.remove(data)
 assert not any(p['intersection_mm3']>.05 for p in paths),paths
 report={'six_direction_limit_check':results,'button_access_channels':channels,'assembly_path_samples':paths,'scope':'Nominal CAD geometry only; button sizes estimated from photos, actual fit and strength unverified.'}
 (OUT/'fit_check.json').write_text(json.dumps(report,ensure_ascii=False,indent=2));print(json.dumps(report,ensure_ascii=False))
finally:
 data=proxy.data;bpy.data.objects.remove(proxy,do_unlink=True);bpy.data.meshes.remove(data)
 bpy.ops.object.select_all(action='DESELECT')
 for o in selected:o.select_set(True)
 bpy.context.view_layer.objects.active=active
