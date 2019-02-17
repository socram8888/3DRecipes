
module bike_mount(tab_height=5, tab_thickness=8) {
	inner_diameter = 22;
	outer_diameter = 28;
	zip_width = 5;
	zip_thickness = 3;
	width = 20;

	rotate([0, 0, 180]) {
		translate([-outer_diameter / 2 - tab_height, 0, 0]) {
			difference() {
				union() {
					cylinder(d=outer_diameter, h=width);
					translate([0, -tab_thickness / 2, 0])
						cube([outer_diameter / 2 + tab_height, tab_thickness, width]);
				}
				cylinder(d=inner_diameter, h=width);
				rotate([0, 0, 135])
					cube([outer_diameter, outer_diameter, width]);
				translate([0, 0, width / 4 - zip_width / 2]) {
					difference() {
						cylinder(h=zip_width, d=outer_diameter + zip_thickness);
						cylinder(h=zip_width, d=outer_diameter - zip_thickness);
					}
				}
				translate([0, 0, 3 * width / 4 - zip_width / 2]) {
					difference() {
						cylinder(h=zip_width, d=outer_diameter + zip_thickness);
						cylinder(h=zip_width, d=outer_diameter - zip_thickness);
					}
				}
			}
		}
	}
}
