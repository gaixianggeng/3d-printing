// Braun T3 inspired Nokia N1 desktop status dock.
// Units: millimeters.

part = "v2_assembly"; // [v2_assembly, v2_body, v2_screen_frame, v2_left_speaker, v2_right_controls, v2_rear_retainers, v2_bambu_plate_sides, v2_bambu_plate_screen, v2_bambu_plate_retainers, v2_rotary_controls, v2_bambu_plate_knobs, v2_join_fit_test, v2_pocket_fit_test, visual_assembly, modular_assembly, assembly, shell, shell_speaker, shell_speaker_side_down, shell_speaker_support_edge_down, shell_screen, shell_screen_face_up, shell_controls, shell_controls_side_down, shell_controls_support_edge_down, shell_top_rail, shell_bottom_rail, shell_screen_legacy, rotary_controls, rotary_fit_test, front_layout_fit_test, front_slice_test, screen_frame_slice_test, snap_clip_fit_test, speaker_grille_fit_test, rail_lock_pins, bambu_plate_body, bambu_plate_sides, bambu_plate_sides_face_up, bambu_plate_1, bambu_plate_2, bambu_plate_knobs, bambu_plate_screen_frame_slice_test, bambu_plate_front_slice_test, bambu_plate_front_frame_test_1, bambu_plate_front_frame_test_2, split_pins, clips, tablet]

// Nokia N1 dimensions in landscape orientation.
tablet_width = 200.7;
tablet_height = 138.6;
tablet_thickness = 6.9;

// 7.9 inch 4:3 active display, centered on the tablet.
screen_width = 160.53;
screen_height = 120.4;

// Fit and shell depth.
tablet_clearance = 2.4;
front_wall = 4.0;
rear_clearance = 2.4;
body_depth = 40;

// Body proportions. The concept image says 263 x 110 mm, but Nokia N1 is
// 138.6 mm tall, so this printable version is scaled to fit the real tablet.
outer_width = 306;
outer_height = 139;
outer_corner_radius = 3.9;

// Front layout: speaker grille | Nokia N1 screen | controls.
screen_window_width = 162.5;
screen_vertical_margin = 8.8;
screen_window_height = outer_height - 2 * screen_vertical_margin;
screen_corner_radius = 4.5;
screen_bezel_width = 7.5;
screen_center_x = 0;
screen_center_y = 0;

screen_edge_x = screen_window_width / 2;
screen_frame_outer_x = screen_edge_x + screen_bezel_width;
speaker_panel_center_x = (outer_width / 2 + screen_center_x + screen_edge_x) / 2;
controls_panel_center_x = (-outer_width / 2 + screen_center_x - screen_edge_x) / 2;

speaker_center_x = speaker_panel_center_x;
speaker_center_y = 0;
speaker_cols = 12;
speaker_rows = 24;
speaker_pitch = 4.0;
speaker_hole_diameter = 1.90;
speaker_hole_mouth_diameter = 2.25;
speaker_hole_mouth_depth = 0.65;

controls_center_x = controls_panel_center_x;
knob_center_y = 18;
knob_diameter = 32;
knob_raise = 5.2;
knob_chamfer = 1.2;
button_diameter = 6.8;
button_raise = 2.6;
button_spacing = 13.0;
button_center_y = -31;

// Rotating decorative controls. These are printed separately by default and
// sit in blind sockets so the visible controls can rotate without electronics.
separate_rotary_controls = true;
knob_shaft_diameter = 7.8;
knob_socket_diameter = 8.4;
knob_shaft_length = 3.2;
knob_socket_depth = 3.8;
button_shaft_diameter = 3.0;
button_socket_diameter = 3.5;
button_shaft_length = 2.8;
button_socket_depth = 3.4;
knob_shaft_tip_length = 0.6;
knob_shaft_tip_diameter = 7.1;
button_shaft_tip_length = 0.45;
button_shaft_tip_diameter = 2.4;

// Printable split layout for Bambu Lab 256 mm beds.
split_x = screen_window_width / 2 + screen_bezel_width + 5;
split_pin_y_positions = [-55, 55];
split_pin_z = 2.0;
split_pin_hole_diameter = 2.2;
split_pin_hole_length = 24;
split_pin_diameter = 1.85;
split_pin_length = 20;
print_gap = 7;
speaker_piece_bed_lift = 0;
screen_piece_bed_lift = 1.15;
controls_piece_bed_lift = separate_rotary_controls ? 0 : knob_raise + knob_chamfer;
front_slice_test_height = 5.4;
snap_clip_test_inside_width = 28;
snap_clip_test_outside_width = 18;
snap_clip_test_pair_spacing = 28;
snap_clip_test_height = 60;

// Three-piece modular front: left controls, screen frame, right speaker.
// The screen frame uses flat tongues plus edge-inserted locking pins, so no glue is needed.
modular_split_x = screen_frame_outer_x;
rail_tab_overlap = 22;
rail_tab_height = 6.0;
rail_tab_clearance = 0.30;
rail_tab_radius = 1.0;
rail_pin_diameter = 1.85;
rail_pin_hole_diameter = 2.25;
rail_pin_length = 8.4;
rail_pin_hole_length = 9.8;
rail_pin_print_spacing = 12.0;
rail_pin_z = front_wall / 2;
rail_pin_x_abs = modular_split_x + rail_tab_overlap * 0.55;
rail_socket_backer_depth = 4.0;
rail_socket_backer_margin_x = 2.0;
rail_socket_backer_gap_from_tablet = 0.6;
rail_socket_backer_margin_y = 0.35;

// Side modules are open from the rear to reduce material. The front face,
// outer rim, and lock-pin zones remain solid.
lightweight_side_modules = true;
side_shell_wall = 5.5;
side_lightening_margin_y = 13.0;
side_lightening_front_keep = front_wall - 0.02;

// Rear loading pocket and retention clips.
pocket_width = tablet_width + tablet_clearance;
pocket_height = tablet_height + tablet_clearance;
pocket_corner_radius = 6;
use_snap_clips = true;
use_screw_bosses = false;
snap_clip_lip = 4.5;
snap_clip_anchor_width = 6.0;
snap_clip_width = 22;
snap_clip_thickness = 1.8;
snap_clip_clearance_z = 0.45;
screw_clearance_diameter = 3.4;
screw_boss_diameter = 11;
screw_boss_post_diameter = 7.6;
screw_boss_height = 4.0;
clip_length = 34;
clip_width = 11;
clip_thickness = 2.8;
clip_hole_offset = 8;
clip_mount_inset_y = 31;
clip_mount_offset_x = 8.5;

// Charging cutout. OpenSCAD's front render mirrors X, so "left" appears on
// the visual right side of the front view used by this design.
charge_side = "left"; // [right, left, bottom]
charge_slot_width = 34;
charge_slot_height = 11;
charge_offset = 0;
cable_groove_depth = 3.4;
cable_groove_outer_keep = 12;

// Single-color FDM makes raised lettering look like an extra surface layer.
// Use a shallow deboss so the front face stays visually flat.
logo_style = "engraved"; // [engraved, raised, none]
logo_depth = 0.28;

// Rear vents and stand.
rear_vent_cols = 12;
rear_vent_rows = 6;
rear_vent_pitch = 5.2;
rear_vent_slot_width = 3.2;
rear_vent_slot_height = 1.2;
use_kickstand = true;
kickstand_style = "bottom_foot"; // [bottom_foot, triangle]
kickstand_span = 160;
kickstand_height = 72;
kickstand_reach = 58;
kickstand_bottom_lift = 0.5;
kickstand_rib_width = 7;
kickstand_anchor_width = 7;
kickstand_anchor_y_padding = 5;
kickstand_support_x_abs = outer_width / 2 - outer_corner_radius - kickstand_anchor_width / 2 - 2.5;
kickstand_foot_width = 10;
kickstand_foot_depth = 12;
kickstand_foot_height = 8;
stand_tilt_angle = 8;
stand_front_drop = 8.0;
stand_runner_height = 8.0;
stand_runner_width = 10.0;

// 可选的实体临时支撑。Bambu 对这类支撑和主体的重叠边比较敏感，
// 正式打印默认关闭，优先使用切片器自动支撑。
use_side_print_supports = false;
side_print_support_gap = 0.24;
side_print_support_wall = 0.84;
side_print_support_base_overlap = 0.25;
side_print_support_x_offsets = [-2.4, 0, 2.4];
side_print_support_y_padding = 1.8;
side_print_support_bed_x_min = 122;
side_print_support_bed_x_max = 176;

