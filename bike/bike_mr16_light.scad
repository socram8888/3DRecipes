// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

$fn = 100;

// Thickness of the wall
wall_thickness = 3;

// Diameter of the lamp, excluding the thin rim of the top
lamp_diameter = 47;

// Height of the lamp excluding the pins and the rim
lamp_height = 42;

// Size of the female connector
connector_height = 11;
connector_diameter = 20;

// Space between the connector and the back of the light, so the cables can be folded to the front
connector_padding = 5;

// Thickness of the cables on the connector
connector_cables_thickness = 3;

// Distance of the screw holes to the center of the connector
connector_screw_to_center = 6;

// Diameter of the screw holes
connector_screw_diameter = 4;

// Cable hole
cable_diameter = 5;
cable_pos = 4;

// Battery indication LED diameter
led_diameter = 5;

// Switch diameter
switch_diameter = 6;

use <bike_mount.scad>;

difference() {
	union() {
		difference() {
			union() {
				// Outer shell
				cylinder(d=lamp_diameter+2*wall_thickness, h=lamp_height+connector_height+connector_padding+wall_thickness);
				translate([0, 10, 30])
					rotate([90, 0, 0])
						bike_mount(lamp_diameter/2 + wall_thickness + 5);
			}

			// Hole for the lamp
			translate([0, 0, wall_thickness])
				cylinder(d=lamp_diameter, h=lamp_height+connector_height+connector_padding+0.01);

			// Cable hole
			translate([0, 0, cable_diameter/2+wall_thickness+cable_pos])
				rotate([90, 0, 90])
					cylinder(d=cable_diameter, h=lamp_diameter/2+wall_thickness);

			// LED hole
			translate([0, connector_diameter / 4 + lamp_diameter / 4, 0])
				cylinder(d=led_diameter, h=wall_thickness);

			// Switch hole
			translate([0, -connector_diameter / 4 - lamp_diameter / 4, 0])
				cylinder(d=switch_diameter, h=wall_thickness);
		}

		// Base for the female connector
		cylinder(d=connector_diameter, h=wall_thickness+connector_padding);
	}

	// Make room for the cables coming from the connector
	translate([0, 0, wall_thickness+connector_padding/2])
		cube([connector_diameter,connector_cables_thickness, connector_padding], true);

	// Make holes for the screws
	translate([0, -connector_screw_to_center, 0])
		cylinder(d=connector_screw_diameter, h=wall_thickness+connector_padding);
	translate([0, +connector_screw_to_center, 0])
		cylinder(d=connector_screw_diameter, h=wall_thickness+connector_padding);

}

