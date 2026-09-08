// Nokia N1 photo-frame dock for OpenSCAD.
// Units: millimeters.

part = "assembly"; // [assembly, frame, clips, tablet]

// Nokia N1 dimensions in landscape orientation.
tablet_width = 200.7;
tablet_height = 138.6;
tablet_thickness = 6.9;

// The active display is centered and derived from the 7.9 inch 4:3 panel.
screen_width = 160.5;
screen_height = 120.4;

// Fit and printing allowances.
tablet_clearance = 1.2;
pocket_depth_extra = 1.7;
front_lip_depth = 2.2;
body_depth = front_lip_depth + tablet_thickness + pocket_depth_extra + 2.0;

// Picture-frame proportions.
outer_margin_x = 18;
outer_margin_y = 18;
outer_corner_radius = 10;
pocket_corner_radius = 6;
window_corner_radius = 3;
front_rim_width = 11;
front_rim_raise = 2.4;
front_rim_corner_radius = 12;

// Open the window a little larger than the computed display.
window_extra_x = 2.5;
window_extra_y = 2.0;

// Charging cutout. Nokia N1 USB-C is centered on the portrait bottom edge.
// In this landscape frame, "right" means the tablet portrait bottom points right.
charge_side = "right"; // [right, left, bottom]
charge_offset = 0;
charge_slot_width = 30;
charge_slot_height = 10;
cable_groove_width = 9;
cable_groove_depth = 3.2;

// Optional access relief for side/bottom buttons or a thicker cable shell.
bottom_access_width = 64;
bottom_access_height = 9;

// M3 clip hardware.
screw_clearance_diameter = 3.4;
screw_boss_diameter = 11;
screw_boss_height = 4.0;
clip_length = 34;
clip_width = 11;
clip_thickness = 2.8;
clip_hole_offset = 8;
clip_mount_inset_y = 31;
clip_mount_offset_x = 8.5;

// Integrated rear kickstand. Disable if you prefer a flat frame.
use_kickstand = true;
kickstand_reach = 64;
kickstand_height = 86;
kickstand_rib_width = 10;
kickstand_span = 220;

// Preview helper.
show_tablet_in_assembly = true;

$fn = 48;
eps = 0.05;

pocket_width = tablet_width + tablet_clearance;
pocket_height = tablet_height + tablet_clearance;
slot_depth = tablet_thickness + pocket_depth_extra;
outer_width = pocket_width + outer_margin_x * 2;
outer_height = pocket_height + outer_margin_y * 2;
window_width = screen_width + window_extra_x;
window_height = screen_height + window_extra_y;
side_wall = (outer_width - pocket_width) / 2;
bottom_wall = (outer_height - pocket_height) / 2;
charge_z = front_lip_depth + tablet_thickness / 2;

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

module clip_positions() {
    for (sx = [-1, 1])
        for (sy = [-1, 1])
            translate([
                sx * (pocket_width / 2 + clip_mount_offset_x),
                sy * (pocket_height / 2 - clip_mount_inset_y),
                0
            ]) children();
}

module screw_holes() {
    clip_positions()
        translate([0, 0, body_depth - screw_boss_height - eps])
            cylinder(h = screw_boss_height + front_rim_raise + 2 * eps,
                     d = screw_clearance_diameter);
}

module screw_bosses() {
    clip_positions()
        translate([0, 0, body_depth - screw_boss_height])
            cylinder(h = screw_boss_height, d = screw_boss_diameter);
}

module front_window_cut() {
    translate([0, 0, -front_rim_raise - eps])
        linear_extrude(height = body_depth + front_rim_raise + 2 * eps)
            rounded_rect_2d(window_width, window_height, window_corner_radius);
}

