// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

$fn = 100;

height = 3;

outer_diam = 80;

line_width = 8;

hole_inner_diam = 4;
hole_outer_diam = 8;

inner_diam = outer_diam - 2 * line_width;

difference() {
	union() {
		translate([outer_diam / 2 + hole_outer_diam / 2, 0, 0])
			cylinder(d = hole_outer_diam, h = height);
		translate([0, -hole_outer_diam / 2, 0])
			cube([outer_diam / 2 + hole_outer_diam / 2, hole_outer_diam, height]);
		cylinder(d = outer_diam, h = height);
	}
	
	cylinder(d = inner_diam, h = height);
	translate([outer_diam / 2 + hole_outer_diam / 2, 0, 0])
		cylinder(d = hole_inner_diam, h = height);
}


translate([-inner_diam / 2, -line_width / 2, 0])
	cube([inner_diam, line_width, height]);

rotate([0, 0, -135])
	translate([0, -line_width / 2, 0])
		cube([inner_diam / 2, line_width, height]);

rotate([0, 0, 135])
	translate([0, -line_width / 2, 0])
		cube([inner_diam / 2, line_width, height]);
