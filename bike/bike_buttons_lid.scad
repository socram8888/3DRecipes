// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

$fn = 50;

// Wall thickness
wall_thickness = 2.5;

// Base thickness
base_thickness = 2;

// Height of the tab protecting the contacts of the button
tab_height = 3;

// Tab thickness
tab_thickness = 1;

// Diameter of the nut holding the button in place
nut_diameter = 14;

// Button count
count = 3;

// Extra space between holes
hole_margin = 2;

holes_space = (count - 1) * (nut_diameter + hole_margin);

hull() {
	cylinder(d=nut_diameter + 2 * wall_thickness, h=base_thickness);
	translate([holes_space, 0])
		cylinder(d=nut_diameter + 2 * wall_thickness, h=base_thickness);
}

translate([0, 0, base_thickness]) {
	difference() {
		hull() {
			cylinder(d=nut_diameter, h=tab_height);
			translate([holes_space, 0])
				cylinder(d=nut_diameter, h=tab_height);
		}
		hull() {
			cylinder(d=nut_diameter - 2 * tab_thickness, h=tab_height);
			translate([holes_space, 0])
				cylinder(d=nut_diameter - 2 * tab_thickness, h=tab_height);
		}
	}
}
