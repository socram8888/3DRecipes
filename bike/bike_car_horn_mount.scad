// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

inner_radius = 165 / PI / 2 - 2;

outer_radius = inner_radius + 2;

ring_height = 23;

tab_to_center = 20;

tab_thickness = 4;

tab_spacing = 2;

tab_length = 25;

tab_alpha = asin(tab_to_center / outer_radius);
tab_y = outer_radius * cos(tab_alpha);

screw_diameter = 4.3;
screw_margin = 5;

difference() {
	union() {
		cylinder(r=outer_radius, h=ring_height);

		translate([-tab_to_center, 0, 0]) {
			cube([tab_thickness, tab_y + tab_length, ring_height]);
		}

		translate([-tab_to_center + tab_spacing + tab_thickness, 0, 0]) {
			cube([tab_thickness, tab_y + tab_length, ring_height]);
		}
	}

	cylinder(r = inner_radius, h = ring_height);
	translate([-tab_to_center + tab_thickness, 0, 0]) {
		cube([tab_spacing, tab_y + tab_length, ring_height]);
	}

	translate([-tab_to_center, tab_y + tab_length - screw_diameter - screw_margin, ring_height / 2])
		rotate([0, 90, 0])
			cylinder(r = screw_diameter, h=tab_spacing + tab_thickness * 2);
}
