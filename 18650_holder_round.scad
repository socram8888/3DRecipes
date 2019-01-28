// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

// Number of cells in X
x_count = 3;

// Number of cells in Y
y_count = 2;

// Cell diameter (18 for 18650)
cell_diameter	 = 18 + 0.5;

// Space between cells
battery_padding = 1;

// Border around cells for additional firmness
battery_border = 1.5;

// Height of the tab holding the cells in place
tab_height = 5;

// Width of the cable guide
guide_width = 8;

// Height of the cable guide
guide_height = 2;

difference() {
	union() {
		for (x = [0 : x_count - 1]) {
			for (y = [0 : y_count - 1]) {
				translate([
					x * (battery_padding + cell_diameter	),
					y * (battery_padding + cell_diameter	)
				])
					cylinder(d = cell_diameter	 + battery_padding + 2 * battery_border, h = guide_height + tab_height);
			}
		}
	}

	// Columns
	for (x = [0 : x_count - 1]) {
		translate([
			(battery_padding + cell_diameter	) * x - guide_width / 2,
			-battery_border - battery_padding / 2 - cell_diameter	 / 2
		])
			cube([guide_width, 2 * battery_border + (battery_padding + cell_diameter	) * y_count, guide_height]);
	}

	// Rows
	for (y = [0 : y_count - 1]) {
		translate([
			-battery_border - battery_padding / 2 - cell_diameter	 / 2,
			(battery_padding + cell_diameter	) * y - guide_width / 2
		])
			cube([2 * battery_border + (battery_padding + cell_diameter	) * x_count, guide_width, guide_height]);
	}

	for (x = [0 : x_count - 1]) {
		for (y = [0 : y_count - 1]) {
			translate([
				x * (battery_padding + cell_diameter	),
				y * (battery_padding + cell_diameter	),
				guide_height
			])
				cylinder(d = cell_diameter	, h = tab_height);
		}
	}
}
