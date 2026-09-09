# EarPods 桌面麦克风支架（磁吸后盖，v0.7）

## 归档入口（2026-09-08）

当前版本为 v0.7。源任务为“设计磁吸式 AirPods 3D 模型”（`01a072f0-08ea-7851-bc9d-8c0c925ea370`），实际适配对象是 **EarPods 3.5 mm 有线耳机**。

- [整机打印工程](bambu-full-print/earpods-full-v0.7-P2S-ready.3mf)：主体、后盖、支杆底座共 3 件排在一盘。P2S、0.4 mm 喷嘴、PLA，历史切片预计 3 小时 35 分钟、168 g。
- [OpenSCAD 参数源文件](earpods_stand.scad)及 [STL 零件](exports/)。
- [双卡扣试件工程](bambu-fit-test/earpods-dual-clip-trial-v0.7-P2S.3mf)：已排版，未切片。
- [几何检查结果](preview/geometry-check.json)、[预览图](preview/)及 [历史模型包](archive/packages/)。
- [前期概念设计与提示词](concept/README.md)。

原任务已打开整机工程，但没有记录发送打印或整机完成后的实测结果。命令行切片曾出现结束指令解析提示；使用整机工程时先在 Bambu Studio 重新切片，核对无报错后再打印。主体插舌下需局部支撑，内部走线孔应保持畅通。

磁铁孔 5.30 mm 和 v0.6 单卡扣大小已经用户试装确认。用户选择跳过双卡扣试件、直接准备整机，因此不能把这一选择记为双卡扣稳定性或整机合盖验证通过。下文保留原模型规格和验证记录。

原始模型、打印文件与历史包按 SHA-256 记录在 [材料清单](material_checksums.json)。此次整理没有改变几何，也没有重新切片。

用户已确认原单耳槽能放入、5.30 mm 磁铁孔合适，v0.6 单卡扣大小也合适，但一个固定点不能稳定固定耳机。v0.7 在同侧增加第二个相同卡扣，每只耳机用两个固定点，右耳镜像处理。双卡扣稳定性和整机合盖尚未实物确认。

主线沿中空支杆进入底座底面槽。圆盘、插舌和支杆保持居中。

## 结构与尺寸

单位均为 mm。STL 按 100% 比例导入切片软件。

| 部位 | 设计尺寸 | 说明 |
| --- | --- | --- |
| 圆盘 | 直径 116，合盖厚 32.2 | 前板和侧壁均厚 2.4 |
| 整机 | 高 176，底座直径 108、厚 8 | 圆盘厚度中线与底座中心重合 |
| 支杆 | 外径 24，内孔直径 8 | 为中空接口保留壁厚，较 v0.4 加粗 4 |
| 插舌 | 12 × 14，插入长 8，中心孔直径 8 | 最薄侧壁 2；插舌底面距主体打印面 9.1 |
| 支杆插孔 | 12.4 × 14.4，深 8.4 | 角部到支杆外壁约 2.5 |
| 底座出线槽 | 宽 4，深 3.5 | 底面开放，从中心延伸到后侧边缘 |
| 通道转弯 | 中心线圆弧半径 6 | 连接支杆竖孔和底面槽 |
| 单耳参考外形 | 宽 14.5 × 长 35.6 × 厚 17.5 | 第三方尺寸图，非 Apple 制造图 |
| 单耳收纳槽 | 宽 19.5 × 长 39，内圆角 R3 | 入口倒角 0.6，槽壁约高 9 |
| 耳机柄卡扣 | 每个轴向长 3.2、壁厚 0.9、内径 5.2、开口宽 4.4 | 沿用用户确认合适的单扣尺寸 |
| 双卡扣位置 | 每耳 2 个，中心距 5，扣间净距 1.8 | 中心位于槽内 Y = -5、-10；同侧、同轴 |
| 卡扣检查杆 | 直径 4.8，中心距槽底约 3.5 | 仅用于数字检查，不是实测柄径 |
| 耳机区合盖净深 | 20 | 17.5 厚耳机加 0.8 软垫后仍余 1.7 |
| 线控槽 | 13 × 56 | 实际线控尺寸尚未获得可靠数据 |
| 线控检查包络 | 11 × 54 × 8 | 仅为设计检查值 |
| 线控正面窗口 | 8 × 48，托条宽 1.6，位于 Y = ±10 | 不得遮挡麦克风孔和按钮 |
| 线控限位筋处净深 | 10.7 | 8 厚检查包络加 0.8 垫片后余 1.9 |
| 磁铁 | 直径 5、厚 3，共 4 颗 | 顶部和底部各一对，用户已确认 |
| 磁铁盲孔 | 直径 5.30、深 3.15 | 5.30 孔径已通过用户试孔；后盖孔底剩 1.45 |
| 磁铁中心 | 圆心 Y = ±51.55 | 下磁铁孔与中央走线孔分开 |
| 后盖定位边间隙 | 径向每侧 0.30 | 需要打印试装 |

