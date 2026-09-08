"""为 V4 现有螺丝孔生成试插销及 12 根装配销，尺寸单位为毫米。"""
from pathlib import Path
import json
import numpy as np
import trimesh

OUT = Path(__file__).resolve().parent
# 后表面至前件孔口的距离包含原模型的 0.3 mm 装配间隙。
# 销尖均停在盲孔底之前，避免压穿已经打印好的正面。
GROUPS = [('cradle', 4, 6.7, 12.0), ('cover', 4, 2.7, 8.0),
          ('keeper', 2, 2.9, 8.0), ('stand', 2, 6.3, 11.5)]


def pin(tip_diameter, shoulder_length, shaft_length, head_diameter=6.0):
    # 圆头朝下打印；2.7 mm 端不预设过盈，实际松紧通过试插件确定。
    h, r, n = 1.6, tip_diameter / 2, 96
    profile = [(0, 0), (head_diameter / 2 - .2, 0),
               (head_diameter / 2, .2), (head_diameter / 2, h - .2),
               (head_diameter / 2 - .2, h), (1.6, h),
               (1.6, h + shoulder_length - .3),
               (r, h + shoulder_length), (r, h + shaft_length - .5),
               (r - .3, h + shaft_length), (0, h + shaft_length)]
    mesh = trimesh.creation.revolve(np.array(profile), sections=n)
    mesh.fix_normals()
    assert mesh.is_watertight and mesh.is_winding_consistent and mesh.volume > 0
    assert len(mesh.split()) == 1
    return mesh


report = []
for plate in ('trial', 'full'):
    folder = OUT / plate
    folder.mkdir(parents=True, exist_ok=True)
    if plate == 'trial':
        specs = [(f'trial_D{d:.2f}_head{head:.0f}', d, 2.7, 8., head)
                 for d, head in [(2.6, 5.), (2.7, 6.), (2.8, 7.)]]
    else:
        specs = [(f'{name}_{i+1}_D2.70_L{length:.1f}', 2.7, shoulder, length, 6.)
                 for name, count, shoulder, length in GROUPS for i in range(count)]
    for index, (name, diameter, shoulder, length, head) in enumerate(specs):
        mesh = pin(diameter, shoulder, length, head)
        mesh.export(folder / (name + '.stl'))
        report.append(dict(plate=plate, name=name, tip_diameter_mm=diameter,
                           shoulder_diameter_mm=3.2, shoulder_length_mm=shoulder,
                           shaft_length_mm=length, head_thickness_mm=1.6,
                           head_diameter_mm=head, watertight=True,
                           volume_mm3=round(mesh.volume, 3)))
(OUT / 'geometry_check.json').write_text(json.dumps(report, ensure_ascii=False, indent=2))
print(f'Validated {len(report)} closed pin meshes.')
