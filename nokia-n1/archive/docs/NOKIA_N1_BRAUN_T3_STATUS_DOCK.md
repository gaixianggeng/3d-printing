# Nokia N1 Braun T3 风格信息终端

这个模型把 Nokia N1 当作“数字时代的显示机芯”，而不是一台裸露平板。整体定位是：Braun T3 / Rams 语言下的桌面信息终端，可用于音乐播放、时钟、Codex monitor、Agent 状态中心和 ambient dashboard。

## 设计逻辑

- 左侧是实体呼吸区：规则网孔、留白、低视觉负担。
- 中间是嵌入式信息窗口：用厚 bezel 遮住平板黑边，让屏幕像设备的原生组件。
- 右侧是实体控制区：一个可转动装饰大旋钮和三个可转动装饰小圆钮，为数字界面提供物理锚点。
- 外壳保持厚度和倾角，避免做成廉价平板支架。
- 材质建议使用哑光白作为主色，旋钮和按钮也保持白色或微磨砂浅灰，不建议高亮、透明或 RGB。

## 现实尺寸约束

参考概念图里的 263 × 110 mm 无法直接容纳 Nokia N1，因为 N1 横屏实体高度是 138.6 mm。当前模型吸收了 `braun_nokia_n1.scad` 参考稿的整机比例，把外壳收敛到更接近 Braun 桌面设备的尺度：

- 外壳约：306 × 139 × 40 mm
- 外壳四角圆角：3.9 mm，整体更接近设计稿里的克制直角比例
- 平板：200.7 × 138.6 × 6.9 mm
- Nokia N1 可视屏幕参考值：约 160.53 × 120.4 mm
- 中央可视窗口：162.5 × 121.4 mm，由 `screen_vertical_margin = 8.8` 自动推导，完整露出屏幕并保留少量装配余量
- 当前正式拆件采用三件式正面：中间完整屏幕方框 + 左右两个功能模块，避免上下横梁方案带来的割裂感
- 中间屏幕方框两侧带隐藏插舌，左右模块带接收凹槽，再用上下边缘插入的锁销固定，不依赖胶水
- 左右模块已改成背面减重开腔结构：正面、外圈、上下锁销区保留实体，内部不再做大实心块；按几何体体积粗算，比同尺寸实心侧块少约 60% 以上
- 背后两片三角支架现在分别和左右模块外侧一体成型，并通过内部竖向锚定肋连接到模块前面板和外圈，不需要 502 胶
- 默认固定方式已改为四个一体式侧向卡扣：左右模块各两个，直接卡住 Nokia N1 背面边缘，不需要 M3 螺丝柱和单独压片
- 充电口：默认从视觉右侧走线，对应 Nokia N1 横屏时的 Type-C 方向
- 左侧网孔：12 × 24 阵列，并按左侧白板自动居中
- 正式网孔：采用 1.90 mm 主孔径，正面孔口加 2.25 mm 浅倒角，用来抵消首层挤压和孔口毛边
- 右侧旋钮和三颗小按钮：按右侧白板自动居中
- 右侧旋钮和三颗小圆钮：默认单独打印，插入外壳盲孔后可手动旋转
- 左右白板居中基准：外壳边缘到黑色屏幕窗口边缘，不按屏幕外框凹槽计算
- 底部外凸底座条已移除，正面只保留主体外壳轮廓
- 正面装饰性分界线已移除，网孔区、顶部和外框不再额外做浅凹线

## 文件

- OpenSCAD 源文件：`openscad/nokia_n1_braun_t3_status_dock.scad`
- 3D 打印输出目录：`3D打印/Builder/`
- 主体 STL：`3D打印/Builder/nokia_n1_braun_t3_status_dock_shell.stl`
- 三件式主体 STL：`3D打印/Builder/nokia_n1_braun_t3_status_dock_shell_speaker.stl`、`3D打印/Builder/nokia_n1_braun_t3_status_dock_shell_screen.stl`、`3D打印/Builder/nokia_n1_braun_t3_status_dock_shell_controls.stl`
- 中框锁销 STL：`3D打印/Builder/nokia_n1_braun_t3_status_dock_rail_lock_pins.stl`
- 拓竹两盘打印 STL：`3D打印/Builder/nokia_n1_braun_t3_status_dock_bambu_plate_1.stl`、`3D打印/Builder/nokia_n1_braun_t3_status_dock_bambu_plate_2.stl`
- 单独旋钮 STL：`3D打印/Builder/nokia_n1_braun_t3_status_dock_rotary_controls.stl`
- 屏幕开窗校准片 STL：`3D打印/Builder/nokia_n1_braun_t3_status_dock_screen_window_fit_test.stl`
- 正面布局薄片校准套件 STL：`3D打印/Builder/nokia_n1_braun_t3_status_dock_front_layout_fit_test.stl`
- 旋钮配合测试 STL：`3D打印/Builder/nokia_n1_braun_t3_status_dock_rotary_fit_test.stl`
- 网孔配合测试 STL：`3D打印/Builder/nokia_n1_braun_t3_status_dock_speaker_grille_fit_test.stl`
- 背面压片 STL：`3D打印/Builder/nokia_n1_braun_t3_status_dock_clips.stl`
- 正面预览：`3D打印/Builder/nokia_n1_braun_t3_status_dock_front.png`
- 3D 预览：`3D打印/Builder/nokia_n1_braun_t3_status_dock_preview.png`

