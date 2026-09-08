// EarPods 圆盘收纳支架，单位：mm。
// 状态：v0.7 双卡扣版；每个耳机柄设置两个相同卡扣，减少单点固定时的晃动。
// 用户已确认单卡扣大小和 5.30 mm 磁铁孔合适；双卡扣稳定性待试装。
// Y 分线器留在圆盘内，主线穿过支杆，从底座底部开放槽引出。
// 单耳参考 Dimensions.com：35.6 × 14.5 × 17.5；非 Apple 制造图纸。
// 线控完整尺寸和分支线长未找到可靠公开数据，采用宽松槽及可调整绕线空间。
// 所有单件已按建议打印方向放置；预览中的耳机和磁铁不能打印。

/* [Export] */
part = "assembly"; // [assembly,open,exploded,section,body,lid,stand,fit_coupon,ear_fit_coupon,layout,envelopes,collision]
show_contents = true;

/* [Magnets] */
magnet_d = 5;
magnet_h = 3;
magnet_d_clearance = 0.30; // 直径总余量，并非每侧余量
magnet_depth_clearance = 0.15;

/* [Housing] */
head_d = 116;
front_t = 2.4;
wall_t = 2.4;
body_depth = 27.6;
lid_t = 4.6;
lip_h = 1.8;
lip_t = 1.6;
lip_clearance = 0.30; // 径向单侧间隙

/* [EarPods - 3.5 mm reference] */
ear_space_w = 19.5;
ear_space_l = 39;
ear_x = 23;
holder_t = 1.6;
holder_h = 9;
ear_closed_depth = 20;
ear_entry_chamfer = 0.6;
stem_clip_bore_d = 5.2; // 此卡扣尺寸已获用户试装确认，不是实测耳机柄直径
stem_clip_opening = 4.4;
stem_clip_wall = 0.9;
stem_clip_band = 3.2;
stem_clip_y = -5;
stem_clip_spacing = 5; // 两个卡扣中心距；保留原卡扣位置和尺寸
stem_clip_axis_z = 3.5; // 相对槽底
stem_check_d = 4.8; // 数字检查杆径；需要用实物确认松紧
remote_space_w = 13;
remote_space_l = 56;
remote_window_w = 8;
remote_window_l = 48;
remote_backstop_h = 14.5;
remote_support_y = 10;
remote_support_t = 1.6;
wire_bore_d = 8;
base_slot_w = 4;
base_slot_h = 3.5;
cable_bend_r = 6;

/* [Stand] */
base_d = 108;
base_h = 8;
stem_d = 24;
stem_top = 60;
tenon_w = 12;
tenon_depth = 14;
tenon_l = 8;
joint_clearance = 0.40; // 接口总间隙

/* [Hidden] */
$fn = 128;
eps = 0.02;
R = head_d / 2;
inner_r = R - wall_t;
magnet_hole_d = magnet_d + magnet_d_clearance;
magnet_hole_h = magnet_h + magnet_depth_clearance;
boss_r = magnet_hole_d/2 + 2.5;
magnet_y = inner_r - boss_r + 1.1;
spool_r = 41.5;
spool_t = 1.6;
shell_color = [0.84, 0.83, 0.78];
lid_color = [0.91, 0.90, 0.86];
head_center_h = stem_top + R;
head_center_depth = (body_depth + lid_t) / 2;
tenon_z = head_center_depth - tenon_depth / 2;
ear_reference = [14.5,35.6,17.5]; // 宽、长、厚；公开图纸的最大外形参考
ear_backstop_h = body_depth-front_t-ear_closed_depth;
stem_clip_outer_d = stem_clip_bore_d+2*stem_clip_wall;
stem_clip_x = ear_space_w/2-stem_clip_outer_d/2-0.5;