// V2 clean redesign.
// 主体仍然是左 / 中 / 右三块；旧锁销、旧侧向硬卡扣和临时打印支撑都不参与 v2。
v2_join_tab_overlap = 18;
v2_join_tab_height = 6.2;
v2_join_clearance = 0.32;
v2_join_radius = 1.0;
v2_join_backer_depth = 4.8;
v2_pocket_clearance_x = 2.8;
v2_pocket_clearance_y = 1.2;
v2_pocket_width = tablet_width + v2_pocket_clearance_x;
v2_pocket_height = tablet_height + v2_pocket_clearance_y;
v2_pocket_depth = tablet_thickness + 1.0;
v2_use_external_bottom_shelf = false;
v2_show_top_retainer_bars = false;
v2_use_rear_screw_retainers = false;
v2_bottom_lip_height = 3.8;
v2_top_lip_height = 2.8;
v2_side_lip_width = 0.8;
v2_side_lip_height = 94;
v2_lip_z_clearance = 0.75;
v2_use_rear_side_capture_lips = true;
v2_rear_capture_lip_overlap = 7.0;
v2_rear_capture_lip_anchor = 5.0;
v2_rear_capture_lip_height = 30;
v2_rear_capture_lip_gap = 0.45;
v2_rear_capture_lip_thickness = 2.2;
v2_rear_capture_lip_y = tablet_height / 2 - 27;
v2_use_bottom_corner_supports = true;
v2_bottom_support_overlap_x = 9.0;
v2_bottom_support_anchor_x = 6.0;
v2_bottom_support_height = 2.2;
v2_bottom_support_clearance_y = 0.25;
v2_bottom_support_depth_extra = 0.45;
v2_bottom_support_bridge_width = 3.0;
v2_tilt_angle = 8;
v2_tilt_runner_height = 7.5;
v2_tilt_runner_front_drop = 7.0;
v2_tilt_runner_z0 = -5;
v2_tilt_runner_z1 = body_depth + 54;
v2_screen_bed_lift = screen_piece_bed_lift;
v2_pocket_test_bed_lift = screen_piece_bed_lift;
v2_side_print_x_left = 72;
v2_side_print_x_right = 184;
v2_retainer_boss_x = v2_pocket_width / 2 + 5.5;
v2_retainer_boss_y = v2_pocket_height / 2 - 27;
v2_retainer_boss_diameter = 11;
v2_retainer_boss_depth = 6;
v2_retainer_pilot_diameter = 2.7;
v2_retainer_bridge_height = 13.5;
v2_retainer_bridge_pocket_gap = 0.8;
v2_retainer_clip_length = 36;
v2_retainer_clip_width = 8;
v2_retainer_clip_thickness = 2.4;
v2_retainer_clip_screw_offset = 8;
v2_retainer_clip_hole_diameter = 3.4;
v2_retainer_clip_rear_gap = 0.25;

show_tablet_in_assembly = true;

$fn = 56;
eps = 0.05;
$vpt = [0, 0, 22];
$vpr = [58, 0, 26];
$vpd = 560;

side_piece_print_max_z = body_depth / 2 + (body_depth + kickstand_reach + knob_raise + 30) / 2;
side_piece_width = outer_width / 2 - modular_split_x;
side_piece_side_down_lift = side_piece_width / 2 + 0.08;
side_piece_support_edge_down_y_lift = side_piece_print_max_z / 2;
side_piece_support_edge_down_z_lift = outer_height / 2 + 0.08;
side_down_controls_plate_x = 74;
side_down_speaker_plate_x = 184;
side_down_plate_y = 128;
side_down_clip_z_min = front_wall;
side_down_clip_z_max = front_wall + tablet_thickness + snap_clip_clearance_z + snap_clip_thickness;
side_down_clip_support_x = side_down_clip_z_max - side_down_clip_z_min + 1.2;
side_down_clip_support_y = snap_clip_width - 3.0;
side_down_clip_support_top_overlap = 0.18;
side_down_clip_local_x = (modular_split_x + outer_width / 2) / 2 - (pocket_width / 2 + snap_clip_anchor_width / 2);
side_down_clip_support_height = side_piece_side_down_lift - side_down_clip_local_x + side_down_clip_support_top_overlap;
side_wall_right = outer_width / 2 - (screen_center_x + pocket_width / 2);
side_wall_left = (screen_center_x - pocket_width / 2) + outer_width / 2;
bottom_wall = outer_height / 2 - pocket_height / 2;
charge_z = front_wall + tablet_thickness / 2;

module rounded_rect_2d(w, h, r) {
    rr = min(r, min(w, h) / 2);
    hull() {
        for (x = [-w / 2 + rr, w / 2 - rr])
            for (y = [-h / 2 + rr, h / 2 - rr])
                translate([x, y]) circle(r = rr);
    }
}

module rounded_box_xy(w, h, d, r) {
    linear_extrude(height = d) rounded_rect_2d(w, h, r);
}

module rounded_ring_xy(outer_w, outer_h, inner_w, inner_h, d, outer_r, inner_r) {
    linear_extrude(height = d) difference() {
        rounded_rect_2d(outer_w, outer_h, outer_r);
        rounded_rect_2d(inner_w, inner_h, inner_r);
    }
}

module front_screen_2d() {
    translate([screen_center_x, screen_center_y])
        rounded_rect_2d(screen_window_width, screen_window_height, screen_corner_radius);
}

module front_screen_cut() {
    translate([0, 0, -knob_raise - eps])
        linear_extrude(height = body_depth + knob_raise + 2 * eps)
            front_screen_2d();
}

module tablet_pocket_cut() {
    translate([screen_center_x, screen_center_y, front_wall])
        linear_extrude(height = body_depth - front_wall + eps)
            rounded_rect_2d(pocket_width, pocket_height, pocket_corner_radius);
}

module screen_bezel() {
    translate([screen_center_x, screen_center_y, -1.15])
        rounded_ring_xy(
            screen_window_width + 2 * screen_bezel_width,
            screen_window_height + 2 * screen_bezel_width,
            screen_window_width,
            screen_window_height,
            1.25,
            screen_corner_radius + screen_bezel_width,
            screen_corner_radius
        );
}

module screen_glass_preview() {
    color([0.015, 0.015, 0.014, 0.92])
        translate([screen_center_x, screen_center_y, -1.25])
            linear_extrude(height = 0.35)
                rounded_rect_2d(screen_window_width, screen_window_height, screen_corner_radius);
}

module speaker_holes_cut() {
    for (cx = [0 : speaker_cols - 1])
        for (ry = [0 : speaker_rows - 1])
            translate([
                speaker_center_x + (cx - (speaker_cols - 1) / 2) * speaker_pitch,
                speaker_center_y + (ry - (speaker_rows - 1) / 2) * speaker_pitch,
                -eps
            ])
                union() {
                    cylinder(h = front_wall + 2 * eps, d = speaker_hole_diameter);
                    cylinder(
                        h = speaker_hole_mouth_depth + eps,
                        d1 = speaker_hole_mouth_diameter,
                        d2 = speaker_hole_diameter
                    );
                }
}

module speaker_dark_preview() {
    color([0.02, 0.02, 0.018, 1])
        for (cx = [0 : speaker_cols - 1])
            for (ry = [0 : speaker_rows - 1])
                translate([
                    speaker_center_x + (cx - (speaker_cols - 1) / 2) * speaker_pitch,
                    speaker_center_y + (ry - (speaker_rows - 1) / 2) * speaker_pitch,
                    -0.7
                ])
                    cylinder(h = 0.22, d = speaker_hole_diameter * 1.05);
}

module controls() {
    translate([controls_center_x, knob_center_y, -knob_raise])
        cylinder(h = knob_raise + 0.2, d = knob_diameter);
    translate([controls_center_x, knob_center_y, -knob_raise - knob_chamfer])
        cylinder(h = knob_chamfer, d1 = knob_diameter - 2.2, d2 = knob_diameter);

    for (i = [-1, 0, 1])
        translate([controls_center_x + i * button_spacing, button_center_y, -button_raise])
            cylinder(h = button_raise + 0.2, d = button_diameter);
}

module control_socket_cuts() {
    translate([controls_center_x, knob_center_y, -eps])
        cylinder(h = knob_socket_depth + eps, d = knob_socket_diameter);

    for (i = [-1, 0, 1])
        translate([controls_center_x + i * button_spacing, button_center_y, -eps])
            cylinder(h = button_socket_depth + eps, d = button_socket_diameter);
}

module rotating_knob_assembly() {
    translate([controls_center_x, knob_center_y, -knob_raise])
        cylinder(h = knob_raise + 0.2, d = knob_diameter);
    translate([controls_center_x, knob_center_y, -knob_raise - knob_chamfer])
        cylinder(h = knob_chamfer, d1 = knob_diameter - 2.2, d2 = knob_diameter);
    translate([controls_center_x, knob_center_y, 0])
        cylinder(h = knob_shaft_length, d = knob_shaft_diameter);
}

module rotating_button_assembly(x) {
    translate([x, button_center_y, -button_raise])
        cylinder(h = button_raise + 0.2, d = button_diameter);
    translate([x, button_center_y, 0])
        cylinder(h = button_shaft_length, d = button_shaft_diameter);
}

module rotating_controls_assembly() {
    rotating_knob_assembly();
    for (i = [-1, 0, 1])
        rotating_button_assembly(controls_center_x + i * button_spacing);
}

module printable_large_knob() {
    cylinder(h = knob_chamfer, d1 = knob_diameter - 2.2, d2 = knob_diameter);
    translate([0, 0, knob_chamfer])
        cylinder(h = knob_raise, d = knob_diameter);
    translate([0, 0, knob_chamfer + knob_raise])
        cylinder(h = knob_shaft_length, d = knob_shaft_diameter);
}

