// Copyright 2018 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

x_count = 3;
y_count = 1;

battery_diameter = 18;
battery_padding = 1;

guide_height = 2;

tab_height = 5;

guide_width = 8;

wall_thickness = 2;

total_width = (battery_diameter + battery_padding) * x_count - battery_padding + 2 * wall_thickness;
total_height = (battery_diameter + battery_padding) * y_count - battery_padding + 2 * wall_thickness;
total_depth = tab_height + guide_height;

difference() {
	union() {
		// Round corners
		translate([
			wall_thickness + battery_diameter / 2,
			wall_thickness + battery_diameter / 2
		]) {
			// Bottom left
			cylinder(d = wall_thickness * 2 + battery_diameter, h = total_depth);

			// Bottom right
			translate([
				(battery_padding + battery_diameter) * (x_count - 1),
				0
			])
				#cylinder(d = wall_thickness * 2 + battery_diameter, h = total_depth);

			// Top right
			translate([
				(battery_padding + battery_diameter) * (x_count - 1),
				(battery_padding + battery_diameter) * (y_count - 1),
			])
				cylinder(d = wall_thickness * 2 + battery_diameter, h = total_depth);

			// Top left
			translate([
				0,
				(battery_padding + battery_diameter) * (y_count - 1),
			])
				cylinder(d = wall_thickness * 2 + battery_diameter, h = total_depth);
		}

		// Wide part
		translate([
			0,
			battery_padding + battery_diameter / 2
		]) {
			cube([
				total_width,
				(battery_diameter + battery_padding) * (y_count - 1),
				total_depth
			]);
		}

		// Tall part
		translate([
			battery_padding + battery_diameter / 2,
			0
		]) {
			cube([
				(battery_diameter + battery_padding) * (x_count - 1),
				total_height,
				total_depth
			]);
		}
	}

	// Columns
	for (x = [0 : x_count - 1]) {
		translate([x * (battery_diameter + battery_padding) + battery_diameter / 2 - guide_width / 2 + wall_thickness, 0])
			cube([guide_width, total_height, guide_height	]);
	}
	// Rows
	for (y = [0 : y_count - 1]) {
		translate([0, y * (battery_diameter + battery_padding) + battery_diameter / 2 - guide_width / 2 + wall_thickness])
			cube([total_width, guide_width, guide_height	]);
	}

	for (x = [0 : x_count - 1]) {
		for (y = [0 : y_count - 1]) {
			translate([
				(x + 0.5) * battery_diameter + battery_padding * x + wall_thickness,
				(y + 0.5) * battery_diameter + battery_padding * y + wall_thickness,
				guide_height	
			])
				cylinder(d = battery_diameter, h = tab_height);
		}
	}
}
