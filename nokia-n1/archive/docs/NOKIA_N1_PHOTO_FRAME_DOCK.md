# Nokia N1 相框式充电支架说明

这个模型用于把 Nokia N1 平板做成类似桌面相框的横屏展示支架。主体按 Nokia N1 的外形尺寸建模，并预留了充电线开口、背面走线槽、后撑脚和 M3 旋转压片。

## 已采用的尺寸

- 平板横屏外形：200.7 × 138.6 × 6.9 mm
- 平板安装槽：外形尺寸每边增加 1.2 mm 装配余量
- 可视窗口：约 163.0 × 122.4 mm，用来露出 7.9 英寸 4:3 屏幕
- 默认充电方向：平板竖屏底边朝向相框右侧，因此 Type-C 开口在右侧
- 充电开口：30 × 10 mm，适合大多数 Type-C 线头，偏大的线头可以继续放大参数

## 文件

- OpenSCAD 源文件：`openscad/nokia_n1_photo_frame_dock.scad`
- 主体 STL：`build/nokia_n1_photo_frame_dock_frame.stl`
- 旋转压片 STL：`build/nokia_n1_photo_frame_dock_clips.stl`
- 预览图：`build/nokia_n1_photo_frame_dock_preview.png`

## 使用方式

1. 打印主体 `nokia_n1_photo_frame_dock_frame.stl`。
2. 打印压片 `nokia_n1_photo_frame_dock_clips.stl`，一组 4 个。
3. 把 Nokia N1 从背面放入安装槽。
4. 用 M3 螺丝把压片固定在背面孔位上，旋转压住平板边缘。
5. 充电线从右侧 Type-C 开口插入，线可以沿背面槽往下走。

## 建议打印参数

- 材料：PLA、PETG 都可以；如果环境温度高，优先 PETG。
- 喷嘴：0.4 mm。
- 层高：0.2 mm。
- 墙线：3 道以上。
- 填充：15% 到 25%。
- 主体建议正面朝下打印；如果开启一体后撑脚，切片时可能需要支撑。
- 压片建议单独打印，100% 填充更结实。

## 可调参数

所有常用参数都在 `.scad` 文件顶部：

- `tablet_clearance`：平板装配余量。太紧就加到 1.6 或 2.0。
- `charge_side`：充电口方向，可选 `right`、`left`、`bottom`。
- `charge_slot_width` / `charge_slot_height`：充电线开口尺寸。
- `front_rim_width` / `front_rim_raise`：外框凸起宽度和高度。
- `window_extra_x` / `window_extra_y`：屏幕窗口额外放大量。
- `use_kickstand`：是否启用一体后撑脚。

## 重新导出 STL

```bash
openscad -D 'part="frame"' -o build/nokia_n1_photo_frame_dock_frame.stl openscad/nokia_n1_photo_frame_dock.scad
openscad -D 'part="clips"' -o build/nokia_n1_photo_frame_dock_clips.stl openscad/nokia_n1_photo_frame_dock.scad
```

## 需要实物复核的点

ADB 能确认型号和屏幕参数，但不能测量外壳圆角、按键精确位置、线头实际尺寸。正式打印前建议先切一小段右侧充电口测试件，确认 Type-C 线能顺利插入，再打印完整主体。