module printable_small_knob() {
    cylinder(h = button_raise, d = button_diameter);
    translate([0, 0, button_raise])
        cylinder(h = button_shaft_length, d = button_shaft_diameter);
}

module rotary_controls_set() {
    translate([-26, 0, 0])
        printable_large_knob();
    for (i = [-1, 0, 1])
        translate([20 + i * 13, 0, 0])
            printable_small_knob();
}

module bambu_plate_knobs() {
    translate([128, 128, 0])
        rotary_controls_set();
}

// V2 旋钮按当前右侧模块的盲孔尺寸设计：保留可转动间隙，
// 并在插入柱末端做导入倒角，减少装配时对孔口的磨损。
module v2_printable_large_knob() {
    cylinder(h = knob_chamfer, d1 = knob_diameter - 2.2, d2 = knob_diameter);
    translate([0, 0, knob_chamfer])
        cylinder(h = knob_raise, d = knob_diameter);
    translate([0, 0, knob_chamfer + knob_raise]) {
        cylinder(h = knob_shaft_length - knob_shaft_tip_length, d = knob_shaft_diameter);
        translate([0, 0, knob_shaft_length - knob_shaft_tip_length])
            cylinder(h = knob_shaft_tip_length, d1 = knob_shaft_diameter, d2 = knob_shaft_tip_diameter);
    }
}

module v2_printable_small_knob() {
    cylinder(h = button_raise, d = button_diameter);
    translate([0, 0, button_raise]) {
        cylinder(h = button_shaft_length - button_shaft_tip_length, d = button_shaft_diameter);
        translate([0, 0, button_shaft_length - button_shaft_tip_length])
            cylinder(h = button_shaft_tip_length, d1 = button_shaft_diameter, d2 = button_shaft_tip_diameter);
    }
}

module v2_rotary_controls_set() {
    translate([-26, 0, 0])
        v2_printable_large_knob();
    for (i = [-1, 0, 1])
        translate([20 + i * 13, 0, 0])
            v2_printable_small_knob();
}

module v2_bambu_plate_knobs() {
    translate([128, 128, 0])
        v2_rotary_controls_set();
}

module rotary_fit_socket_plate() {
    difference() {
        rounded_box_xy(86, 34, 5, 2);
        translate([-26, 0, 5 - knob_socket_depth])
            cylinder(h = knob_socket_depth + eps, d = knob_socket_diameter);
        for (i = [-1, 0, 1])
            translate([20 + i * 13, 0, 5 - button_socket_depth])
                cylinder(h = button_socket_depth + eps, d = button_socket_diameter);
    }
}

module rotary_fit_test() {
    translate([0, -26, 0])
        rotary_fit_socket_plate();
    translate([0, 26, 0])
        rotary_controls_set();
}

module grille_test_hole_grid(x0, hole_diameter) {
    for (cx = [0:5])
        for (ry = [0:7])
            translate([
                x0 + (cx - 2.5) * speaker_pitch,
                3 + (ry - 3.5) * speaker_pitch,
                -eps
            ])
                cylinder(h = 3.2 + 2 * eps, d = hole_diameter);
}

module grille_test_marker_dots(x0, count) {
    for (i = [0:count - 1])
        translate([x0 + (i - (count - 1) / 2) * 3.2, -21, 3.2])
            cylinder(h = 0.45, d = 1.25);
}

module speaker_grille_fit_test() {
    difference() {
        rounded_box_xy(118, 50, 3.2, 2);
        grille_test_hole_grid(-38, 1.60);
        grille_test_hole_grid(0, 1.75);
        grille_test_hole_grid(38, 1.90);
    }
    grille_test_marker_dots(-38, 1);
    grille_test_marker_dots(0, 2);
    grille_test_marker_dots(38, 3);
}

module screen_window_fit_test() {
    rounded_ring_xy(
        screen_window_width + 2 * screen_bezel_width,
        screen_window_height + 2 * screen_bezel_width,
        screen_window_width,
        screen_window_height,
        1.0,
        screen_corner_radius + screen_bezel_width,
        screen_corner_radius
    );
}

module front_fit_segment_2d(x_min, x_max, y_min, y_max) {
    intersection() {
        rounded_rect_2d(outer_width, outer_height, outer_corner_radius);
        translate([(x_min + x_max) / 2, (y_min + y_max) / 2])
            square([x_max - x_min, y_max - y_min], center = true);
    }
}

module front_fit_speaker_panel() {
    difference() {
        linear_extrude(height = 1.0)
            front_fit_segment_2d(screen_edge_x, outer_width / 2, -outer_height / 2, outer_height / 2);
        speaker_holes_cut();
    }
}

module front_fit_controls_panel() {
    linear_extrude(height = 1.0)
        front_fit_segment_2d(-outer_width / 2, -screen_edge_x, -outer_height / 2, outer_height / 2);

    translate([controls_center_x, knob_center_y, 1.0])
        cylinder(h = 0.6, d = knob_diameter);
    for (i = [-1, 0, 1])
        translate([controls_center_x + i * button_spacing, button_center_y, 1.0])
            cylinder(h = 0.45, d = button_diameter);
}

module front_fit_screen_bar(y_min, y_max) {
    linear_extrude(height = 1.0)
        front_fit_segment_2d(-screen_edge_x, screen_edge_x, y_min, y_max);
}

module front_layout_fit_test() {
    translate([86, 82, 0])
        translate([-(-outer_width / 2 + screen_edge_x) / 2, 0, 0])
            front_fit_controls_panel();

    translate([170, 82, 0])
        translate([-(outer_width / 2 + screen_edge_x) / 2, 0, 0])
            front_fit_speaker_panel();

    translate([128, 171, 0])
        translate([0, -(outer_height / 2 + screen_window_height / 2) / 2, 0])
            front_fit_screen_bar(screen_window_height / 2, outer_height / 2);

    translate([128, 187, 0])
        translate([0, -(-outer_height / 2 - screen_window_height / 2) / 2, 0])
            front_fit_screen_bar(-outer_height / 2, -screen_window_height / 2);
}

module logo_text_3d(depth) {
    translate([-outer_width / 2 + 25, outer_height / 2 - 22, -0.45])
        linear_extrude(height = depth)
            mirror([1, 0, 0])
                text("BRAUN", size = 4.2, halign = "center", valign = "center", font = "Helvetica:style=Bold");
}

module logo_mark() {
    if (logo_style == "raised")
        logo_text_3d(0.5);
}

module logo_cut() {
    if (logo_style == "engraved")
        translate([0, 0, -eps])
            linear_extrude(height = logo_depth + eps)
                translate([-outer_width / 2 + 25, outer_height / 2 - 22])
                    mirror([1, 0, 0])
                        text("BRAUN", size = 4.2, halign = "center", valign = "center", font = "Helvetica:style=Bold");
}

module charge_cutout() {
    if (charge_side == "right") {
        translate([
            screen_center_x + pocket_width / 2 + side_wall_right / 2,
            charge_offset,
            charge_z
        ])
            cube([side_wall_right + 2 * eps, charge_slot_width, charge_slot_height], center = true);
    } else if (charge_side == "left") {
        translate([
            screen_center_x - pocket_width / 2 - side_wall_left / 2,
            charge_offset,
            charge_z
        ])
            cube([side_wall_left + 2 * eps, charge_slot_width, charge_slot_height], center = true);
    } else {
        translate([screen_center_x, -outer_height / 2 + bottom_wall / 2, charge_z])
            cube([charge_slot_width, bottom_wall + 2 * eps, charge_slot_height], center = true);
    }
}

module cable_groove_cut() {
    if (charge_side == "right") {
        let (groove_w = max(side_wall_right - cable_groove_outer_keep, 1))
            translate([
                outer_width / 2 - cable_groove_outer_keep - groove_w / 2,
                -outer_height / 2 + 35,
                body_depth - cable_groove_depth / 2 + eps
            ])
                cube([groove_w + 2 * eps, 70, cable_groove_depth + 2 * eps], center = true);
    } else if (charge_side == "left") {
        let (groove_w = max(side_wall_left - cable_groove_outer_keep, 1))
            translate([
                -outer_width / 2 + cable_groove_outer_keep + groove_w / 2,
                -outer_height / 2 + 35,
                body_depth - cable_groove_depth / 2 + eps
            ])
                cube([groove_w + 2 * eps, 70, cable_groove_depth + 2 * eps], center = true);
    } else {
        translate([screen_center_x, -outer_height / 2 + bottom_wall / 2, body_depth - cable_groove_depth / 2 + eps])
            cube([charge_slot_width + 22, bottom_wall + 2 * eps, cable_groove_depth + 2 * eps], center = true);
    }
}

module side_lightening_cut(side) {
    side_x0 = side > 0 ? modular_split_x : -outer_width / 2;
    side_x1 = side > 0 ? outer_width / 2 : -modular_split_x;
    cut_w = (side_x1 - side_x0) - 2 * side_shell_wall;
    cut_h = outer_height - 2 * side_lightening_margin_y;
    cut_z = side_lightening_front_keep;

    if (lightweight_side_modules && cut_w > 0 && cut_h > 0)
        translate([(side_x0 + side_x1) / 2, 0, cut_z])
            rounded_box_xy(cut_w, cut_h, body_depth - cut_z + eps, 2.5);
}

