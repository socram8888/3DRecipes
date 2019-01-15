// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

$fn = 20;

// Thickness of the wall
wall_thickness = 3;

// Diameter of the lamp, excluding the thin rim of the top
lamp_diameter = 47;

// Height of the lamp excluding the pins and the rim
lamp_height = 43;

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
cable_diameter = 8;
cable_pos = 4;

// Clamp
clamp_size = [15, 6, 35];
clamp_pos = 35;

// Clamp screw hole diameter
clamp_screw_diameter = 5;

module wave() {
	translate([0, 0, -0.5]) {
		difference() {
			translate([-2, 0, 0])
				cube([4, 1, 1]);
			translate([-2, 0, 0])
				cylinder();
			translate([+2, 0, 0])
				cylinder();
		}
		cylinder();
	}
}


difference() {
	union() {
		difference() {
			union() {
				// Outer shell
				cylinder(d=lamp_diameter+2*wall_thickness, h=lamp_height+connector_height+connector_padding+wall_thickness);

				// Base for the clamp
				translate([0, -clamp_size[1]/2, clamp_pos - clamp_size[2]/2])
					cube([lamp_diameter/2+wall_thickness, clamp_size[1], clamp_size[2]]);

				translate([lamp_diameter/2+clamp_size[0]/2+wall_thickness, 0, clamp_pos])
					difference() {
						// Clamp itself
						resize(clamp_size)
							rotate([0, 90, 90])
								wave();

						// Hole in the clamp for screw
						translate([0, 500, 0])
						rotate([90, 90, 0])
							cylinder(d=clamp_screw_diameter, h=1000);
					}
			}

			// Hole for the lamp
			translate([0, 0, wall_thickness])
				cylinder(d=lamp_diameter, h=lamp_height+connector_height+connector_padding);

			// Cable hole
			translate([0, 0, cable_diameter/2+wall_thickness+cable_pos])
				rotate([90, 0, 90])
					cylinder(d=cable_diameter, h=lamp_diameter/2+wall_thickness);
		}

		// Base for the female connector
		cylinder(d=connector_diameter, h=wall_thickness+connector_padding);
	}

	// Make room for the cables coming from the connector
	translate([0, 0, wall_thickness+connector_padding/2])
		cube([connector_cables_thickness,connector_diameter,connector_padding], true);

	// Make holes for the screws
	translate([-connector_screw_to_center, 0, 0])
		cylinder(d=connector_screw_diameter, h=wall_thickness+connector_padding);
	translate([+connector_screw_to_center, 0, 0])
		cylinder(d=connector_screw_diameter, h=wall_thickness+connector_padding);

}