assert(lid_t - magnet_hole_h >= 1.2, "磁铁孔底至少保留 1.2 mm 材料");
assert(body_depth - front_t >= 23, "当前 EarPods 包络至少需要 23 mm 内深");
assert(magnet_d <= 5, "增大磁铁后需重新核对绕线通道");
assert(ear_space_w >= max(ear_reference[0],ear_reference[2])+2, "耳机转向后，横向也至少保留 2 mm 总余量");
assert(ear_closed_depth >= max(ear_reference[0],ear_reference[2])+2, "合盖后需保留耳机厚度余量");
assert(ear_backstop_h > 0, "后盖耳机限位台需要正高度");
assert(tenon_z >= 0 && tenon_z + tenon_depth <= body_depth, "插舌必须位于主体厚度范围内");
assert(min(tenon_w,tenon_depth)-wire_bore_d >= 4, "中空插舌每侧至少留 2 mm 材料");
assert(stem_d/2-sqrt(pow((tenon_w+joint_clearance)/2,2)+pow((tenon_depth+joint_clearance)/2,2)) >= 2, "插孔角部至支杆外壁至少留 2 mm 材料");
assert(stem_clip_opening < stem_check_d && stem_check_d < stem_clip_bore_d, "试杆应能在卡扣内落座，入口需略窄于试杆");
assert(stem_clip_y+stem_clip_band/2 < 0, "卡扣必须留在耳机柄区域，避开耳机头");
assert(stem_clip_spacing > stem_clip_band, "两个卡扣之间需要留缝");
assert(stem_clip_y-stem_clip_spacing-stem_clip_band/2 > -ear_space_l/2+5, "第二个卡扣避开尾端出线区域");

module rounded_rect(w,l,r=2) {
    hull() for(x=[-w/2+r,w/2-r],y=[-l/2+r,l/2-r])
        translate([x,y]) circle(r=r,$fn=48);
}

module beveled_disk(d,h,c=0.6) {
    union() {
        cylinder(d1=d-2*c,d2=d,h=c);
        translate([0,0,c]) cylinder(d=d,h=h-2*c);
        translate([0,0,h-c]) cylinder(d1=d,d2=d-2*c,h=c);
    }
}

module magnet_positions() {
    for(y=[-magnet_y,magnet_y]) translate([0,y,0]) children();
}

module pocket_ring(w,l) {
    difference() {
        linear_extrude(holder_h) difference() {
            rounded_rect(w+2*holder_t,l+2*holder_t,3+holder_t);
            rounded_rect(w,l,3);
        }
        // 入口倒角只引导放入，不形成需要掰开的硬卡扣。
        hull() {
            translate([0,0,holder_h-ear_entry_chamfer]) linear_extrude(eps) rounded_rect(w,l,3);
            translate([0,0,holder_h]) linear_extrude(eps)
                rounded_rect(w+2*ear_entry_chamfer,l+2*ear_entry_chamfer,3+ear_entry_chamfer);
        }
        // 上下开口允许从背面放线，无须让 3.5 mm 插头穿小孔。
        for(y=[-l/2,l/2]) translate([-3.5,y-3,-eps]) cube([7,6,holder_h+2*eps]);
    }
}

module stem_clip(side=-1,clip_y=stem_clip_y) {
    // 左右耳镜像放置。外侧留 0.5 mm 缝，避免卡扣与围挡粘成一体。
    translate([side*stem_clip_x,clip_y,0]) difference() {
        union() {
            translate([0,0,stem_clip_axis_z]) rotate([90,0,0])
                cylinder(d=stem_clip_outer_d,h=stem_clip_band,center=true,$fn=64);
            // 加宽根部与槽底连接；耳机柄只接触上面的圆形托面。
            translate([-stem_clip_outer_d/2,-stem_clip_band/2,0])
                cube([stem_clip_outer_d,stem_clip_band,1.4]);
        }
        translate([0,0,stem_clip_axis_z]) rotate([90,0,0])
            cylinder(d=stem_clip_bore_d,h=stem_clip_band+2*eps,center=true,$fn=64);
        translate([-stem_clip_opening/2,-stem_clip_band/2-eps,stem_clip_axis_z])
            cube([stem_clip_opening,stem_clip_band+2*eps,stem_clip_outer_d]);
        // 喇叭口引导耳机柄从背面轻压进入，不跨过耳机头。
        hull() for(i=[0,1])
            translate([0,0,stem_clip_axis_z+1.5+i*2])
                cube([stem_clip_opening+i*2,stem_clip_band+2*eps,eps],center=true);
    }
}

