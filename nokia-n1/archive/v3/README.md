# Nokia N1 连续面板外壳 · Blender V3

## 目标

按原始参考图重新设计外壳。正面使用一个连续零件，取消屏幕中框与左右面板之间的拼缝。旧的 OpenSCAD 文件保持原样。

## 方案

- 正面外轮廓：320 × 154 mm；面板厚 3.2 mm，背面返回边总深度 10.8 mm。
- Nokia N1 按 200.7 × 138.6 × 6.9 mm 横向安装。
- 可视屏幕沿用旧项目的 160.53 × 120.4 mm，开窗为 162.5 × 122.4 mm。
- 平板导向槽为 201.6 × 139.5 mm，四边名义余量各约 0.45 mm。
- 正面以外的固定架、左右后盖、顶部压片和后支架从背面装配。
- 整机后倾 8°，旋钮和小按钮为独立装饰转件，不含电子控制功能。

左右装饰区的中心取“屏幕开窗边缘到外壳外缘”的中点，即 X = ±120.625 mm。孔阵列为 11 列 × 29 行，孔径 1.9 mm、间距 3.6 mm；孔阵列左右留白各约 20.425 mm。主旋钮直径 40 mm，左右留白各约 19.375 mm。该对齐不取决于后盖的分块位置。

## 文件与使用

- `n1_reference_v3.blend`：可编辑场景，打印件、视觉附件、灯光分开存放。
- `front.png`、`hero.png`、`rear.png`、`exploded.png`：正视、整体、背面和拆件预览。
- `stl/`：11 个独立 STL，使用毫米单位，已摆放到各自的打印起始平面。
- `validation.json`：网格、打印范围和与平板相交体积的实际检查结果。
- `create_model.py`：建模脚本；`validate_export.py`：检查和导出；`render_views.py`：摄影场景及视图。

在 Blender 中打开设计：

```bash
open -a Blender /Users/gaixiaotongxue/code/AndroidHelloWorld/blender/n1_reference_v3/n1_reference_v3.blend
```

打印件分组：

1. `01_Continuous_front.stl`：完整正面。
2. `02_Tablet_cradle.stl`：平板固定架。
3. `03_Left_rear_cover.stl`、`04_Right_rear_cover.stl`：左右后盖。
4. 两个 `05_Top_keeper`：顶部可拆压片。
5. `06_Rear_easel.stl`：独立后支架。
6. `07_Main_dial.stl` 和三个 `08_Button`：旋钮与小按钮。

### 打印方向

先按旧项目记录的 256 × 256 mm 平台规划；尚未收到本次打印机的确切型号。

完整正面已经绕竖直轴旋转 45°，采用竖立打印。零件范围约 233.91 × 233.91 × 154 mm。加入 8 mm 的底边附着圈后，名义范围约 249.91 × 249.91 mm。**不要在切片器中把这个零件自动平放。**

这项取舍消除了正面拼缝，但需要为屏幕开窗上沿添加支撑，并检查竖立面板的附着稳定性。具体机器的禁印区域、支撑外扩范围和材料收缩仍须在切片器中核对。后支架和顶部压片也需要检查支撑。其余零件的底面已归零。

### 装配顺序

1. 在孔阵列背面放置约 0.2 mm 的黑色薄片或网布。渲染里的黑色背衬不包含在 STL 中。
2. 将固定架放入正面背部。用四颗 M3 × 12 mm 螺丝从后方固定。
3. 从背面斜着放入平板，下边缘进入底托，确认屏幕完全露出。
4. 安装两个顶部压片，用两颗 M3 × 8 mm 螺丝固定。压片接触端与机背留约 0.4 mm 的软垫间隙。
5. 充电线从平板右侧通道接入，再经右后盖和底部出线缺口引出。
6. 用四颗 M3 × 8 mm 螺丝固定后盖，用两颗 M3 × 10 mm 螺丝固定后支架。
7. 插入旋钮和小按钮，在前底部贴约 6.5 mm 厚的脚垫。

上面的螺丝长度由当前几何尺寸确定，尚未实物试装。安装柱使用 2.7 mm 试配孔；选用的螺丝与材料必须先试配，不要直接强拧。顶部采用螺丝固定的可拆压片，不是已经验证过疲劳寿命的弹性卡扣。

### Blender MCP

本次使用 Blender 5.2.1 LTS 和 [Blender MCP 1.9.1](https://github.com/ahujasid/blender-mcp) 的 `execute_blender_code` 建模、检查和渲染。Codex 已注册名为 `blender` 的 MCP 服务。Blender 插件已启用，仅监听本机；数据收集已关闭。

以后打开 Blender 时，在右侧侧栏的 MCP for Blender 面板确认连接处于启动状态，再让 Codex 修改场景。

如需从源脚本重建本版本，可以执行以下命令。它会覆盖本目录中的生成结果，先保存你在 Blender 中做的后续修改。

```bash
cd /Users/gaixiaotongxue/code/AndroidHelloWorld
blender --background --factory-startup \
  --python blender/n1_reference_v3/create_model.py \
  --python blender/n1_reference_v3/validate_export.py \
  --python blender/n1_reference_v3/render_views.py \
  --python-expr "import bpy; bpy.app.driver_namespace['n1_set_view']('front'); bpy.ops.render.render(write_still=True)"
```

## 验证边界

网格检查只确认封闭性、单个连通实体、正体积、名义打印范围和与平板模型的相交情况。实际切片、打印、装机、长期开裂风险和脚垫稳定性尚未验证。先试配固定架、压片和旋钮，再安排完整面板打印。

屏幕内容、文字、黑色背衬、平板、螺丝和脚垫用于外观预览，不属于打印文件。屏幕内容是静态示意，没有修改 Android App。
