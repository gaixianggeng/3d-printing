# P2S PLA 切片

当前完整分盘列表见 [项目入口](../../README.md#当前打印盘)。下文是最初两盘的历史切片记录。后来增加的 `white_controls/`、`gray_rear_parts/`、`gray_cradle/` 是最终按颜色拆分的盘；`remaining_accessories/` 和 `cradle_replacement/` 保留作中间记录。主体已由用户打印并试装通过，但最终实机参数未从打印机导出归档。

使用 Bambu Studio 02.08.02.61。两个工程均按 P2S、0.4 mm 标准流量喷嘴、Generic PLA、纹理 PEI 板配置；喷嘴 220°C、热床 55°C。实际设备配置不同则需重新切片。

- `fit_trial/n1_v4_fit_trial_P2S_PLA.3mf`：固定架与两片压片，共一盘，约 103.1 分钟、45.55 g。用于先验证机身放入和限位区域，不包含完整面板，不能代替最终装配检查。
- `front/n1_v4_front_P2S_PLA.3mf`：完整面板，约 7 小时 59 分钟、230.7 g。

共同设置：0.20 mm 层高、3 层墙、15% 填充、普通自动支撑、8 mm 外侧裙边。没有发送到 3D 打印机。

试装盘初次切片出现 `ZFiller: encounter idx from clip` 诊断。该盘关闭 `detect_floating_vertical_shell` 后重新切片，诊断不再出现；普通自动支撑保持开启。

两个工程最终返回 Success，模型警告为空。日志仍有 `Invalid T command (T65535)`，对应所用 P2S 官方预设结束代码中的退料命令，未改写厂商代码。日志、切片结果和包完整性验证已保留。切片成功不代表已经实机验证打印质量。

压片朝向已修正：大平面朝下。固定架保留自动支撑。单独将两个压片关闭支撑切片验证，没有悬空警告。
