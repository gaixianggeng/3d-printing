"""复核本目录导出的 STL；只验证数字几何，不代替实物试装。"""
from pathlib import Path
import hashlib
import json
import re

import manifold3d as md
import numpy as np
import trimesh

ROOT = Path(__file__).resolve().parent
SOURCE = (ROOT / "earpods_stand.scad").read_text()


def param(name):
    return float(re.search(rf"^{name}\s*=\s*(-?[\d.]+);", SOURCE, re.M)[1])


def solid(mesh):
    result = md.Manifold(md.Mesh(
        np.asarray(mesh.vertices, dtype=np.float32),
        np.asarray(mesh.faces, dtype=np.uint32),
    ))
    assert result.status() == md.Error.NoError, result.status()
    return result


def moved(mesh, xyz, angle=0):
    result = mesh.copy()
    result.apply_transform(trimesh.transformations.rotation_matrix(angle, [1, 0, 0]))
    result.apply_translation(xyz)
    return result


def box(size, center):
    return moved(trimesh.creation.box(extents=size), center)


def cylinder(radius, height, center, angle=0):
    return moved(trimesh.creation.cylinder(radius=radius, height=height, sections=128), center, angle)


parts = {name: trimesh.load_mesh(ROOT / "exports" / f"{name}.stl")
         for name in ("body", "lid", "stand", "fit_coupon", "ear_fit_coupon")}
report = {
    "version": "0.7",
    "units": "mm",
    "source_sha256": hashlib.sha256(SOURCE.encode()).hexdigest(),
    "parts": {},
    "checks": [],
    "limits": [
        "耳机头使用参考尺寸的局部矩形包络，耳机柄使用照片侧边位置的圆杆；不是实物扫描。",
        "检查耳机头直线放入、圆杆落座及卡扣入口阻挡；没有仿真卡扣弹性和疲劳。",
        "线控、Y 分线器、2.5 mm 线缆及 7 mm 插头检查直径为设计值，不是实测 EarPods 数据。",
        "单耳槽放入、单卡扣大小及 5.30 mm 磁铁孔已获用户确认，双卡扣稳定性和整机合盖尚未确认。",
        "未验证双卡扣实物、公差收缩、完整绕线、磁吸力度、整机打印和拾音效果。",
    ],
}
for name, mesh in parts.items():
    assert mesh.is_watertight and mesh.is_winding_consistent, name
    assert len(mesh.split()) == 1, name
    solid(mesh)
    report["parts"][name] = {
        "watertight": True, "connected_components": 1,
        "bounds_mm": np.round(mesh.bounds, 4).tolist(),
        "extents_mm": np.round(mesh.extents, 4).tolist(),
        "volume_mm3": round(mesh.volume, 3),
        "sha256": hashlib.sha256((ROOT / "exports" / f"{name}.stl").read_bytes()).hexdigest(),
    }


def check(name, a, b, blocked=False):
    overlap = md.Manifold.batch_boolean([solid(a), solid(b)], md.OpType.Intersect)
    assert overlap.status() == md.Error.NoError, (name, overlap.status())
    volume = abs(overlap.volume())
    passed = np.isfinite(volume) and (volume > 0.001 if blocked else volume < 0.001)
    report["checks"].append({"name": name, "expected": "blocked" if blocked else "clear",
                            "intersection_mm3": round(volume, 6), "passed": bool(passed)})
    assert passed, report["checks"][-1]


front = param("front_t")
depth = param("body_depth")
lid_t = param("lid_t")
ear_x = param("ear_x")
body = parts["body"]
lid = moved(parts["lid"], [0, 0, depth + lid_t], np.pi)
check("body_lid", body, lid)
reference = trimesh.load_mesh(ROOT / "preview" / "envelopes.stl")
check("body_reference_envelopes", body, reference)
check("lid_reference_envelopes", lid, reference)

