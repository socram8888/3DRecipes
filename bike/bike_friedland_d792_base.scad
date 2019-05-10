// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

$fn = 100;

base_diam = 65;
base_thickness = 1;

tab_thickness = 1;
tab_height = 3;

screw_distance = 37;
screw_diam = 5;

cable_hole_pos = [-screw_distance / 2, -15];
cable_hole_diam = 4;
cable_hole_tab_thickness = 1;
cable_hole_tab_height = 2;

difference() {
	union() {
		difference() {
			cylinder(d=base_diam + 2 * tab_thickness, h=base_thickness+tab_height);
			
			translate([0, 0, base_thickness])
				cylinder(d=base_diam, h=tab_height+0.01);

			for (i = [-1 : 2 : 1]) {
				translate([i * screw_distance / 2, 0, 0])
					cylinder(d=screw_diam, h=base_thickness+0.01);
			}
		}

		translate([cable_hole_pos[0], cable_hole_pos[1], 0])
			cylinder(d=cable_hole_diam+2 * cable_hole_tab_thickness, h=cable_hole_tab_height+base_thickness);
	}

	translate([cable_hole_pos[0], cable_hole_pos[1], 0])
		cylinder(d=cable_hole_diam, h=cable_hole_tab_height+base_thickness+0.01);

}
