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

large_total_diam = large_diameter+2*tab_margin+tab_thickness;
small_total_diam = small_diameter+2*tab_margin+tab_thickness;

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

module shape(h) {
	cylinder(d=large_total_diam, h=h);
	translate([0, circle_distance, 0])
		cylinder(d=small_total_diam, h=h);
}

difference() {
	shape(base_thickness);

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