耳机头放入托槽，耳机柄从背面依次轻压进入两个开口卡扣。每个卡扣长 3.2 mm，两扣合计覆盖 8.2 mm 的柄段，外侧与围挡留 0.5 mm 缝。开口带导向斜面，不需要将耳机头穿过卡扣。第二个卡扣设在原卡扣下方 5 mm，保留柄尾和出线处空间。单扣大小已确认，因此本版没有缩小内径或开口；需要确认两扣同时扣入后的稳定性。

耳机头凸出围挡不等于顶到后盖。围挡约高 9 mm，合盖净深为 20 mm，围挡上方还有约 11 mm 空间，因此本版没有整体加高 3 mm。按参考最大厚度 17.5 mm 加 0.8 mm 预留检查，后盖仍余 1.7 mm；这不替代实物合盖确认。

## 内部走线和装配

路线为：圆盘内的 Y 形分线器 → 圆盘中央通孔 → 中空插舌 → 中空支杆 → 底座下方 → 底面槽 → 电脑。

1. `ear_fit_coupon.stl` 已更新为双卡扣，验证两个扣位能否同时落座，以及晃动是否减小。原磁铁试孔结果继续采用 5.30 mm，无须重复试孔。
2. 打印主体、后盖和支杆底座一体件。去除插舌下方支撑，清理通孔和槽内毛刺。
3. 打开后盖，从圆盘内将 3.5 mm 插头朝下穿过主体通孔和插舌。再让插头直穿支杆，从底座下面出来。
4. 将圆盘插舌插入支杆插孔，缓慢拉出多余主线。Y 形分线器留在圆盘内、通孔上方，避免把分线器拉进支杆。
5. 翻起底座，把已经穿出来的线横向放入底面槽。插头不用在支杆或底座内转弯，也不用穿过 4 mm 窄槽。确认线低于底面接触平面，再将底座放平。
6. 放入耳机头，将耳机柄轻压进侧边卡扣，再放入线控，按实际余量松绕分支线。卡扣不能夹在线缆或应力缓冲套上。线控的麦克风孔必须朝向窗口，避开托条，按钮不得被后盖或垫片压住。
7. 确认每对磁铁相吸后少量点胶固定，避免磁铁突出。合盖前检查线没有夹在接缝中，再验证电脑连接。

**按当前 Y 分线器示意位置，内部路线中心线长约 124.7 mm，即约 12.5 cm。** 这部分主线不能再算作底座之外的可用线长。内部留松量还会继续减少外露长度；实际值取决于分线器位置和实物线长。

8 mm 通道已用直径 7 mm 的连续直线包络检查穿线空间。这里的 7 mm 是设计检查值，不是已测得的插头外壳直径；“3.5 mm”仅说明接口规格。没有实测插头外壳尺寸，因此不能保证所有外壳或第三方同接口耳机都能穿过。完整主线、分支长度和线控尺寸也没有可靠公开制造数据，不承诺剩余外露厘米数。

## 打印文件与方向

- `earpods_stand.scad`：参数源文件，默认显示装配。将 `part` 设为 `section` 可查看内部走线剖视；剖视不能打印。
- `exports/body.stl`：主体，正面朝打印板。插舌及承重平肩下方需要局部支撑。检查横向通孔的切片桥接，确保打印后能清理通道。
- `exports/lid.stl`：后盖，外表面朝打印板，磁铁孔和限位台朝上。
- `exports/stand.stl`：支杆与底座一体件，底座底面朝打印板。检查底部 4 mm 槽的桥接；竖孔中不要留下无法清除的支撑。
- `exports/fit_coupon.stl`：磁铁试孔件，孔径 5.15、5.30、5.45，孔深均 3.15。
- `exports/ear_fit_coupon.stl`：单耳双卡扣试件，约 28.7 × 48.2 × 11.38，与正式主体左耳槽共用相同围挡和两个卡扣。用于验证固定效果，不验证整机合盖深度。
- `preview/ear_clip_trial.png`：新试件和小卡扣的放大预览。
- `bambu-fit-test/earpods-dual-clip-trial-v0.7-P2S.3mf`：只含双卡扣试件，P2S、0.4 mm、PLA、纹理 PEI 板、0.20 mm 层高、4 道墙、无支撑；已排版，未切片或发送打印。
- `preview/section.png`：内部通道剖视，橙色为主线示意。
- `preview/front.png`、`inside.png`、`side.png`、`lid_inside.png`：外观、开盖、侧视和后盖内侧。
- `preview/envelopes.stl`、`head_alignment.stl`、`cable_check.stl`：几何检查模型，不能作为打印零件。
- `verify_model.py`、`preview/geometry-check.json`：检查脚本与结果。

