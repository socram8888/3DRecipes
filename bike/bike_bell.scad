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

screw_hole_distance = 95;
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

module shape(h) {
	cylinder(d=large_total_diam, h=h);
	translate([0, circle_distance, 0])
		cylinder(d=small_total_diam, h=h);
}

difference() {
	shape(base_thickness);

	for (x = [-1 : 2 : 1]) {
		for (y = [-1 : 2 : 1]) {
			translate([x * screw_hole_distance / 2, y * screw_hole_distance / 2, 0])
				cylinder(d=screw_hole_diam, h=base_thickness+0.01);
		}
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
