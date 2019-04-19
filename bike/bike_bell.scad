// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

$fn = 50;

base_thickness = 3;
large_diameter = 150;
small_diameter = 68;
circle_distance = 50;
tab_height = 30;
tab_margin = 3;

tab_thickness = 3;

corner_screw_distance = 95;
center_screw_distance = 115;
screw_hole_diam = 4;

cable_hole_distance = 68;
cable_hole_diam = 4.1;

large_total_diam = large_diameter+tab_margin+tab_thickness;
small_total_diam = small_diameter+tab_margin+tab_thickness;

tie_holes = [
	[
		[52, 22],
		[62, 9]
	],
	[
		[-48, 27],
		[-60, 22]
	],
	[
		[-42, -21],
		[-52, -26]
	],
	[
		[11, -52],
		[22, -63]
	]
];

tie_width = 5;
tie_height = 3;

tie_reinforcement_height = 3;
tie_reinforcement_width = 7;
tie_reinforcement_bevel = 3;

module shape(h) {
	cylinder(d=large_total_diam, h=h);
	translate([0, circle_distance, 0])
		cylinder(d=small_total_diam, h=h);
}

difference() {
	shape(base_thickness);

	for (x = [-1 : 2 : 1]) {
		for (y = [-1 : 2 : 1]) {
			translate([x * corner_screw_distance / 2, y * corner_screw_distance / 2, 0])
				cylinder(d=screw_hole_diam, h=base_thickness+0.01);
		}
	}

	for (x = [-1 : 2 : 1]) {
		translate([x * center_screw_distance / 2, 0, 0])
			cylinder(d=screw_hole_diam, h=base_thickness+0.01);
	}

	translate([0, cable_hole_distance, 0])
		cylinder(d=cable_hole_diam, h=base_thickness+0.01);

	for (i = [0 : len(tie_holes) - 1]) {
		tie_pair = tie_holes[i];
		angle_between_holes = atan2(tie_pair[1][1] - tie_pair[0][1], tie_pair[1][0] - tie_pair[0][0]);
		for (j = [0 : 1]) {
			translate([tie_pair[j][0], tie_pair[j][1], base_thickness/2]) {
				rotate([0, 0, angle_between_holes])
				cube([tie_height, tie_width, base_thickness+0.1], center=true);
			}
		}
	}
}

translate([0, 0, base_thickness]) {
	difference() {
		intersection() {
			shape(tab_height);
			translate([-large_total_diam/2, tab_height, 0]) {
				rotate([0, 90, 0])
					cylinder(h=large_total_diam, r=tab_height);
				cube([large_total_diam, circle_distance+small_total_diam/2-tab_height, tab_height]);
			}
		}

		cylinder(d=large_diameter+tab_margin, h=tab_height+0.1);
		translate([0, circle_distance, 0])
			cylinder(d=small_diameter+tab_margin, h=tab_height+0.1);
	}
}

for (i = [0 : len(tie_holes) - 1]) {
	hole_a = tie_holes[i][0];
	hole_b = tie_holes[i][1];

	center_x = (hole_a[0] + hole_b[0]) / 2;
	center_y = (hole_a[1] + hole_b[1]) / 2;
	angle_between_holes = atan2(hole_b[1] - hole_a[1], hole_b[0] - hole_a[0]);
	support_size = sqrt(pow(hole_b[0] - hole_a[0], 2) + pow(hole_b[1] - hole_a[1], 2)) - tie_height;

	translate([center_x, center_y, base_thickness])
		rotate([90, 0, angle_between_holes]) {
			scale([support_size, tie_reinforcement_height * 2, tie_reinforcement_width])
				intersection() {
					cylinder(d=1, h=1, center=true);
					translate([-0.5, 0, -0.5])
						cube([1, 0.5, 1]);
				}
			for (rot_y = [0 : 180 : 180])
				rotate([0, rot_y, 0])
					translate([0, 0, tie_reinforcement_width / 2])
						scale([support_size, tie_reinforcement_height * 2, tie_reinforcement_bevel*2])
							intersection() {
								sphere(d=1);
								translate([-0.5, 0, 0])
									cube([1, 0.5, 0.5]);
							}
		}
}
