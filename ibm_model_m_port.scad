// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

$fn=32;

// Height of the base piece that clips on the pins
base_height = 5;

// Space between pins
pin_spacing = 24.5;

// Diameter of plastic pins
pin_diameter = 3.7;

// Thickness of bridge connecting both pins
pin_bridge_thickness = 4;

// Diameter of holders that go around the pins
pin_holder_diameter = 10;

wall_thickness = 4;
wall_width_lower = 19.2;
wall_width_upper = 21; // was 21.2
wall_height = 12.8; // was 14

// Distance from pin center to the wall where the hole is
pin_wall_distance = 7.4; // was 7.3

// Wall-bridge connection offset
wall_bridge_offset = 5;

// Wall-bridge connection thickness
wall_bridge_thickness = 9;

// Cable size
cable_width = 6;
cable_height = 6;

// Zip tie thickness, needed to leave space between holder and PCB
zip_thickness = 2.5;

// Cable hole radius
cable_hole_radius = 0.5;

module hole_bevel_profile() {
	let (
			bb_width = cable_height / 2 + cable_hole_radius
	) {

		difference() {
			square([bb_width, cable_hole_radius]);
			translate([bb_width, cable_hole_radius])
				circle(r = cable_hole_radius);
		}
		translate([0, cable_hole_radius]) {
			square([cable_height / 2, wall_thickness - cable_hole_radius]);
		}
	}
}

difference() {
	union() {
		// Build holder for left pin
		cylinder(d=pin_holder_diameter, h=base_height);

		// Build the bridge between pin holders
		translate([0, -1, 0])
			cube([pin_spacing, pin_bridge_thickness, base_height]);

		// Build holder for right pin
		translate([pin_spacing, 0, 0])
			cylinder(d=pin_holder_diameter, h=base_height);

		// Center all this crap
		translate([pin_spacing / 2 - wall_width_lower / 2, 0, 0]) {
			// Build the wall
			// TODO: remember to bill Mexico later
			translate([0, wall_thickness + pin_wall_distance, 0]) {
				rotate([90, 0, 0]) {
					difference() {
						linear_extrude(wall_thickness) {
							polygon([
								[0, 0],
								[wall_width_lower, 0],
								[wall_width_lower / 2 + wall_width_upper / 2, wall_height],
								[wall_width_lower / 2 - wall_width_upper / 2, wall_height]
							]);
						};

						// Hole for the cable
						translate([wall_width_lower / 2 - (cable_width - cable_height) / 2, base_height + cable_height / 2, 0]) {
							rotate_extrude() {
								hole_bevel_profile();
							}
							rotate([90, 0, 90]) {
								linear_extrude(cable_width - cable_height) {
									hole_bevel_profile();
								}
							}
							mirror([0, 1, 0]) {
								rotate([90, 0, 90]) {
									linear_extrude(cable_width - cable_height) {
										hole_bevel_profile();
									}
								}
							}
							translate([cable_width - cable_height, 0, 0]) {
								rotate_extrude() {
									hole_bevel_profile();
								}
							}
						}
					}
				}
			}

			// Left connection of wall with bridge
			translate([-wall_bridge_offset, 0, 0]) {
				cube([wall_bridge_thickness, pin_wall_distance, base_height]);
			}

			// Right connection of wall with bridge
			translate([wall_width_lower - wall_bridge_thickness + wall_bridge_offset, 0, 0])
				cube([wall_bridge_thickness, pin_wall_distance, base_height]);

			// Center connection where the zip tie should be put
			translate([wall_width_lower / 2 - cable_width / 2, 0, zip_thickness])
				cube([cable_width, pin_wall_distance, base_height - zip_thickness]);
		}

	}

	// Hole for left pin
	cylinder(d=pin_diameter, h=base_height);

	// Hole for right pin
	translate([pin_spacing, 0, 0])
		cylinder(d=pin_diameter, h=base_height);
}