ear_reference = json.loads(re.search(r"ear_reference\s*=\s*(\[[^;]+\]);", SOURCE)[1])
ear_w, ear_l, ear_d = ear_reference
clip_x = param("ear_space_w")/2-(param("stem_clip_bore_d")/2+param("stem_clip_wall"))-0.5
stem_z = front + param("stem_clip_axis_z") - 0.02
for x in (-ear_x, ear_x):
    side = -1 if x < 0 else 1
    for orientation, (width, thickness) in enumerate(((ear_w, ear_d), (ear_d, ear_w))):
        # 卡扣侵入原整体长方体区域是预期行为；头部和侧边耳机柄必须分开检查。
        head = box([width, ear_l/2, thickness], [x, ear_l/4, front + 0.8 + thickness/2])
        check(f"ear_head_{x}_{orientation}_body", body, head)
        check(f"ear_head_{x}_{orientation}_lid", lid, head)
        sweep = box([width, ear_l/2, 50], [x, ear_l/4, front + 0.8 + 25])
        check(f"ear_head_{x}_{orientation}_insertion", body, sweep)
        if side == -1:
            check(f"left_coupon_head_{orientation}", parts["ear_fit_coupon"], moved(head, [-x, 0, 0]))
    stem = cylinder(param("stem_check_d")/2, ear_l/2+4, [x+side*clip_x, (-ear_l/2+4)/2, stem_z], np.pi/2)
    check(f"stem_{side}_seated_body", body, stem)
    check(f"stem_{side}_seated_lid", lid, stem)
    if side == -1:
        check("left_coupon_stem_seated", parts["ear_fit_coupon"], moved(stem, [-x, 0, 0]))
    # 入口比圆杆窄，刚体会受阻；这不能代替真实按压、弹性张开和取出试验。
    for i, clip_y in enumerate((param("stem_clip_y"), param("stem_clip_y")-param("stem_clip_spacing"))):
        entry_probe = cylinder(param("stem_check_d")/2, param("stem_clip_band"),
                               [x+side*clip_x, clip_y, stem_z+1.5], np.pi/2)
        check(f"clip_{side}_{i}_entry_retention", body, entry_probe, blocked=True)
        if side == -1:
            check(f"coupon_clip_{i}_entry_retention", parts["ear_fit_coupon"], moved(entry_probe, [-x,0,0]), blocked=True)
    # 此位置已越过槽壁；验证新增后盖限位台确实阻挡该抬起位置。
    lifted = box([ear_d, ear_l, ear_w], [x, 0, front + 10 + ear_w / 2])
    check(f"ear_{x}_raised_escape_position", lid, lifted, blocked=True)

# 6 × 30 × 5 仅是狭窄线控的合成测试块，不能当作 EarPods 线控尺寸。
falling_remote = box([6, 30, 5], [0, 0, front - 1 + 2.5])
check("front_bars_support_synthetic_narrow_remote", body, falling_remote, blocked=True)

magnet_d, magnet_h = param("magnet_d"), param("magnet_h")
inner_r = param("head_d") / 2 - param("wall_t")
boss_r = (magnet_d + param("magnet_d_clearance")) / 2 + 2.5
magnet_y = inner_r - boss_r + 1.1
for name, mesh, surface in (("body", body, depth), ("lid", parts["lid"], lid_t)):
    for y in (-magnet_y, magnet_y):
        magnet = cylinder(magnet_d / 2, magnet_h, [0, y, surface - magnet_h / 2])
        check(f"{name}_magnet_{y:.2f}", mesh, magnet)

head_position = [0, (depth + lid_t) / 2, param("stem_top") + param("head_d") / 2]
check("body_stand", moved(body, head_position, np.pi / 2), parts["stand"])
check("lid_stand", moved(lid, head_position, np.pi / 2), parts["stand"])
world_body = moved(body, head_position, np.pi / 2)
world_lid = moved(lid, head_position, np.pi / 2)
wire = trimesh.load_mesh(ROOT / "preview" / "cable_check.stl")
assert wire.is_watertight and len(wire.split()) == 1
for name, mesh in (("body", world_body), ("lid", world_lid), ("stand", parts["stand"])):
    check(f"internal_cable_route_{name}", mesh, wire)