module ear_pocket(side=-1) {
    pocket_ring(ear_space_w,ear_space_l);
    // 同一侧设置两个固定点，不缩小已通过试装的卡扣开口。
    for(y=[stem_clip_y,stem_clip_y-stem_clip_spacing]) stem_clip(side,y);
}

module remote_ring() {
    difference() {
        linear_extrude(holder_h) difference() {
            rounded_rect(remote_space_w+2*holder_t,remote_space_l+2*holder_t,3.5);
            rounded_rect(remote_space_w,remote_space_l,2);
        }
        for(y=[-remote_space_l/2,remote_space_l/2])
            translate([-2.2,y-3,-eps]) cube([4.4,6,holder_h+2*eps]);
    }
}

module front_holes() {
    for(s=[-1,1],x=[-7.5,-2.5,2.5,7.5],y=[-15:5:15])
        translate([s*ear_x+x,y,-eps]) cylinder(d=2.2,h=front_t+2*eps,$fn=32);
    translate([0,0,-eps]) linear_extrude(front_t+2*eps) difference() {
        rounded_rect(remote_window_w,remote_window_l,remote_window_w/2);
        // 两根托条支持较窄的线控；中部保持开放，安装时让麦克风孔避开托条。
        for(y=[-remote_support_y,remote_support_y])
            translate([-remote_window_w,y-remote_support_t/2]) square([2*remote_window_w,remote_support_t]);
    }
}

module cable_exit() {
    // 同轴孔贯穿插舌和下方磁铁座的前部，避开后侧磁铁盲孔。
    translate([0,-R-tenon_l-1,head_center_depth]) rotate([-90,0,0])
        cylinder(d=wire_bore_d,h=tenon_l+17,$fn=96);
}

module body() {
    difference() {
        union() {
            difference() {
                // 背面接缝保留平直密合边，仅对前脸外沿倒角。
                union() {
                    cylinder(d1=head_d-1.2,d2=head_d,h=0.6);
                    translate([0,0,0.6]) cylinder(d=head_d,h=body_depth-0.6);
                }
                translate([0,0,front_t]) cylinder(r=inner_r,h=body_depth);
            }
            // 插舌中心跟随合盖厚度中线；正面朝下打印时，插舌下方需局部支撑。
            translate([-tenon_w/2,-R-tenon_l,tenon_z]) cube([tenon_w,tenon_l+3,tenon_depth]);
            // 平肩承担竖向载荷，避免圆弧底部仅以一条线接触支杆。
            translate([-(tenon_w+6)/2,-R,tenon_z]) cube([tenon_w+6,3,tenon_depth]);
            translate([0,0,front_t-eps]) {
                for(s=[-1,1]) translate([s*ear_x,0,0]) ear_pocket(s);
                remote_ring();
                difference() {
                    cylinder(r=spool_r+spool_t/2,h=8);
                    translate([0,0,-eps]) cylinder(r=spool_r-spool_t/2,h=8+2*eps);
                    for(y=[-spool_r,spool_r]) translate([-5,y-3,-eps]) cube([10,6,8+2*eps]);
                }
            }
            // 磁铁座与外壁重叠连接，避免独立悬浮柱。
            magnet_positions() translate([0,0,front_t-eps]) cylinder(r=boss_r,h=body_depth-front_t+eps);
        }
        front_holes();
        magnet_positions() translate([0,0,body_depth-magnet_hole_h])
            cylinder(d=magnet_hole_d,h=magnet_hole_h+eps,$fn=64);
        cable_exit();
        // 右侧后缘指甲缺口，用于揭开磁吸盖。
        translate([R-1.7,0,body_depth-0.8]) scale([1,1,0.55]) sphere(r=5,$fn=48);
    }
}

