// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

$fn = 50;

insert_diameter = 7.8;
insert_len = 12.8;
insert_center_x = 51 / 2;
insert_height = 3.8;

wall_height = 3;
wall_thickness = 2;
tab_width = 20.8;

screw_diameter = 4.2;

box_width = 24;
box_bottom = 20;
box_top = 25;

symbol_center_x = 17;
symbol_diameter = 6;

module half() {
	difference() {
		union() {
			hull() {
				for (s = [-1 : 2 : 1]) {
					translate([insert_center_x, s * (insert_len-insert_diameter)/2, 0])
						cylinder(d=insert_diameter, h=insert_height+wall_height+wall_thickness);
				}
			}

			translate([0, -insert_len / 2, 0])
				cube([insert_center_x, insert_len, wall_thickness+wall_height]);
			translate([0, -box_bottom, 0])
				cube([box_width/2, box_top + box_bottom, wall_thickness+wall_height]);
			translate([0, box_top - wall_thickness, wall_thickness+wall_height])
				cube([tab_width / 2, wall_thickness, insert_height]);
		}

		translate([0, -box_bottom+wall_thickness, wall_thickness])
			cube([box_width / 2 - wall_thickness, box_top + box_bottom - 2 * wall_thickness, wall_height + 0.1]);
		
		translate([insert_center_x, 0, 0])
			cylinder(d=screw_diameter, h=wall_thickness+wall_height+insert_height+0.1);
		
		translate([symbol_center_x, 0, wall_thickness])
			cylinder(d=symbol_diameter, h=wall_height+0.1);
	}
}

half();
mirror([-1, 0, 0])
	half();