module side_lightening_cuts() {
    for (side = [-1, 1])
        side_lightening_cut(side);
}

module rear_vent_cuts() {
    for (cx = [0 : rear_vent_cols - 1])
        for (ry = [0 : rear_vent_rows - 1])
            translate([
                screen_center_x + (cx - (rear_vent_cols - 1) / 2) * rear_vent_pitch,
                -outer_height / 2 + 24 + ry * rear_vent_pitch,
                body_depth - eps
            ])
                rounded_box_xy(rear_vent_slot_width, rear_vent_slot_height, 1.2 + eps, 0.5);
}

module clip_positions() {
    for (sx = [-1, 1])
        for (sy = [-1, 1])
            translate([
                screen_center_x + sx * (pocket_width / 2 + clip_mount_offset_x),
                sy * (pocket_height / 2 - clip_mount_inset_y),
                0
            ]) children();
}

module screw_bosses() {
    clip_positions()
        translate([0, 0, body_depth - screw_boss_height])
            cylinder(h = screw_boss_height, d = screw_boss_diameter);
}

module screw_boss_supports() {
    clip_positions()
        translate([0, 0, front_wall - eps])
            cylinder(h = body_depth - front_wall + 2 * eps, d = screw_boss_post_diameter);
}

module screw_holes() {
    clip_positions()
        translate([0, 0, body_depth - screw_boss_height - eps])
            cylinder(h = screw_boss_height + 2 * eps, d = screw_clearance_diameter);
}

module snap_clip_at(side, y) {
    clip_z = front_wall + tablet_thickness + snap_clip_clearance_z;
    root_x = side * (pocket_width / 2 + snap_clip_anchor_width / 2);
    lip_x = side * (pocket_width / 2 + (snap_clip_anchor_width - snap_clip_lip) / 2);

    translate([root_x, y, front_wall - eps])
        rounded_box_xy(
            snap_clip_anchor_width,
            snap_clip_width,
            clip_z - front_wall + snap_clip_thickness + 2 * eps,
            1.5
        );

    translate([lip_x, y, clip_z])
        rounded_box_xy(
            snap_clip_anchor_width + snap_clip_lip,
            snap_clip_width,
            snap_clip_thickness,
            1.5
        );
}

module tablet_snap_clips() {
    for (sx = [-1, 1])
        for (sy = [-1, 1])
            snap_clip_at(sx, sy * (pocket_height / 2 - clip_mount_inset_y));
}

module triangular_prism_x(width, p0, p1, p2) {
    x0 = -width / 2;
    x1 = width / 2;
    polyhedron(
        points = [
            [x0, p0[0], p0[1]], [x0, p1[0], p1[1]], [x0, p2[0], p2[1]],
            [x1, p0[0], p0[1]], [x1, p1[0], p1[1]], [x1, p2[0], p2[1]]
        ],
        faces = [
            [0, 2, 1], [3, 4, 5],
            [0, 1, 4, 3], [1, 2, 5, 4], [2, 0, 3, 5]
        ]
    );
}

module quadrilateral_prism_x(width, p0, p1, p2, p3) {
    x0 = -width / 2;
    x1 = width / 2;
    polyhedron(
        points = [
            [x0, p0[0], p0[1]], [x0, p1[0], p1[1]], [x0, p2[0], p2[1]], [x0, p3[0], p3[1]],
            [x1, p0[0], p0[1]], [x1, p1[0], p1[1]], [x1, p2[0], p2[1]], [x1, p3[0], p3[1]]
        ],
        faces = [
            [0, 3, 2, 1], [4, 5, 6, 7],
            [0, 1, 5, 4], [1, 2, 6, 5], [2, 3, 7, 6], [3, 0, 4, 7]
        ]
    );
}

module prism_y_from_xz(points, width) {
    translate([0, width / 2, 0])
        rotate([90, 0, 0])
            linear_extrude(height = width)
                polygon(points = points);
}

function kickstand_local_y0() = -outer_height / 2 + kickstand_bottom_lift;
function stand_contact_y(z) = -outer_height / 2 - stand_front_drop + z * tan(stand_tilt_angle);
function kickstand_support_top_z_for_bed_x(x, z_lift) =
    body_depth + kickstand_reach
        - ((128 - x) - kickstand_local_y0()) * kickstand_reach / kickstand_height
        + z_lift
        - side_print_support_gap;

module plate_kickstand_print_support(y_center, z_lift) {
    if (use_side_print_supports && use_kickstand) {
        x0 = side_print_support_bed_x_min;
        x1 = side_print_support_bed_x_max;
        base_z = front_wall + z_lift - side_print_support_base_overlap;
        support_points = [
            [x0, base_z],
            [x1, base_z],
            [x1, kickstand_support_top_z_for_bed_x(x1, z_lift)],
            [x0, kickstand_support_top_z_for_bed_x(x0, z_lift)]
        ];

        // 出片坐标里的三条可拆支撑肋：左右侧模块共用同一形状，避免切片器自动生成不一致。
        for (dy = side_print_support_x_offsets)
            translate([0, y_center + dy, 0])
                prism_y_from_xz(support_points, side_print_support_wall);
    }
}

module tilted_base_runner(side) {
    z0 = 0;
    z1 = body_depth + kickstand_reach;
    y0 = stand_contact_y(z0);
    y1 = stand_contact_y(z1);

    // 连续倾斜底脚决定整机后仰角度；前端比机身底边低一点，避免原本平底抢先触桌。
    translate([side * kickstand_support_x_abs, 0, 0])
        quadrilateral_prism_x(
            stand_runner_width,
            [y0, z0],
            [y1, z1],
            [y1 + stand_runner_height, z1],
            [y0 + stand_runner_height, z0]
        );
}

module kickstand() {
    if (use_kickstand) {
        y0 = kickstand_local_y0();
        y1 = y0 + kickstand_height;
        z0 = body_depth - 1;
        z1 = body_depth + kickstand_reach;
        anchor_h = kickstand_height + kickstand_anchor_y_padding;
        for (side = [-1, 1]) {
            x = side * kickstand_support_x_abs;

            translate([x, y0 + anchor_h / 2, front_wall - eps])
                rounded_box_xy(
                    kickstand_anchor_width,
                    anchor_h,
                    body_depth - front_wall + 2 * eps,
                    2
                );

            if (kickstand_style == "triangle") {
                translate([x, 0, 0])
                    triangular_prism_x(kickstand_rib_width, [y0, z0], [y1, z0], [y0, z1]);

                translate([x, -outer_height / 2 + kickstand_foot_depth / 2, z1 - 5])
                    rounded_box_xy(kickstand_foot_width, kickstand_foot_depth, kickstand_foot_height, 2.5);
            } else {
                tilted_base_runner(side);
            }
        }
    }
}

module side_piece_print_supports(side) {
    if (use_side_print_supports && use_kickstand) {
        y0 = -outer_height / 2 + 7 + side_print_support_y_padding;
        support_h = body_depth - 1 - front_wall - side_print_support_gap;
        support_y = kickstand_height - 2 * side_print_support_y_padding;
        x = side * kickstand_support_x_abs;

        // 三条薄支撑墙托住后支架的底边，顶部留 0.24mm 间隙方便拆除。
        for (dx = side_print_support_x_offsets)
            translate([x + dx, y0 + support_y / 2, front_wall])
                rounded_box_xy(
                    side_print_support_wall,
                    support_y,
                    support_h,
                    0.25
                );
    }
}

module shell_body() {
    difference() {
        union() {
            difference() {
                union() {
                    rounded_box_xy(outer_width, outer_height, body_depth, outer_corner_radius);
                    screen_bezel();
                    if (!separate_rotary_controls) controls();
                    logo_mark();
                }
                front_screen_cut();
                tablet_pocket_cut();
                side_lightening_cuts();
                speaker_holes_cut();
                if (separate_rotary_controls) control_socket_cuts();
                logo_cut();
            }
            if (use_snap_clips) tablet_snap_clips();
            if (use_screw_bosses) {
                screw_boss_supports();
                screw_bosses();
            }
            kickstand();
        }
        charge_cutout();
        cable_groove_cut();
        rear_vent_cuts();
        if (use_screw_bosses) screw_holes();
    }
}

module shell_body_visual_preview() {
    difference() {
        union() {
            difference() {
                union() {
                    rounded_box_xy(outer_width, outer_height, body_depth, outer_corner_radius);
                    screen_bezel();
                    if (!separate_rotary_controls) controls();
                    logo_mark();
                }
                front_screen_cut();
                tablet_pocket_cut();
                side_lightening_cuts();
                if (separate_rotary_controls) control_socket_cuts();
                logo_cut();
            }
            if (use_snap_clips) tablet_snap_clips();
            if (use_screw_bosses) {
                screw_boss_supports();
                screw_bosses();
            }
            kickstand();
        }
        charge_cutout();
        cable_groove_cut();
        rear_vent_cuts();
        if (use_screw_bosses) screw_holes();
    }
}