module lid() {
    difference() {
        union() {
            // 外表面向下打印，磁铁孔、定位边和限位筋均朝上。
            cylinder(d1=head_d-1.2,d2=head_d,h=0.6);
            translate([0,0,0.6]) cylinder(d=head_d,h=lid_t-0.6);
            translate([0,0,lid_t-eps]) difference() {
                cylinder(r=inner_r-lip_clearance,h=lip_h+eps);
                translate([0,0,-eps]) cylinder(r=inner_r-lip_clearance-lip_t,h=lip_h+3*eps);
                magnet_positions() translate([0,0,-eps]) cylinder(r=boss_r+lip_clearance+0.4,h=lip_h+3*eps);
            }
            // 耳机区的封闭净深设为 20 mm，减少转向后抬出定位槽的空间。
            for(x=[-ear_x,ear_x]) translate([x,0,lid_t-eps])
                linear_extrude(ear_backstop_h+eps) rounded_rect(ear_space_w,ear_space_l,3);
            // 按 8 mm 线控占位和 0.8 mm 垫片检查，仍留 1.9 mm 后向间隙。
            // 这不是实际按钮高度的认证，合盖不得靠挤压按钮实现。
            for(x=[-4.4,4.4]) translate([x-0.9,-21,lid_t-eps])
                cube([1.8,42,remote_backstop_h+eps]);
        }
        magnet_positions() translate([0,0,lid_t-magnet_hole_h])
            cylinder(d=magnet_hole_d,h=magnet_hole_h+eps,$fn=64);
    }
}

module stand() {
    difference() {
        union() {
            beveled_disk(base_d,base_h,0.7);
            translate([0,0,base_h-eps]) cylinder(d1=28,d2=stem_d,h=5);
            translate([0,0,base_h+4.9]) cylinder(d=stem_d,h=stem_top-base_h-4.9);
        }
        translate([-(tenon_w+joint_clearance)/2,-(tenon_depth+joint_clearance)/2,stem_top-tenon_l-0.4])
            cube([tenon_w+joint_clearance,tenon_depth+joint_clearance,tenon_l+0.5]);
        // 插孔入口倒角减少首装阻力；主体保持较长配合面。
        hull() {
            translate([0,0,stem_top-0.8]) cube([tenon_w+joint_clearance,tenon_depth+joint_clearance,0.02],center=true);
            translate([0,0,stem_top+0.01]) cube([tenon_w+joint_clearance+0.8,tenon_depth+joint_clearance+0.8,0.02],center=true);
        }
        // 插头先直穿到底座下方，再将线缆侧放入底面槽，不在管内强行转弯。
        translate([0,0,-eps]) cylinder(d=wire_bore_d,h=stem_top+2*eps,$fn=96);
        translate([-base_slot_w/2,-base_d/2-1,-eps])
            cube([base_slot_w,base_d/2+1,base_slot_h+eps]);
        cable_bend(base_slot_w);
    }
}

module cable_bend(d) {
    // 槽与竖孔之间做圆弧过渡，线缆不顶在直角内棱上。
    for(a=[0:6:84]) hull() for(b=[a,a+6])
        translate([0,-cable_bend_r+cable_bend_r*cos(b),base_slot_h/2+cable_bend_r-cable_bend_r*sin(b)])
            sphere(d=d,$fn=24);
}

module routed_main_cable(d=2.1) {
    translate([0,0,base_slot_h/2+cable_bend_r])
        cylinder(d=d,h=stem_top+15-base_slot_h/2-cable_bend_r,$fn=32);
    cable_bend(d);
    translate([0,-base_d/2-20,base_slot_h/2]) rotate([-90,0,0])
        cylinder(d=d,h=base_d/2+20-cable_bend_r,$fn=32);
}

module fit_coupon() {
    difference() {
        linear_extrude(4.6) rounded_rect(57,18,3);
        for(i=[0:2]) {
            translate([-18+i*18,0,4.6-magnet_hole_h]) cylinder(d=magnet_d+[0.15,0.30,0.45][i],h=magnet_hole_h+eps,$fn=64);
            translate([-18+i*18,-6.5,4.2]) linear_extrude(0.5)
                text(str(magnet_d+[0.15,0.30,0.45][i]),size=2.4,halign="center",valign="center");
        }
    }
}

module ear_fit_coupon() {
    // 与主体左耳槽共用围挡和卡扣，只需复打这一件核对新卡扣松紧。
    union() {
        linear_extrude(front_t) rounded_rect(ear_space_w+2*holder_t+6,ear_space_l+2*holder_t+6,4);
        translate([0,0,front_t-eps]) ear_pocket(-1);
    }
}