试打起点：0.4 mm 喷嘴、0.2 mm 层高、4 道壁，主体和后盖 20% 填充，底座 35% 填充。v0.6 单卡扣试件已打印和试装；本版双卡扣和整机尚未打印，必须结合切片预览确认支撑和桥接。不要混用 v0.4 的旧主体、旧支杆与 v0.5 之后的接口。

## 实际验证与资料边界

OpenSCAD 2026.04.26 在 `--hardwarnings` 下导出修改后的几何。5 个打印零件均为封闭网格和单一连通实体。Python 3.11、trimesh 与 Manifold 的 44 项几何检查通过；另检查了实际圆盘装配中线和插舌中心。

另用直径 4.8、长 8.2 mm 的圆杆，绕原卡扣中心前后倾斜 5°，比较旧试件和新试件。与 v0.6 单扣试件的交叠体积为 0，与 v0.7 双扣试件为约 2.59 mm³，说明第二个固定点会阻挡这一倾斜姿态。此检查没有包含弹性变形，不能当作实物夹持力或完全无晃动的证明。

耳机检查改为“头部空间＋侧边圆杆”分开检查，位置来自单耳照片。新增卡扣会占用原来整块长方体包络中的空白区域，因此不能继续把那个长方体当作真实耳机。当前检查包含头部区域的两种参考宽厚和直线放入、圆杆落座、卡扣口对抬起圆杆的阻挡、后盖限位；以及壳盖、支杆、磁铁孔、内部线缆和插头通路的回归检查。

卡扣口的阻挡是预期功能，不是证明耳机无法放入；实际安装需要卡扣发生小幅弹性张开。单扣大小已经实物确认，但尚未试打双卡扣，也未进行弹性、强度或疲劳仿真，不能保证长期使用寿命。线控、插头、分线器和线径仍是设计检查值。整机打印、磁吸力度、完整绕线和拾音效果尚未验证。

资料：

- [Apple：EarPods（3.5 mm 插头）](https://www.apple.com/shop/product/mwu53am/a/earpods-35mm-headphone-plug)：确认版本及功能，未提供完整机械尺寸。
- [Dimensions.com：EarPods 尺寸图](https://www.dimensions.com/element/apple-earpods-2012)：单耳参考尺寸 35.6 × 14.5 × 17.5；没有制造公差。
- [我爱音频网：3.5 mm EarPods 拆解](https://www.52audio.com/archives/20540.html)：样本总长度约 118 cm，没有分段线长，不能将总长当作底座外可用长度。

在本仓库根目录重新导出并检查（Python 环境需已有 numpy、trimesh、manifold3d；会覆盖已有导出与检查结果）：

```sh
cd earpods-magnetic-stand
openscad --hardwarnings --export-format binstl -D 'part="body"' -o exports/body.stl earpods_stand.scad
openscad --hardwarnings --export-format binstl -D 'part="lid"' -o exports/lid.stl earpods_stand.scad
openscad --hardwarnings --export-format binstl -D 'part="stand"' -o exports/stand.stl earpods_stand.scad
openscad --hardwarnings --export-format binstl -D 'part="fit_coupon"' -o exports/fit_coupon.stl earpods_stand.scad
openscad --hardwarnings --export-format binstl -D 'part="ear_fit_coupon"' -o exports/ear_fit_coupon.stl earpods_stand.scad
openscad --hardwarnings --export-format binstl -D 'part="envelopes"' -o preview/envelopes.stl earpods_stand.scad
openscad --hardwarnings --export-format binstl -D 'part="preview_only"' -o preview/head_alignment.stl preview/head_alignment.scad
openscad --hardwarnings --export-format binstl -D 'part="preview_only"' -o preview/cable_check.stl preview/cable_check.scad
python3.11 verify_model.py
```

报告记录了源文件及 5 个打印 STL 的校验值。修改参数后须重新导出并运行检查。
