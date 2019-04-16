// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

$fn = 50;

// Wall thickness
wall_thickness = 2.5;

// Height of the tab protecting the contacts of the button
tab_height = 20;

// Diameters for holes of the button
holes = [7, 7, 5];

// Diameter of the nut holding the button in place
nut_diameter = 14;

// Cable diameter
cable_diameter = 3.9;

// Cable Z pos
cable_z_pos = 7;

// Extra space between holes
hole_margin = 2;

use <bike_mount.scad>;

holes_space = (len(holes) - 1) * (nut_diameter + hole_margin);

difference() {
	translate([-holes_space / 2, 0, 0]) {
		difference() {
			// Use minkowski to smooth edges
			minkowski() {
				// Outer shell
				hull() {
					cylinder(d=nut_diameter, h=tab_height);
					translate([holes_space, 0, 0])
						cylinder(d=nut_diameter, h=tab_height);
				}
				sphere(r=wall_thickness);
			}

			// Hole on the bottom for cabling
			translate([-nut_diameter / 2 - wall_thickness, -nut_diameter / 2 - wall_thickness, -wall_thickness]) {
				cube([(nut_diameter + hole_margin) * len(holes) + wall_thickness * 2, nut_diameter + wall_thickness * 2, wall_thickness]);
			}

			// Hollow inside
			hull() {
				cylinder(d=nut_diameter, h=tab_height);
				translate([holes_space, 0, 0])
					cylinder(d=nut_diameter, h=tab_height);
			}

			// Holes for buttons
			for (i = [0 : len(holes) - 1]) {
				translate([i * (nut_diameter + hole_margin), 0, 0])
					cylinder(d=holes[i], h=tab_height + wall_thickness);
			}
		}
	}

	// Hole for the cable
	translate([7, 0, cable_z_pos]) {
		rotate([90, 0, 0]) {
			cylinder(d=cable_diameter, h=nut_diameter / 2 + wall_thickness);
		}
	}
}

translate([-10, nut_diameter / 2, tab_height + wall_thickness - 14]) {
	rotate([90, 0, 90]) {
		bike_mount(wall_thickness, 15);
	}
}
