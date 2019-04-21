// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

$fn = 100;

base_thickness = 3;
large_diameter = 152;
small_diameter = 70;
circle_distance = 50;

tab_height = 10;
tab_margin = 1;
tab_thickness = 2;

screw_holes = [
	[ 115 / 2, 0 ],
	[ 95 / 2, -95 / 2 ],
	[ 25.5, 50 ]
];

screw_hole_diam = 4.2;

cable_hole_distance = 68;
cable_hole_diam = 4.2;

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

bb_x = 2 * tab_thickness + 2 * tab_margin + large_diameter;
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

			union() {
				translate([-bb_x / 2, tab_height, 0]) {
					rotate([0, 90, 0])
						cylinder(r=tab_height + base_thickness, h=bb_x);
					cube([bb_x, 999, tab_height+base_thickness]);
				}
			}
		}
	}

	translate([0, 0, base_thickness])
		cylinder(r=large_diameter/2+tab_margin, h=tab_height+0.1);

	translate([0, circle_distance, base_thickness])
		cylinder(r=small_diameter/2+tab_margin, h=tab_height+0.1);

	// Screw holes
	for (i = [0 : len(screw_holes) - 1]) {
		for (mirr = [-1 : 2 : 1]) {
			translate([mirr * screw_holes[i][0], screw_holes[i][1], 0])
				cylinder(d=screw_hole_diam, h=base_thickness+0.01);
		}
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