function rail_inner_y(is_top) = is_top ? screen_window_height / 2 : -screen_window_height / 2;
function rail_outer_y(is_top) = is_top ? outer_height / 2 : -outer_height / 2;
function rail_center_y(is_top) = (rail_inner_y(is_top) + rail_outer_y(is_top)) / 2;
function rail_height(is_top) = abs(rail_outer_y(is_top) - rail_inner_y(is_top));
function rail_pin_center_y(is_top, length) =
    is_top ? outer_height / 2 - length / 2 : -outer_height / 2 + length / 2;

module rail_tab_2d(side, is_top, clearance = 0) {
    translate([
        side * (modular_split_x + rail_tab_overlap / 2),
        rail_center_y(is_top)
    ])
        rounded_rect_2d(
            rail_tab_overlap + 2 * clearance,
            rail_tab_height + 2 * clearance,
            rail_tab_radius + clearance
        );
}

module rail_tab_solid(side, is_top) {
    linear_extrude(height = front_wall)
        rail_tab_2d(side, is_top);
}

module rail_tab_socket_cut(side, is_top) {
    translate([0, 0, -eps])
        linear_extrude(height = front_wall + 2 * eps)
            rail_tab_2d(side, is_top, rail_tab_clearance);
}

module rail_socket_backer(side, is_top) {
    tablet_edge_x = side * (pocket_width / 2 + rail_socket_backer_gap_from_tablet);
    outer_edge_x = side * (modular_split_x + rail_tab_overlap + rail_socket_backer_margin_x);
    backer_w = abs(outer_edge_x - tablet_edge_x);
    backer_h = rail_height(is_top) - 2 * rail_socket_backer_margin_y;

    // 只在平板口袋外侧加厚，避免挡住 Nokia N1，同时给插槽薄边提供背后支撑。
    if (backer_w > 0 && backer_h > 0)
        translate([(tablet_edge_x + outer_edge_x) / 2, rail_center_y(is_top), front_wall - eps])
            linear_extrude(height = rail_socket_backer_depth + eps)
                rounded_rect_2d(backer_w, backer_h, rail_tab_radius + 0.5);
}

module rail_lock_pin_hole_at(side, is_top) {
    translate([
        side * rail_pin_x_abs,
        rail_pin_center_y(is_top, rail_pin_hole_length),
        rail_pin_z
    ])
        rotate([90, 0, 0])
            cylinder(h = rail_pin_hole_length + 2 * eps, d = rail_pin_hole_diameter, center = true);
}

module rail_lock_pin_at(side, is_top) {
    translate([
        side * rail_pin_x_abs,
        rail_pin_center_y(is_top, rail_pin_length),
        rail_pin_z
    ])
        rotate([90, 0, 0])
            cylinder(h = rail_pin_length, d = rail_pin_diameter, center = true);
}

module rail_lock_pin() {
    // 锁销单独打印时横躺在热床上，避免细圆柱竖打印导致悬空/附着差。
    translate([-rail_pin_length / 2, 0, rail_pin_diameter / 2])
        rotate([0, 90, 0])
            cylinder(h = rail_pin_length, d = rail_pin_diameter);
}

module rail_lock_pin_set() {
    for (i = [0:5])
        translate([(i - 2.5) * rail_pin_print_spacing, 0, 0])
            rail_lock_pin();
}

module modular_side_piece(side) {
    x_min = side > 0 ? modular_split_x : -outer_width / 2 - eps;
    x_max = side > 0 ? outer_width / 2 + eps : -modular_split_x;

    difference() {
        union() {
            intersection() {
                shell_body();
                translate([(x_min + x_max) / 2, 0, body_depth / 2])
                    cube([
                        x_max - x_min,
                        outer_height + 40,
                        body_depth + kickstand_reach + knob_raise + 30
                    ], center = true);
            }

            for (is_top = [false, true])
                rail_socket_backer(side, is_top);
        }

        for (is_top = [false, true]) {
            rail_tab_socket_cut(side, is_top);
            rail_lock_pin_hole_at(side, is_top);
        }
    }
}

module modular_screen_frame_piece() {
    difference() {
        union() {
            intersection() {
                shell_body();
                translate([0, 0, body_depth / 2])
                    cube([
                        2 * modular_split_x + 2 * eps,
                        outer_height + 40,
                        body_depth + kickstand_reach + knob_raise + 30
                    ], center = true);
            }

            for (side = [-1, 1])
                for (is_top = [false, true])
                    rail_tab_solid(side, is_top);
        }

        for (side = [-1, 1])
            for (is_top = [false, true])
                rail_lock_pin_hole_at(side, is_top);
    }
}

module modular_rail_piece(is_top) {
    difference() {
        union() {
            intersection() {
                shell_body();
                translate([0, rail_center_y(is_top), body_depth / 2])
                    cube([
                        2 * modular_split_x + 2 * eps,
                        rail_height(is_top) + 2 * eps,
                        body_depth + kickstand_reach + knob_raise + 30
                    ], center = true);
            }

            for (side = [-1, 1])
                rail_tab_solid(side, is_top);
        }

        for (side = [-1, 1])
            rail_lock_pin_hole_at(side, is_top);
    }
}

module modular_shell_assembly() {
    modular_side_piece(-1);
    modular_side_piece(1);
    modular_screen_frame_piece();

    color([0.88, 0.88, 0.84, 1])
        for (side = [-1, 1])
            for (is_top = [false, true])
                rail_lock_pin_at(side, is_top);
}

module split_pin_hole_at(x, y) {
    translate([x - split_pin_hole_length / 2, y, split_pin_z])
        rotate([0, 90, 0])
            cylinder(h = split_pin_hole_length, d = split_pin_hole_diameter);
}

module split_pin_holes() {
    for (sx = [-split_x, split_x])
        for (py = split_pin_y_positions)
            split_pin_hole_at(sx, py);
}

module split_shell_body() {
    difference() {
        shell_body();
        split_pin_holes();
    }
}

module split_piece(x_min, x_max) {
    intersection() {
        split_shell_body();
        translate([(x_min + x_max) / 2, 0, body_depth / 2])
            cube([
                x_max - x_min,
                outer_height + 40,
                body_depth + kickstand_reach + knob_raise + 30
            ], center = true);
    }
}

module split_piece_centered(x_min, x_max) {
    translate([-(x_min + x_max) / 2, 0, 0])
        split_piece(x_min, x_max);
}

module speaker_piece_legacy_for_bed() {
    translate([0, 0, speaker_piece_bed_lift])
        split_piece_centered(split_x, outer_width / 2 + eps);
}

module screen_piece_legacy_for_bed() {
    translate([0, 0, screen_piece_bed_lift])
        split_piece_centered(-split_x, split_x);
}

module controls_piece_legacy_for_bed() {
    translate([0, 0, controls_piece_bed_lift])
        split_piece_centered(-outer_width / 2 - eps, -split_x);
}

module speaker_piece_for_bed() {
    translate([-(modular_split_x + outer_width / 2) / 2, 0, speaker_piece_bed_lift])
        modular_side_piece(1);
}

module speaker_piece_face_up_for_bed() {
    translate([0, 0, side_piece_print_max_z])
        mirror([0, 0, 1])
            speaker_piece_for_bed();
}

module speaker_piece_side_down_for_bed() {
    translate([side_piece_print_max_z / 2, 0, side_piece_side_down_lift])
        rotate([0, -90, 0])
            speaker_piece_for_bed();
}

module speaker_piece_support_edge_down_for_bed() {
    translate([0, side_piece_support_edge_down_y_lift, side_piece_support_edge_down_z_lift])
        rotate([90, 0, 0])
            speaker_piece_for_bed();
}

module speaker_piece_supports_for_bed() {
    translate([-(modular_split_x + outer_width / 2) / 2, 0, speaker_piece_bed_lift])
        side_piece_print_supports(1);
}

module screen_piece_for_bed() {
    translate([0, 0, screen_piece_bed_lift])
        modular_screen_frame_piece();
}

module screen_piece_face_up_for_bed() {
    translate([0, 0, front_wall + screen_piece_bed_lift])
        mirror([0, 0, 1])
            screen_piece_for_bed();
}

module controls_piece_for_bed() {
    translate([(modular_split_x + outer_width / 2) / 2, 0, controls_piece_bed_lift])
        modular_side_piece(-1);
}

module controls_piece_face_up_for_bed() {
    translate([0, 0, side_piece_print_max_z])
        mirror([0, 0, 1])
            controls_piece_for_bed();
}

module controls_piece_side_down_for_bed() {
    translate([-side_piece_print_max_z / 2, 0, side_piece_side_down_lift])
        rotate([0, 90, 0])
            controls_piece_for_bed();
}

module controls_piece_support_edge_down_for_bed() {
    translate([0, side_piece_support_edge_down_y_lift, side_piece_support_edge_down_z_lift])
        rotate([90, 0, 0])
            controls_piece_for_bed();
}

module controls_piece_supports_for_bed() {
    translate([(modular_split_x + outer_width / 2) / 2, 0, controls_piece_bed_lift])
        side_piece_print_supports(-1);
}

module side_down_clip_bed_supports(plate_x, is_controls) {
    x_center = is_controls
        ? plate_x - side_piece_print_max_z / 2 + (side_down_clip_z_min + side_down_clip_z_max) / 2
        : plate_x + side_piece_print_max_z / 2 - (side_down_clip_z_min + side_down_clip_z_max) / 2;