module rear_tablet_pocket_cut() {
    translate([0, 0, front_lip_depth])
        linear_extrude(height = body_depth - front_lip_depth + eps)
            rounded_rect_2d(pocket_width, pocket_height, pocket_corner_radius);
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
        translate([outer_width / 2 - side_wall / 2, -outer_height / 2 + 34, body_depth - cable_groove_depth / 2 + eps])
            cube([side_wall + 2 * eps, 68, cable_groove_depth + 2 * eps], center = true);
        translate([outer_width / 2 - side_wall / 2, charge_offset / 2, body_depth - cable_groove_depth / 2 + eps])
            cube([side_wall + 2 * eps, abs(charge_offset) + 26, cable_groove_depth + 2 * eps], center = true);
    } else if (charge_side == "left") {
        translate([-outer_width / 2 + side_wall / 2, -outer_height / 2 + 34, body_depth - cable_groove_depth / 2 + eps])
            cube([side_wall + 2 * eps, 68, cable_groove_depth + 2 * eps], center = true);
        translate([-outer_width / 2 + side_wall / 2, charge_offset / 2, body_depth - cable_groove_depth / 2 + eps])
            cube([side_wall + 2 * eps, abs(charge_offset) + 26, cable_groove_depth + 2 * eps], center = true);
    } else {
        translate([0, -outer_height / 2 + bottom_wall / 2, body_depth - cable_groove_depth / 2 + eps])
            cube([charge_slot_width + 18, bottom_wall + 2 * eps, cable_groove_depth + 2 * eps], center = true);
    }
}

module bottom_access_cut() {
    translate([0, -(outer_height / 2 + pocket_height / 2) / 2, charge_z])
        cube([bottom_access_width, bottom_wall + 2 * eps, bottom_access_height], center = true);
}

module bottom_foot() {
    translate([0, -outer_height / 2 - 3.0, 0])
        rounded_box_xy(outer_width * 0.88, 9, body_depth + 7, 4);
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

module kickstand() {
    y0 = -outer_height / 2 + 4;
    y1 = y0 + kickstand_height;
    z0 = body_depth;
    z1 = body_depth + kickstand_reach;
    for (x = [-kickstand_span / 2, kickstand_span / 2])
        translate([x, 0, 0])
            triangular_prism_x(kickstand_rib_width, [y0, z0], [y1, z0], [y0, z1]);

    translate([0, y0 + 4, z1 - 4])
        rounded_box_xy(kickstand_span + kickstand_rib_width, 10, 8, 3);
}

module frame_body() {
    difference() {
        union() {
            difference() {
                union() {
                    rounded_box_xy(outer_width, outer_height, body_depth, outer_corner_radius);
                    translate([0, 0, -front_rim_raise])
                        rounded_ring_xy(
                            outer_width,
                            outer_height,
                            outer_width - 2 * front_rim_width,
                            outer_height - 2 * front_rim_width,
                            front_rim_raise,
                            front_rim_corner_radius,
                            max(outer_corner_radius - front_rim_width / 2, 3)
                        );
                }
                front_window_cut();
                rear_tablet_pocket_cut();
            }
            screw_bosses();
            bottom_foot();
            if (use_kickstand) kickstand();
        }
        charge_cutout();
        cable_groove_cut();
        bottom_access_cut();
        screw_holes();
    }
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

module tablet_placeholder() {
    color([0.05, 0.05, 0.05, 0.35])
        translate([0, 0, front_lip_depth])
            rounded_box_xy(tablet_width, tablet_height, tablet_thickness, 6);
    color([0.02, 0.02, 0.02, 0.55])
        translate([0, 0, front_lip_depth - 0.2])
            linear_extrude(height = 0.3)
                rounded_rect_2d(screen_width, screen_height, 2);
}

module installed_clips_preview() {
    for (sx = [-1, 1])
        for (sy = [-1, 1])
            translate([
                sx * (pocket_width / 2 + clip_mount_offset_x),
                sy * (pocket_height / 2 - clip_mount_inset_y),
                body_depth + 0.15
            ])
                rotate([0, 0, sx > 0 ? 180 : 0])
                    color([0.55, 0.42, 0.32, 1]) retaining_clip();
}

if (part == "frame") {
    frame_body();
} else if (part == "clips") {
    clip_set();
} else if (part == "tablet") {
    tablet_placeholder();
} else {
    color([0.55, 0.34, 0.22, 1]) frame_body();
    if (show_tablet_in_assembly) tablet_placeholder();
    installed_clips_preview();
}