// 照片明确了耳机柄靠侧边。现在分开检查耳机头空间与圆杆落座，
// 不再用整块长方体冒充卡扣内部的真实耳机外形。
module content_envelopes() {
    for(s=[-1,1]) {
        translate([s*ear_x,ear_reference[1]/4,front_t+0.8])
            linear_extrude(ear_reference[2]) square([ear_reference[2],ear_reference[1]/2],center=true);
        translate([s*(ear_x+stem_clip_x),(-ear_reference[1]/2+4)/2,front_t+stem_clip_axis_z-eps]) rotate([90,0,0])
            cylinder(d=stem_check_d,h=ear_reference[1]/2+4,center=true,$fn=64);
    }
    translate([0,0,front_t+0.8]) linear_extrude(8)
        rounded_rect(11,54,2);
}

module representative_earpods() {
    for(s=[-1,1]) translate([s*ear_x,0,front_t+0.8]) {
        color([0.97,0.97,0.95]) {
            translate([0,8.8,8.75]) scale([7.25,9,8.75]) sphere(r=1,$fn=48);
            translate([s*stem_clip_x,(-ear_reference[1]/2+4)/2,stem_clip_axis_z-0.8-eps]) rotate([90,0,0])
                cylinder(d=stem_check_d,h=ear_reference[1]/2+4,center=true,$fn=48);
        }
        color([0.15,0.16,0.16]) translate([s*5.8,8.8,12.5]) scale([0.9,4,2.6]) sphere(r=1,$fn=32);
    }
    color([0.98,0.98,0.96]) translate([0,0,front_t+0.8])
        linear_extrude(7) rounded_rect(10.5,51,3.5);
    // 尚未测得两条分支线长，因此不画会被误读为真实线长的绕线圈数。
    // 仅示意壳内 Y 分线器的位置，不代表实物分支长度。
    color([0.95,0.95,0.93]) {
        translate([0,-R+15,head_center_depth]) rotate([-90,0,0]) cylinder(d=5.2,h=8,$fn=32);
    }
}

module head_transform() {
    translate([0,head_center_depth,head_center_h]) rotate([90,0,0]) children();
}

module placed_lid(offset=0) {
    translate([0,0,body_depth+lid_t+offset]) rotate([180,0,0]) children();
}

module assembly(explode=0) {
    color(shell_color) stand();
    if(show_contents) color([0.95,0.95,0.93]) routed_main_cable();
    head_transform() {
        color(shell_color) body();
        if(explode>=0) placed_lid(explode) color(lid_color) lid();
        if(show_contents) representative_earpods();
        color([0.47,0.52,0.55]) {
            magnet_positions() translate([0,0,body_depth-magnet_h]) cylinder(d=magnet_d,h=magnet_h,$fn=64);
            if(explode>=0) placed_lid(explode) magnet_positions() translate([0,0,lid_t-magnet_h]) cylinder(d=magnet_d,h=magnet_h,$fn=64);
        }
    }
}

if(part=="body") body();
else if(part=="lid") lid();
else if(part=="stand") stand();
else if(part=="fit_coupon") fit_coupon();
else if(part=="ear_fit_coupon") ear_fit_coupon();
else if(part=="assembly") assembly();
else if(part=="open") assembly(-1);
else if(part=="exploded") assembly(55);
else if(part=="section") {
    // 移去右半实体，只用于查看连通通道，不能作为打印文件。
    color(shell_color) difference() {
        union() { stand(); head_transform() { body(); placed_lid() lid(); } }
        translate([0,-100,-1]) cube([100,200,220]);
    }
    color([0.95,0.4,0.12]) routed_main_cable();
}
else if(part=="envelopes") content_envelopes();
else if(part=="collision") intersection() {
    union() { body(); placed_lid() lid(); }
    content_envelopes();
}
else if(part=="layout") {
    translate([-65,62,0]) color(shell_color) body();
    translate([65,62,0]) color(lid_color) lid();
    translate([-65,-64,0]) color(shell_color) stand();
    translate([65,-90,0]) color(shell_color) fit_coupon();
    translate([65,-50,0]) color(shell_color) ear_fit_coupon();
}