    for (sy = [-1, 1])
        translate([
            x_center,
            side_down_plate_y + sy * (pocket_height / 2 - clip_mount_inset_y),
            side_down_clip_support_height / 2
        ])
            rounded_box_xy(
                side_down_clip_support_x,
                side_down_clip_support_y,
                side_down_clip_support_height,
                0.8
            );
}

module top_rail_piece_for_bed() {
    translate([0, -rail_center_y(true), screen_piece_bed_lift])
        modular_rail_piece(true);
}

module bottom_rail_piece_for_bed() {
    translate([0, -rail_center_y(false), screen_piece_bed_lift])
        modular_rail_piece(false);
}

module front_slice_crop() {
    intersection() {
        children();
        translate([0, 0, front_slice_test_height / 2])
            cube([outer_width + 80, outer_height + 80, front_slice_test_height], center = true);
    }
}

module screen_slice_test_for_bed() {
    front_slice_crop()
        screen_piece_for_bed();
}

module controls_slice_test_for_bed() {
    front_slice_crop()
        controls_piece_for_bed();
}

module speaker_slice_test_for_bed() {
    front_slice_crop()
        speaker_piece_for_bed();
}

module front_slice_test() {
    screen_slice_test_for_bed();
    controls_slice_test_for_bed();
    speaker_slice_test_for_bed();
}

module screen_frame_slice_test() {
    screen_window_fit_test();
}

module snap_clip_test_clip(y) {
    clip_z = front_wall + tablet_thickness + snap_clip_clearance_z;

    translate([snap_clip_anchor_width / 2, y, front_wall - eps])
        rounded_box_xy(
            snap_clip_anchor_width,
            snap_clip_width,
            clip_z - front_wall + snap_clip_thickness + 2 * eps,
            1.5
        );

    translate([(snap_clip_anchor_width - snap_clip_lip) / 2, y, clip_z])
        rounded_box_xy(
            snap_clip_anchor_width + snap_clip_lip,
            snap_clip_width,
            snap_clip_thickness,
            1.5
        );
}

module snap_clip_fit_test() {
    translate([(snap_clip_test_outside_width - snap_clip_test_inside_width) / 2, 0, 0])
        rounded_box_xy(
            snap_clip_test_inside_width + snap_clip_test_outside_width,
            snap_clip_test_height,
            front_wall,
            2
        );

    for (y = [-snap_clip_test_pair_spacing / 2, snap_clip_test_pair_spacing / 2])
        snap_clip_test_clip(y);
}

module bambu_plate_body() {
    translate([128, 128, 0]) {
        translate([-38, -36, 0])
            screen_piece_for_bed();
        translate([91, -36, 0])
            controls_piece_for_bed();
        translate([-39, 72, 0])
            rotate([0, 0, 90])
                speaker_piece_for_bed();
    }
}

module bambu_plate_sides_face_up() {
    render(convexity = 10)
        union() {
            translate([128, 70, 0])
                rotate([0, 0, 90]) {
                    controls_piece_face_up_for_bed();
                }
            translate([128, 185, 0])
                // 左右侧模块在热床上同向摆放，避免切片器把两侧后支架生成成不同支撑形态。
                rotate([0, 0, 90]) {
                    speaker_piece_face_up_for_bed();
                }
            plate_kickstand_print_support(
                70 - kickstand_support_x_abs + (modular_split_x + outer_width / 2) / 2,
                controls_piece_bed_lift
            );
            plate_kickstand_print_support(
                185 - kickstand_support_x_abs + (modular_split_x + outer_width / 2) / 2,
                speaker_piece_bed_lift
            );
            translate([128, 128, 0])
                rail_lock_pin_set();
        }
}

module bambu_plate_sides() {
    render(convexity = 10)
        union() {
            // 外侧大平面贴底板：正面竖直，左右模块的可见正面采用同一打印方向，
            // 支撑量也明显少于正面朝上。
            translate([side_down_controls_plate_x, side_down_plate_y, 0])
                controls_piece_side_down_for_bed();

            translate([side_down_speaker_plate_x, side_down_plate_y, 0])
                speaker_piece_side_down_for_bed();

            side_down_clip_bed_supports(side_down_controls_plate_x, true);
            side_down_clip_bed_supports(side_down_speaker_plate_x, false);

        }
}

module bambu_plate_1() {
    translate([128, 86, 0])
        screen_piece_for_bed();
    translate([128, 215, 0])
        rotate([0, 0, 90])
            controls_piece_for_bed();
    translate([128, 170, 0])
        rail_lock_pin_set();
}

module bambu_plate_2() {
    translate([128, 79, 0])
        rotate([0, 0, 90])
            speaker_piece_for_bed();
    translate([128, 184, 0])
        rail_lock_pin_set();
    translate([128, 224, 0])
        rotary_controls_set();
}

module bambu_plate_front_slice_test() {
    bambu_plate_front_frame_test_1();
}

module bambu_plate_screen_frame_slice_test() {
    translate([128, 128, 0])
        screen_frame_slice_test();
}

module bambu_plate_front_frame_test_1() {
    translate([128, 77, 0])
        screen_slice_test_for_bed();
    translate([128, 210, 0])
        rotate([0, 0, 90])
            controls_slice_test_for_bed();
    translate([224, 210, 0])
        rail_lock_pin_set();
}

module bambu_plate_front_frame_test_2() {
    translate([82, 88, 0])
        rotate([0, 0, 90])
            speaker_slice_test_for_bed();
    translate([184, 88, 0])
        snap_clip_fit_test();
    translate([184, 154, 0])
        rail_lock_pin_set();
}

module bambu_plate_front_layout_legacy_test() {
    translate([38, -10, 0])
        front_layout_fit_test();
    translate([30, 220, 0])
        snap_clip_fit_test();
    translate([93, 220, 0])
        rail_lock_pin_set();
}

module split_pin() {
    rotate([0, 90, 0])
        cylinder(h = split_pin_length, d = split_pin_diameter);
}

module split_pin_set() {
    for (i = [0:3])
        translate([0, (i - 1.5) * 8, 0])
            split_pin();
}

module retaining_clip() {
    difference() {
        rounded_box_xy(clip_length, clip_width, clip_thickness, 3);
        translate([-clip_length / 2 + clip_hole_offset, 0, -eps])
            cylinder(h = clip_thickness + 2 * eps, d = screw_clearance_diameter);
    }
}

module clip_set() {
    for (i = [0:3])
        translate([(i - 1.5) * (clip_length + 8), 0, 0])
            retaining_clip();
}

module v2_tablet_pocket_cut() {
    translate([screen_center_x, screen_center_y, front_wall])
        linear_extrude(height = body_depth - front_wall + eps)
            rounded_rect_2d(v2_pocket_width, v2_pocket_height, pocket_corner_radius);
}

module v2_tablet_bottom_shelf() {
    // 底托在平板底边下方承重，不侵入平板实体空间；轻微重叠只用于消除切片缝。
    translate([
        screen_center_x,
        -tablet_height / 2 - v2_bottom_lip_height / 2 - 0.15,
        front_wall - 0.25
    ])
        rounded_box_xy(v2_pocket_width + 8, v2_bottom_lip_height, v2_pocket_depth + 0.25, 1.2);
}

module v2_tablet_side_guides() {
    // 左右只做轻限位，放在平板外侧，避免旧版 4mm 级硬卡扣挡住后装路径。
    for (side = [-1, 1])
        translate([
            side * (tablet_width / 2 + v2_side_lip_width / 2 + 0.25),
            0,
            front_wall - 0.25
        ])
            rounded_box_xy(v2_side_lip_width, v2_side_lip_height, v2_pocket_depth + 0.25, 0.8);
}

module v2_tablet_rear_side_capture_lips() {
    lip_inner_x = tablet_width / 2 - v2_rear_capture_lip_overlap;
    lip_outer_x = v2_pocket_width / 2 + v2_rear_capture_lip_anchor;
    lip_width = lip_outer_x - lip_inner_x;
    lip_center_x = (lip_inner_x + lip_outer_x) / 2;
    lip_z = front_wall + tablet_thickness + v2_rear_capture_lip_gap;

    // 侧模块最后装上时，这四个背压唇会跨过平板背面边缘，
    // 前框负责挡住屏幕面，背压唇负责防止平板从后面掉出。
    if (v2_use_rear_side_capture_lips)
        for (side = [-1, 1])
            for (y = [-v2_rear_capture_lip_y, v2_rear_capture_lip_y])
                translate([side * lip_center_x, y, lip_z])
                    rounded_box_xy(
                        lip_width,
                        v2_rear_capture_lip_height,
                        v2_rear_capture_lip_thickness,
                        0.9
                    );
}

module v2_tablet_bottom_corner_supports() {
    support_inner_x = tablet_width / 2 - v2_bottom_support_overlap_x;
    support_outer_x = v2_pocket_width / 2 + v2_bottom_support_anchor_x;
    support_width = support_outer_x - support_inner_x;
    support_center_x = (support_inner_x + support_outer_x) / 2;
    support_top_y = -tablet_height / 2 - v2_bottom_support_clearance_y;
    support_center_y = support_top_y - v2_bottom_support_height / 2;

