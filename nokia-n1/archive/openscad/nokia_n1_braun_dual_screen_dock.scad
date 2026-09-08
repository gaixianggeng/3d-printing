// Nokia N1 classic radio-inspired dual-screen dock.
// Units: millimeters.

part = "assembly"; // [assembly, shell, tablet]

// Nokia N1 in landscape orientation.
tablet_width = 200.7;
tablet_height = 138.6;
tablet_thickness = 6.9;
screen_width = 160.5;
screen_height = 120.4;

// Fit.
tablet_clearance = 1.4;
front_wall = 2.4;
rear_clearance = 2.4;
body_depth = front_wall + tablet_thickness + rear_clearance + 12;

// Classic white radio body proportions.
outer_margin_x = 18;
outer_margin_y = 18;
outer_corner_radius = 9;
front_bevel_width = 3.2;
front_recess_depth = 1.4;
rear_round_radius = 7;

// Two front screen windows. The tablet shows through both windows.
window_gap = 11;
window_outer_margin_x = 4.5;
window_outer_margin_y = 5.0;
window_corner_radius = 5;
window_bezel_width = 4.2;
window_bezel_raise = 1.2;

// Decorative details inspired by classic radios.
use_right_dial_ring = true;
dial_ring_diameter = 84;
dial_ring_width = 1.6;
dial_tick_count = 14;
dial_tick_length = 5.0;
dial_tick_width = 0.7;

use_top_highlight = true;
top_highlight_depth = 0.45;
top_highlight_margin = 10;

// Charging cutout. Nokia N1 USB-C is centered on the portrait bottom edge.
// In this landscape dock, right means the tablet portrait bottom points right.
charge_side = "right"; // [right, left, bottom]
charge_slot_width = 32;
charge_slot_height = 11;
charge_offset = 0;
cable_groove_width = 10;
cable_groove_depth = 3.4;

// Back retaining clips.
screw_clearance_diameter = 3.4;
screw_boss_diameter = 11;
screw_boss_height = 4.0;
clip_land_width = 16;
clip_land_height = 18;
clip_mount_inset_y = 31;
clip_mount_offset_x = 8.5;

// Integrated stance.
base_foot_height = 7;
base_foot_depth_extra = 11;
rear_lean_foot = true;
lean_foot_height = 42;
lean_foot_reach = 34;
lean_foot_span = 184;

show_tablet_in_assembly = true;

$fn = 56;
eps = 0.05;

pocket_width = tablet_width + tablet_clearance;
pocket_height = tablet_height + tablet_clearance;
outer_width = pocket_width + outer_margin_x * 2;
outer_height = pocket_height + outer_margin_y * 2;

window_total_width = screen_width - 2 * window_outer_margin_x;
window_width = (window_total_width - window_gap) / 2;
window_height = screen_height - 2 * window_outer_margin_y;
left_window_x = -(window_width + window_gap) / 2;
right_window_x = (window_width + window_gap) / 2;
window_y = 0;
charge_z = front_wall + tablet_thickness / 2;
side_wall = (outer_width - pocket_width) / 2;
bottom_wall = (outer_height - pocket_height) / 2;

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

module rounded_ring_2d(outer_w, outer_h, inner_w, inner_h, outer_r, inner_r) {
    difference() {
        rounded_rect_2d(outer_w, outer_h, outer_r);
        rounded_rect_2d(inner_w, inner_h, inner_r);
    }
}

module rounded_ring_xy(outer_w, outer_h, inner_w, inner_h, d, outer_r, inner_r) {
    linear_extrude(height = d) rounded_ring_2d(outer_w, outer_h, inner_w, inner_h, outer_r, inner_r);
}

module front_window_2d() {
    translate([left_window_x, window_y])
        rounded_rect_2d(window_width, window_height, window_corner_radius);
    translate([right_window_x, window_y])
        rounded_rect_2d(window_width, window_height, window_corner_radius);
}

module front_window_cut() {
    translate([0, 0, -window_bezel_raise - eps])
        linear_extrude(height = body_depth + window_bezel_raise + 2 * eps)
            front_window_2d();
}

module rear_tablet_pocket_cut() {
    translate([0, 0, front_wall])
        linear_extrude(height = body_depth - front_wall + eps)
            rounded_rect_2d(pocket_width, pocket_height, rear_round_radius);
}

module front_bevel_cut() {
    translate([0, 0, -eps])
        linear_extrude(height = front_recess_depth + eps)
            rounded_ring_2d(
                outer_width - 2 * front_bevel_width,
                outer_height - 2 * front_bevel_width,
                outer_width - 2 * (front_bevel_width + 2.0),
                outer_height - 2 * (front_bevel_width + 2.0),
                outer_corner_radius - 1,
                outer_corner_radius - 3
            );
}

module window_bezels() {
    for (x = [left_window_x, right_window_x])
        translate([x, window_y, -window_bezel_raise])
            rounded_ring_xy(
                window_width + 2 * window_bezel_width,
                window_height + 2 * window_bezel_width,
                window_width,
                window_height,
                window_bezel_raise,
                window_corner_radius + window_bezel_width,
                window_corner_radius
            );
}

