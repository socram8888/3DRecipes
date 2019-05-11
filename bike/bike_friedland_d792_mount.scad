// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

$fn = 100;

height = 15;

ring_radius = 165 / PI / 2 - 2;
ring_thickness = 2;

bell_tab_thickness = 3;

screw_distance = 37;
screw_diam = 5;

slit = 1;

reinforcement_width = 27;
reinforcement_dist = 1;

tie_tab_thickness = 2;
tie_tab_size = 4;

tie_count = 2;
tie_width = 4;
tie_thickness = 2;

tie_tab_sum = 2 * tie_tab_thickness + slit;

difference() {
	union() {
		// Base cylinder
		cylinder(r=ring_radius + ring_thickness, h=height);

		// Reinforcement cube
		translate([-reinforcement_width/2, 0, 0])
			cube([reinforcement_width, ring_radius + ring_thickness + reinforcement_dist, height]);
		
		// Tie tab
		rotate([0, 0, 180])
			translate([-tie_tab_sum / 2, 0, 0])
				cube([tie_tab_sum, ring_radius + ring_thickness + tie_tab_size, height]);
	}

	// Hole for mounting
	cylinder(r=ring_radius, h=height+0.1);

	rotate([0, 0, 180]) {
		// Slit
		translate([-slit / 2, 0, 0])
			cube([slit, ring_radius + ring_thickness + tie_tab_size, height]);

		// Tie holes
		for (i = [0 : tie_count - 1]) {
			translate([-tie_tab_sum / 2, ring_radius + ring_thickness, (i + 0.5) * height / tie_count - tie_width / 2])
				#cube([tie_tab_sum, tie_thickness, tie_width]);
		}
	}
}

translate([-screw_distance / 2, ring_radius + reinforcement_dist, height / 2])
	rotate([-90, 0, 0]) {
		difference() {
			union() {
				cylinder(d=height, h=bell_tab_thickness);
				translate([0, -height / 2, 0])
					cube([screw_distance, height, bell_tab_thickness]);
				translate([screw_distance, 0, 0])
					cylinder(d=height, h=bell_tab_thickness);
			}
			cylinder(d=screw_diam, h=bell_tab_thickness+0.01);
			translate([screw_distance, 0, 0])
				cylinder(d=screw_diam, h=bell_tab_thickness+0.01);
		}
	}