    // 左右下角承托平板重量；中间框不参与承重，避免重新打印已校准的屏幕框。
    if (v2_use_bottom_corner_supports)
        for (side = [-1, 1])
            translate([
                side * support_center_x,
                support_center_y,
                front_wall - 0.25
            ])
                rounded_box_xy(
                    support_width,
                    v2_bottom_support_height,
                    v2_pocket_depth + v2_bottom_support_depth_extra,
                    0.9
                );

    // 外侧小连接桥只连回侧模块，不进入平板底边空间。
    // 这样底托不是独立散件，同时保留平板底边的装配间隙。
    if (v2_use_bottom_corner_supports)
        for (side = [-1, 1])
            translate([
                side * (support_outer_x - v2_bottom_support_bridge_width / 2),
                -outer_height / 2 + v2_bottom_support_bridge_width / 2,
                front_wall - 0.25
            ])
                rounded_box_xy(
                    v2_bottom_support_bridge_width,
                    v2_bottom_support_height + 2 * v2_bottom_support_clearance_y + v2_bottom_support_bridge_width,
                    v2_pocket_depth + v2_bottom_support_depth_extra,
                    0.8
                );
}

module v2_top_retainer_bar_at(x) {
    translate([
        x,
        tablet_height / 2 + v2_top_lip_height / 2 - 0.35,
        front_wall + tablet_thickness + 0.55
    ])
        rounded_box_xy(44, v2_top_lip_height, 2.2, 1.0);
}

module v2_top_retainer_set() {
    // 后装后再卡上的顶部止退条，防止平板从后侧松出；后续可按实测改成螺丝压片。
    for (x = [-56, 56])
        v2_top_retainer_bar_at(x);
}

module v2_printable_top_retainer_bar() {
    rounded_box_xy(44, v2_top_lip_height, 2.2, 1.0);
}

module v2_printable_top_retainer_set() {
    for (i = [-1, 1])
        translate([i * 28, 0, 0])
            v2_printable_top_retainer_bar();
}

module v2_rear_retainer_bosses() {
    for (side = [-1, 1])
        for (y = [-v2_retainer_boss_y, v2_retainer_boss_y])
            union() {
                bridge_x0 = v2_pocket_width / 2 + v2_retainer_bridge_pocket_gap;
                bridge_x1 = outer_width / 2 - 1.0;
                bridge_w = bridge_x1 - bridge_x0;

                // 背面连接垫把螺丝柱连到侧模块外壁，避免柱子成为独立散件。
                translate([
                    side * (bridge_x0 + bridge_w / 2),
                    y,
                    body_depth - v2_retainer_boss_depth
                ])
                    rounded_box_xy(
                        bridge_w,
                        v2_retainer_bridge_height,
                        v2_retainer_boss_depth,
                        2
                    );

                translate([
                    side * v2_retainer_boss_x,
                    y,
                    body_depth - v2_retainer_boss_depth
                ])
                    cylinder(h = v2_retainer_boss_depth, d = v2_retainer_boss_diameter);
            }
}

module v2_rear_retainer_pilot_holes() {
    for (side = [-1, 1])
        for (y = [-v2_retainer_boss_y, v2_retainer_boss_y])
            translate([
                side * v2_retainer_boss_x,
                y,
                body_depth - v2_retainer_boss_depth - eps
            ])
                cylinder(
                    h = v2_retainer_boss_depth + 2 * eps,
                    d = v2_retainer_pilot_diameter
                );
}

module v2_rear_retainer_clip_local() {
    difference() {
        translate([
            v2_retainer_clip_length / 2 - v2_retainer_clip_screw_offset,
            0,
            0
        ])
            rounded_box_xy(
                v2_retainer_clip_length,
                v2_retainer_clip_width,
                v2_retainer_clip_thickness,
                2
            );

        translate([0, 0, -eps])
            cylinder(
                h = v2_retainer_clip_thickness + 2 * eps,
                d = v2_retainer_clip_hole_diameter
            );
    }
}

module v2_rear_retainer_clip_at(side, y) {
    translate([
        side * v2_retainer_boss_x,
        y,
        body_depth + v2_retainer_clip_rear_gap
    ])
        scale([side < 0 ? 1 : -1, 1, 1])
            v2_rear_retainer_clip_local();
}

module v2_rear_retainer_clips_assembly() {
    for (side = [-1, 1])
        for (y = [-v2_retainer_boss_y, v2_retainer_boss_y])
            v2_rear_retainer_clip_at(side, y);
}

module v2_rear_retainer_set_for_print() {
    for (x = [-26, 26])
        for (y = [-10, 10])
            translate([x, y, 0])
                v2_rear_retainer_clip_local();
}

module v2_bambu_plate_retainers() {
    translate([128, 128, 0])
        v2_rear_retainer_set_for_print();
}

function v2_tilt_contact_y(z) =
    -outer_height / 2 - v2_tilt_runner_front_drop + z * tan(v2_tilt_angle);

module v2_unified_tilt_runner() {
    // 横贯三块的同一条倾斜接触基准；分件后每块拿到自己的那一段，不再左右各自悬空。
    quadrilateral_prism_x(
        outer_width,
        [v2_tilt_contact_y(v2_tilt_runner_z0), v2_tilt_runner_z0],
        [v2_tilt_contact_y(v2_tilt_runner_z1), v2_tilt_runner_z1],
        [v2_tilt_contact_y(v2_tilt_runner_z1) + v2_tilt_runner_height, v2_tilt_runner_z1],
        [v2_tilt_contact_y(v2_tilt_runner_z0) + v2_tilt_runner_height, v2_tilt_runner_z0]
    );
}

function v2_join_y(is_top) =
    is_top ? rail_center_y(true) : rail_center_y(false);

module v2_join_tab_2d(side, is_top, clearance = 0) {
    translate([
        side * (modular_split_x + v2_join_tab_overlap / 2),
        v2_join_y(is_top)
    ])
        rounded_rect_2d(
            v2_join_tab_overlap + 2 * clearance,
            v2_join_tab_height + 2 * clearance,
            v2_join_radius + clearance
        );
}

module v2_join_tab_solid(side, is_top) {
    linear_extrude(height = front_wall)
        v2_join_tab_2d(side, is_top);
}

module v2_join_slot_cut(side, is_top) {
    translate([0, 0, -eps])
        linear_extrude(height = front_wall + 2 * eps)
            v2_join_tab_2d(side, is_top, v2_join_clearance);
}

module v2_join_socket_backer(side, is_top) {
    tablet_edge_x = side * (v2_pocket_width / 2 + 0.8);
    socket_outer_x = side * (modular_split_x + v2_join_tab_overlap + 2.0);
    backer_w = abs(socket_outer_x - tablet_edge_x);
    backer_h = v2_join_tab_height + 2.2;

    // 插槽薄边背后加厚，但只放在平板口袋外侧。
    if (backer_w > 0)
        translate([(tablet_edge_x + socket_outer_x) / 2, v2_join_y(is_top), front_wall - eps])
            linear_extrude(height = v2_join_backer_depth)
                rounded_rect_2d(backer_w, backer_h, 1.2);
}

module v2_shell_body() {
    difference() {
        union() {
            difference() {
                union() {
                    rounded_box_xy(outer_width, outer_height, body_depth, outer_corner_radius);
                    screen_bezel();
                    if (!separate_rotary_controls) controls();
                    logo_mark();
                }
                front_screen_cut();
                v2_tablet_pocket_cut();
                side_lightening_cuts();
                speaker_holes_cut();
                if (separate_rotary_controls) control_socket_cuts();
                logo_cut();
                charge_cutout();
                cable_groove_cut();
                rear_vent_cuts();
            }

            if (v2_use_rear_screw_retainers)
                v2_rear_retainer_bosses();

            if (v2_use_external_bottom_shelf)
                v2_tablet_bottom_shelf();
            v2_tablet_side_guides();
            v2_tablet_rear_side_capture_lips();
            v2_tablet_bottom_corner_supports();
        }

        if (v2_use_rear_screw_retainers)
            v2_rear_retainer_pilot_holes();
    }
}

module v2_side_piece(side) {
    x_min = side > 0 ? modular_split_x : -outer_width / 2 - eps;
    x_max = side > 0 ? outer_width / 2 + eps : -modular_split_x;

    difference() {
        union() {
            intersection() {
                v2_shell_body();
                translate([(x_min + x_max) / 2, 0, body_depth / 2])
                    cube([
                        x_max - x_min,
                        outer_height + 70,
                        body_depth + kickstand_reach + knob_raise + 80
                    ], center = true);
            }

            for (is_top = [false, true])
                v2_join_socket_backer(side, is_top);
        }

        for (is_top = [false, true])
            v2_join_slot_cut(side, is_top);
    }
}

module v2_screen_frame_piece() {
    difference() {
        union() {
            intersection() {
                v2_shell_body();
                translate([0, 0, body_depth / 2])
                    cube([
                        2 * modular_split_x + 2 * eps,
                        outer_height + 70,
                        body_depth + kickstand_reach + knob_raise + 80
                    ], center = true);
            }

            for (side = [-1, 1])
                for (is_top = [false, true])
                    v2_join_tab_solid(side, is_top);
        }
    }
}