module right_dial_ring() {
    if (use_right_dial_ring) {
        // The front preview is viewed from -Z, so this coordinate appears on the visual right.
        ring_x = left_window_x;
        ring_y = 0;
        translate([ring_x, ring_y, -window_bezel_raise - 0.25])
            difference() {
                cylinder(h = window_bezel_raise + 0.35, d = dial_ring_diameter);
                translate([0, 0, -eps])
                    cylinder(h = window_bezel_raise + 0.55, d = dial_ring_diameter - 2 * dial_ring_width);
            }

        for (i = [0 : dial_tick_count - 1]) {
            a = 360 * i / dial_tick_count + 8;
            translate([
                ring_x + cos(a) * (dial_ring_diameter / 2 + 5),
                ring_y + sin(a) * (dial_ring_diameter / 2 + 5),
                -window_bezel_raise - 0.35
            ])
                rotate([0, 0, a - 90])
                    rounded_box_xy(dial_tick_width, dial_tick_length, window_bezel_raise + 0.45, 0.35);
        }
    }
}

module top_highlight_cut() {
    if (use_top_highlight) {
        translate([0, outer_height / 2 - top_highlight_margin, -eps])
            rounded_box_xy(outer_width - 28, 2.0, top_highlight_depth + eps, 1);
    }
}

module charge_cutout() {
    if (charge_side == "right") {
        translate([(outer_width / 2 + pocket_width / 2) / 2, charge_offset, charge_z])
            cube([side_wall + 2 * eps, charge_slot_width, charge_slot_height], center = true);
    } else if (charge_side == "left") {
        translate([-(outer_width / 2 + pocket_width / 2) / 2, charge_offset, charge_z])
            cube([side_wall + 2 * eps, charge_slot_width, charge_slot_height], center = true);
    } else {
        translate([charge_offset, -(outer_height / 2 + pocket_height / 2) / 2, charge_z])
            cube([charge_slot_width, bottom_wall + 2 * eps, charge_slot_height], center = true);
    }
}

module cable_groove_cut() {
    if (charge_side == "right") {
        translate([outer_width / 2 - side_wall / 2, -outer_height / 2 + 35, body_depth - cable_groove_depth / 2 + eps])
            cube([side_wall + 2 * eps, 70, cable_groove_depth + 2 * eps], center = true);
    } else if (charge_side == "left") {
        translate([-outer_width / 2 + side_wall / 2, -outer_height / 2 + 35, body_depth - cable_groove_depth / 2 + eps])
            cube([side_wall + 2 * eps, 70, cable_groove_depth + 2 * eps], center = true);
    } else {
        translate([0, -outer_height / 2 + bottom_wall / 2, body_depth - cable_groove_depth / 2 + eps])
            cube([charge_slot_width + 20, bottom_wall + 2 * eps, cable_groove_depth + 2 * eps], center = true);
    }
}

module clip_positions() {
    for (sx = [-1, 1])
        for (sy = [-1, 1])
            translate([
                sx * (pocket_width / 2 + clip_mount_offset_x),
                sy * (pocket_height / 2 - clip_mount_inset_y),
                0
            ]) children();
}

module screw_bosses() {
    clip_positions()
        translate([0, 0, body_depth - screw_boss_height])
            cylinder(h = screw_boss_height, d = screw_boss_diameter);
}

module screw_holes() {
    clip_positions()
        translate([0, 0, body_depth - screw_boss_height - eps])
            cylinder(h = screw_boss_height + 2 * eps, d = screw_clearance_diameter);
}

module clip_landings() {
    clip_positions()
        translate([0, 0, body_depth - 1.0])
            rounded_box_xy(clip_land_width, clip_land_height, 1.0, 3);
}

module base_foot() {
    translate([0, -outer_height / 2 - base_foot_height / 2, 1.2])
        rounded_box_xy(outer_width * 0.92, base_foot_height, body_depth + base_foot_depth_extra, 3);
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

module lean_feet() {
    if (rear_lean_foot) {
        y0 = -outer_height / 2 + 8;
        y1 = y0 + lean_foot_height;
        z0 = body_depth - 1;
        z1 = body_depth + lean_foot_reach;
        for (x = [-lean_foot_span / 2, lean_foot_span / 2])
            translate([x, 0, 0])
                triangular_prism_x(10, [y0, z0], [y1, z0], [y0, z1]);
    }
}

module shell_body() {
    difference() {
        union() {
            difference() {
                union() {
                    rounded_box_xy(outer_width, outer_height, body_depth, outer_corner_radius);
                    window_bezels();
                    right_dial_ring();
                }
                front_window_cut();
                rear_tablet_pocket_cut();
                front_bevel_cut();
                top_highlight_cut();
            }
            screw_bosses();
            clip_landings();
            base_foot();
            lean_feet();
        }
        charge_cutout();
        cable_groove_cut();
        screw_holes();
    }
}

module tablet_placeholder() {
    color([0.05, 0.05, 0.05, 0.35])
        translate([0, 0, front_wall])
            rounded_box_xy(tablet_width, tablet_height, tablet_thickness, 6);
    color([0.02, 0.02, 0.02, 0.75])
        translate([0, 0, front_wall - 0.25])
            linear_extrude(height = 0.35)
                rounded_rect_2d(screen_width, screen_height, 2);
}

if (part == "shell") {
    shell_body();
} else if (part == "tablet") {
    tablet_placeholder();
} else {
    color([0.86, 0.88, 0.86, 1]) shell_body();
    if (show_tablet_in_assembly) tablet_placeholder();
}
