// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

use <../pie.scad>;

$fn = 50;

base_thickness = 3;
large_diameter = 150;
small_diameter = 68;
circle_distance = 50;

tab_height = 30;
tab_margin = 10;
tab_thickness = 3;
tab_a1 = 20;
tab_a2 = 180 - tab_a1;
tab_bevel = 10;

corner_screw_distance = 95;
center_screw_distance = 115;
screw_hole_diam = 4;

cable_hole_distance = 68;
cable_hole_diam = 4.1;

tab_center_y = -large_diameter / 4 + circle_distance / 2 + small_diameter / 2;
peak_radius = max([large_diameter / 2, circle_distance + small_diameter / 2]) + tab_margin + tab_thickness;

tie_holes = [
	//  X,   Y, size, angle
	[ -40,  35,   10,    20 ],
	[  47,  30,   14,   -30 ],
	[ -22, -25,   10,    20 ],
	[  10, -35,   14,   -30 ]
];

tie_width = 5;
tie_height = 3;

tie_reinforcement_height = 4;
tie_reinforcement_width = 7;
tie_reinforcement_bevel = 4;

tie_reinforcement_total = tie_reinforcement_width + 2 * tie_reinforcement_bevel;

difference() {
	union() {
		cylinder(d=large_diameter, h=base_thickness);
		translate([0, circle_distance, 0])
			cylinder(d=small_diameter, h=base_thickness);

		intersection() {
			union() {
				cylinder(r=large_diameter/2 + tab_margin + tab_thickness, h=base_thickness + tab_height);
				translate([0, circle_distance, 0])
					cylinder(r=small_diameter/2 + tab_margin + tab_thickness, h=base_thickness + tab_height);
			}

			translate([0, tab_center_y, 0]) {
				linear_extrude(base_thickness+tab_height)
					pie_slice(r=999, a1=tab_a1, a2=tab_a2);
				rotate([0, 90, tab_a1])
					scale([1, tab_bevel/(base_thickness+tab_height), 1])
						cylinder(h=999, r=base_thickness+tab_height);
				rotate([0, 90, tab_a2])
					scale([1, tab_bevel/(base_thickness+tab_height), 1])
						cylinder(h=999, r=base_thickness+tab_height);
			}
		}
	}

	translate([0, 0, base_thickness])
		cylinder(r=large_diameter/2+tab_margin, h=tab_height+0.1);

	translate([0, circle_distance, base_thickness])
		cylinder(r=small_diameter/2+tab_margin, h=tab_height+0.1);

	// Corner holes for bell screws
	for (x = [-1 : 2 : 1]) {
		for (y = [-1 : 2 : 1]) {
			translate([x * corner_screw_distance / 2, y * corner_screw_distance / 2, 0])
				cylinder(d=screw_hole_diam, h=base_thickness+0.01);
		}
	}

	// Side holes for bell screws
	for (x = [-1 : 2 : 1]) {
		translate([x * center_screw_distance / 2, 0, 0])
			cylinder(d=screw_hole_diam, h=base_thickness+0.01);
	}

	// Cable hole
	translate([0, cable_hole_distance, 0])
		cylinder(d=cable_hole_diam, h=base_thickness+0.01);

	// Holes for ties
	for (i = [0 : len(tie_holes) - 1]) {
		tie_center_x = tie_holes[i][0];
		tie_center_y = tie_holes[i][1];
		tie_size     = tie_holes[i][2];
		tie_angle    = tie_holes[i][3];

		translate([tie_center_x, tie_center_y, 0]) {
			rotate([0, 0, tie_angle]) {
				for (rot = [-1 : 2 : 1]) {
					translate([rot * tie_size / 2, 0, base_thickness/2]) {
						cube([tie_height, tie_width, base_thickness+0.1], center=true);
					}
				}
			}
		}
	}
}

for (i = [0 : len(tie_holes) - 1]) {
	tie_center_x = tie_holes[i][0];
	tie_center_y = tie_holes[i][1];
	tie_size     = tie_holes[i][2];
	tie_angle    = tie_holes[i][3];

	translate([tie_center_x, tie_center_y, base_thickness])
		rotate([90, 0, tie_angle]) {
			scale([(tie_size - tie_height) / tie_reinforcement_height / 2, 1, 1])
				intersection() {
					cylinder(r=tie_reinforcement_height, h=tie_reinforcement_total, center=true);
						translate([tie_reinforcement_height, 0, -tie_reinforcement_total/2])
							rotate([0, -90, 0])
								linear_extrude(tie_reinforcement_height*2)
									polygon([
										[0,0],
										[tie_reinforcement_total, 0],
										[tie_reinforcement_width + tie_reinforcement_bevel, tie_reinforcement_height],
										[tie_reinforcement_bevel, tie_reinforcement_height]
									]);
				}
		}
}