module v2_body_assembly() {
    v2_side_piece(-1);
    v2_screen_frame_piece();
    v2_side_piece(1);
    if (v2_show_top_retainer_bars)
        v2_top_retainer_set();
}

module v2_visual_assembly() {
    color([1, 1, 1, 1]) v2_body_assembly();
    if (show_tablet_in_assembly) tablet_placeholder();
    screen_glass_preview();
    speaker_dark_preview();
    if (separate_rotary_controls) color([1, 1, 1, 1]) rotating_controls_assembly();
    if (v2_use_rear_screw_retainers)
        color([1, 1, 1, 1]) v2_rear_retainer_clips_assembly();
}

module v2_speaker_piece_for_bed() {
    translate([-(modular_split_x + outer_width / 2) / 2, 0, 0])
        v2_side_piece(1);
}

module v2_controls_piece_for_bed() {
    translate([(modular_split_x + outer_width / 2) / 2, 0, 0])
        v2_side_piece(-1);
}

module v2_screen_piece_for_bed() {
    translate([0, 0, v2_screen_bed_lift])
        v2_screen_frame_piece();
}

module v2_speaker_piece_side_down_for_bed() {
    translate([side_piece_print_max_z / 2, 0, side_piece_side_down_lift])
        rotate([0, -90, 0])
            v2_speaker_piece_for_bed();
}

module v2_controls_piece_side_down_for_bed() {
    translate([-side_piece_print_max_z / 2, 0, side_piece_side_down_lift])
        rotate([0, 90, 0])
            v2_controls_piece_for_bed();
}

module v2_bambu_plate_sides() {
    render(convexity = 10)
        union() {
            translate([v2_side_print_x_left, side_down_plate_y, 0])
                v2_controls_piece_side_down_for_bed();

            translate([v2_side_print_x_right, side_down_plate_y, 0])
                v2_speaker_piece_side_down_for_bed();
        }
}

module v2_bambu_plate_screen() {
    translate([128, 118, 0])
        v2_screen_piece_for_bed();

    if (v2_show_top_retainer_bars)
        translate([128, 232, 0])
            v2_printable_top_retainer_set();
}

module v2_join_fit_test() {
    intersection() {
        v2_body_assembly();
        translate([modular_split_x, rail_center_y(true), 24])
            cube([84, 30, 48], center = true);
    }
}

module v2_pocket_fit_test() {
    translate([0, 0, v2_pocket_test_bed_lift])
        intersection() {
            v2_body_assembly();
            translate([0, -outer_height / 2 + 12, 18])
                cube([v2_pocket_width + 24, 28, 42], center = true);
        }
}

module tablet_placeholder() {
    color([0.03, 0.03, 0.03, 0.35])
        translate([screen_center_x, screen_center_y, front_wall])
            rounded_box_xy(tablet_width, tablet_height, tablet_thickness, 6);
    color([0.01, 0.01, 0.01, 0.82])
        translate([screen_center_x, screen_center_y, front_wall - 0.25])
            linear_extrude(height = 0.35)
                rounded_rect_2d(screen_width, screen_height, 2);
}

if (part == "v2_assembly") {
    v2_visual_assembly();
} else if (part == "v2_body") {
    color([1, 1, 1, 1]) v2_body_assembly();
} else if (part == "v2_screen_frame") {
    color([1, 1, 1, 1]) v2_screen_piece_for_bed();
} else if (part == "v2_left_speaker") {
    color([1, 1, 1, 1]) v2_speaker_piece_for_bed();
} else if (part == "v2_right_controls") {
    color([1, 1, 1, 1]) v2_controls_piece_for_bed();
} else if (part == "v2_rear_retainers") {
    color([1, 1, 1, 1]) v2_rear_retainer_set_for_print();
} else if (part == "v2_bambu_plate_sides") {
    color([1, 1, 1, 1]) v2_bambu_plate_sides();
} else if (part == "v2_bambu_plate_screen") {
    color([1, 1, 1, 1]) v2_bambu_plate_screen();
} else if (part == "v2_bambu_plate_retainers") {
    color([1, 1, 1, 1]) v2_bambu_plate_retainers();
} else if (part == "v2_rotary_controls") {
    color([1, 1, 1, 1]) v2_rotary_controls_set();
} else if (part == "v2_bambu_plate_knobs") {
    color([1, 1, 1, 1]) v2_bambu_plate_knobs();
} else if (part == "v2_join_fit_test") {
    color([1, 1, 1, 1]) v2_join_fit_test();
} else if (part == "v2_pocket_fit_test") {
    color([1, 1, 1, 1]) v2_pocket_fit_test();
} else if (part == "visual_assembly") {
    color([1, 1, 1, 1]) shell_body_visual_preview();
    if (show_tablet_in_assembly) tablet_placeholder();
    screen_glass_preview();
    speaker_dark_preview();
    if (separate_rotary_controls) color([1, 1, 1, 1]) rotating_controls_assembly();
} else if (part == "modular_assembly") {
    color([1, 1, 1, 1]) modular_shell_assembly();
    if (show_tablet_in_assembly) tablet_placeholder();
    screen_glass_preview();
    speaker_dark_preview();
    if (separate_rotary_controls) color([1, 1, 1, 1]) rotating_controls_assembly();
} else if (part == "shell") {
    color([1, 1, 1, 1]) shell_body();
} else if (part == "shell_speaker") {
    color([1, 1, 1, 1]) speaker_piece_for_bed();
} else if (part == "shell_speaker_side_down") {
    color([1, 1, 1, 1]) speaker_piece_side_down_for_bed();
} else if (part == "shell_speaker_support_edge_down") {
    color([1, 1, 1, 1]) speaker_piece_support_edge_down_for_bed();
} else if (part == "shell_screen") {
    color([1, 1, 1, 1]) screen_piece_for_bed();
} else if (part == "shell_screen_face_up") {
    color([1, 1, 1, 1]) screen_piece_face_up_for_bed();
} else if (part == "shell_controls") {
    color([1, 1, 1, 1]) controls_piece_for_bed();
} else if (part == "shell_controls_side_down") {
    color([1, 1, 1, 1]) controls_piece_side_down_for_bed();
} else if (part == "shell_controls_support_edge_down") {
    color([1, 1, 1, 1]) controls_piece_support_edge_down_for_bed();
} else if (part == "shell_top_rail") {
    color([1, 1, 1, 1]) top_rail_piece_for_bed();
} else if (part == "shell_bottom_rail") {
    color([1, 1, 1, 1]) bottom_rail_piece_for_bed();
} else if (part == "shell_screen_legacy") {
    color([1, 1, 1, 1]) screen_piece_legacy_for_bed();
} else if (part == "rotary_controls") {
    rotary_controls_set();
} else if (part == "rotary_fit_test") {
    rotary_fit_test();
} else if (part == "speaker_grille_fit_test") {
    speaker_grille_fit_test();
} else if (part == "screen_window_fit_test") {
    screen_window_fit_test();
} else if (part == "front_layout_fit_test") {
    front_layout_fit_test();
} else if (part == "front_slice_test") {
    color([1, 1, 1, 1]) front_slice_test();
} else if (part == "screen_frame_slice_test") {
    color([1, 1, 1, 1]) screen_frame_slice_test();
} else if (part == "snap_clip_fit_test") {
    color([1, 1, 1, 1]) snap_clip_fit_test();
} else if (part == "bambu_plate_body") {
    color([1, 1, 1, 1]) bambu_plate_body();
} else if (part == "bambu_plate_sides") {
    color([1, 1, 1, 1]) bambu_plate_sides();
} else if (part == "bambu_plate_sides_face_up") {
    color([1, 1, 1, 1]) bambu_plate_sides_face_up();
} else if (part == "bambu_plate_1") {
    color([1, 1, 1, 1]) bambu_plate_1();
} else if (part == "bambu_plate_2") {
    color([1, 1, 1, 1]) bambu_plate_2();
} else if (part == "bambu_plate_knobs") {
    bambu_plate_knobs();
} else if (part == "bambu_plate_screen_frame_slice_test") {
    color([1, 1, 1, 1]) bambu_plate_screen_frame_slice_test();
} else if (part == "bambu_plate_front_slice_test") {
    color([1, 1, 1, 1]) bambu_plate_front_slice_test();
} else if (part == "bambu_plate_front_frame_test_1") {
    color([1, 1, 1, 1]) bambu_plate_front_frame_test_1();
} else if (part == "bambu_plate_front_frame_test_2") {
    color([1, 1, 1, 1]) bambu_plate_front_frame_test_2();
} else if (part == "rail_lock_pins") {
    rail_lock_pin_set();
} else if (part == "split_pins") {
    split_pin_set();
} else if (part == "clips") {
    clip_set();
} else if (part == "tablet") {
    tablet_placeholder();
} else {
    color([1, 1, 1, 1]) shell_body();
    if (show_tablet_in_assembly) tablet_placeholder();
    screen_glass_preview();
    speaker_dark_preview();
    if (separate_rotary_controls) color([1, 1, 1, 1]) rotating_controls_assembly();
}