## 装配方式

1. 先把中间屏幕方框两侧的插舌对准左右模块的凹槽，轻轻压入。
2. 从外壳上边缘和下边缘插入 4 根锁销，让锁销穿过左右模块与中框插舌的对位孔。
3. 从背面放入 Nokia N1。
4. 让左右两侧的一体式卡扣压住平板背面边缘；如果第一次装入偏紧，先从一侧斜着放入，再轻压另一侧。
5. Type-C 线从视觉右侧开口接入，并沿背面走线槽向下走线。
6. 大旋钮和三个小圆钮是可转动装饰件：短轴插入右侧盲孔，不接电子元件。
7. 如果旋钮太紧，轻轻砂短轴；如果太松，可以在短轴上贴一小圈美纹纸或薄胶带增加阻尼。
8. 背后支架不需要额外拼接或粘胶；它分别随左右模块一起打印出来。

## 打印建议

- 常规拓竹 X1/P1/A1 平台是 256 × 256 mm，完整主体 306 mm 宽，不建议整件平躺打印。
- 建议先打印旋钮配合测试件，确认短轴和盲孔松紧，再打印两盘主体。
- 如果只想确认屏幕开窗尺寸，先打印 1.0 mm 厚的屏幕开窗校准片，不需要支撑。
- 如果想确认完整正面尺寸，打印正面布局薄片校准套件；它把 306 mm 宽的正面拆成左右侧板和上下屏幕边框，一盘可打印，取下后按实际位置摆放比对。
- 网孔区建议先打印网孔配合测试件：左侧一颗标记点是 1.60 mm，中间两颗标记点是 1.75 mm，右侧三颗标记点是 1.90 mm。
- 两盘主体文件：第一盘是屏幕中框、控制块和锁销，第二盘是网孔块、备用锁销和可转动装饰旋钮。
- 打完后先试插中框锁销；锁销孔直径为 2.25 mm，锁销直径为 1.85 mm，如果偏紧可以轻微打磨锁销。
- 不建议用胶水作为主要固定方式；正式装配依靠中框插舌和上下锁销固定。
- 左右模块背面是开腔的，切片时建议保持正面朝下打印；这样外观面平整，背面空腔朝上，不需要额外支撑。
- 主体建议 PETG 或哑光 PLA。
- 层高 0.2 mm，墙线 3 道以上。
- 填充 15% 到 25%。
- 网孔较多，建议降低打印速度，避免小孔糊住。
- 如果要更像成品，可拆成白色外壳、黑色屏幕 bezel、银色旋钮三个零件分别打印或后处理。
- 如果锁销丢失，也可以剪 1.75 mm 耗材临时代替，但正式件优先使用随文件导出的 1.85 mm 锁销。

## 预览注意

- OpenSCAD 的 F5 Preview 可能会显示重叠面、文字和透明占位件的伪影。
- 判断最终几何请用 F6 Render，或者直接查看导出的 STL。
- 如果只想看可打印主体，把 `part` 改成 `shell`；如果想看黑屏装配效果，把 `part` 改成 `assembly`。

## 下一步校准

- 用卡尺确认 Type-C 线头尺寸，必要时放大 `charge_slot_width` / `charge_slot_height`。
- 中央窗口已经按 Nokia N1 真实可视屏幕放大，如果实际装机仍有遮挡，优先微调 `screen_window_width`。
- 如果希望更 Rams、更克制，可以继续缩小 `screen_window_height`，让屏幕更像一条信息窗。
- 大旋钮后续可以预留编码器孔位，例如 EC11 或更大的铝合金旋钮模组。