# 穿线时后盖打开，7 mm 直径测试块沿竖直轴贯穿圆盘和支杆，不要求插头转弯。
plug_sweep = cylinder(3.5, 150, [0, 0, 40])
check("plug_straight_insertion_body", world_body, plug_sweep)
check("plug_straight_insertion_stand", parts["stand"], plug_sweep)
splitter = cylinder(2.6, 8, [0, 0, param("stem_top") + 19])
check("splitter_body", world_body, splitter)
check("splitter_lid", world_lid, splitter)
radius = param("cable_bend_r")
internal_length = (param("stem_top") + 15 - param("base_slot_h")/2 - radius
                   + np.pi/2*radius + param("base_d")/2 - radius)
report["internal_cable"] = {"bore_d_mm": param("wire_bore_d"), "checked_plug_d_mm": 7,
                            "checked_wire_d_mm": 2.5, "centerline_length_to_base_edge_mm": round(internal_length, 3),
                            "bottom_slot_w_mm": param("base_slot_w"), "bottom_slot_h_mm": param("base_slot_h")}
# 从 OpenSCAD 实际装配变换导出的圆盘检查中线，避免只检查手写坐标公式。
head_mesh = trimesh.load_mesh(ROOT / "preview" / "head_alignment.stl")
head_center_xy = head_mesh.bounds.mean(axis=0)[:2]
base_center_xy = parts["stand"].bounds.mean(axis=0)[:2]
offset = head_center_xy - base_center_xy
assert np.max(np.abs(offset)) < 0.001, offset
report["alignment"] = {"head_to_base_center_offset_xy_mm": offset.tolist(), "passed": True}
# 插舌最低 1 mm 横截面的中心应落在支杆插孔中心。
toe = md.Manifold.batch_boolean([solid(body), solid(box([200, 1, 100], [0, -param("head_d")/2-param("tenon_l")+0.5, 0]))], md.OpType.Intersect)
assert toe.status() == md.Error.NoError and toe.volume() > 1
toe_bounds = np.asarray(toe.bounding_box()).reshape(2, 3)
assert abs(toe_bounds.mean(axis=0)[2] - head_position[1]) < 0.001
report["ear_clearances_mm"] = {
    "nominal_width_per_side": (param("ear_space_w") - ear_w) / 2,
    "rotated_width_per_side": (param("ear_space_w") - ear_d) / 2,
    "length_per_end": (param("ear_space_l") - ear_l) / 2,
    "closed_depth": param("ear_closed_depth"),
    "rear_gap_after_0.8_pad_nominal": param("ear_closed_depth") - ear_d - 0.8,
    "rear_gap_after_0.8_pad_rotated": param("ear_closed_depth") - ear_w - 0.8,
    "actual_wall_height_above_front_floor": param("holder_h") - 0.02,
    "closed_space_above_pocket_wall": param("ear_closed_depth")-param("holder_h")+0.02,
}
report["clip_trial"] = {"count_per_ear": 2, "center_spacing_mm": param("stem_clip_spacing"),
                        "gap_between_clips_mm": param("stem_clip_spacing")-param("stem_clip_band"),
                        "bore_d_mm": param("stem_clip_bore_d"), "entry_w_mm": param("stem_clip_opening"),
                        "wall_t_mm": param("stem_clip_wall"), "band_w_mm": param("stem_clip_band"),
                        "checked_stem_d_mm": param("stem_check_d"), "single_clip_size_user_confirmed": True,
                        "dual_clip_retention_verified": False}
report["user_fit_feedback"] = {"magnet_hole_d_mm": 5.30, "original_single_ear_pocket_fits": True,
                               "complete_closed_housing_verified": False}
report["passed"] = True
(ROOT / "preview" / "geometry-check.json").write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n")
print(json.dumps({"parts": len(parts), "checks": len(report["checks"]), "passed": True,
                  "clearances": report["ear_clearances_mm"]}, ensure_ascii=False, indent=2))
