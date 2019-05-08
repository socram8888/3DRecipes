// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

inner_radius = 111 / PI / 2 - 2;

outer_radius = inner_radius + 2;

ring_height = 20;

tab_to_center = outer_radius;

tab_thickness = 3;

tab_spacing = 2;

tab_length = 55;

tab_alpha = asin(tab_to_center / outer_radius);
tab_y = outer_radius * cos(tab_alpha);

screw_diameter = 4;
screw_margin = 5;

tab_bb_x = -tab_to_center + tab_spacing + 2 * tab_thickness;

support_radius = 8;
support_x = tab_bb_x + support_radius;
support_y = sqrt(pow(outer_radius + support_radius, 2) - pow(support_x, 2));
echo([support_x, support_y]);

difference() {
	union() {
		cylinder(r=outer_radius, h=ring_height);

		translate([-tab_to_center, 0, 0]) {
			cube([tab_thickness + tab_spacing + tab_thickness, tab_y + tab_length, ring_height]);
			cube([tab_to_center + support_x, support_y, ring_height]);
		}
	}

	cylinder(r = inner_radius, h = ring_height);
	translate([-tab_to_center + tab_thickness, 0, 0]) {
		cube([tab_spacing, tab_y + tab_length, ring_height]);
	}

	translate([-tab_to_center - 0.1, tab_y + tab_length - screw_diameter - screw_margin, ring_height / 2])
		rotate([0, 90, 0])
			cylinder(r = screw_diameter, h=tab_spacing + tab_thickness * 2 + 0.2);

	translate([support_x, support_y]) {
		cylinder(r=support_radius, h=ring_height);
	}
}
