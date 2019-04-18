// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

$fn = 100;

wall_thickness = 2;

inner_diam = 19;

insert_diam = 24;
insert_height = 12.5;

base_diam = 26;
base_height = 20;

screw_spacing = 20.5;
screw_thread_diam = 1.5;

cable_diam = 4;
led_diam = 5;

use <bike_mount.scad>;

module shape() {
	// Base
	cylinder(d=base_diam, h=base_height);

	// Insert
	translate([0, 0, base_height])
		cylinder(d=insert_diam, h=insert_height);
}

difference() {
	union() {
		difference() {
			union() {
				shape();
				
				translate([10, 0, 8])
					rotate([-90, 0, 90])
						bike_mount(base_diam/2+3);
			}

			translate([0, 0, wall_thickness])
				cylinder(d=inner_diam, h=base_height+insert_height-wall_thickness+0.01);	
			
			translate([0, inner_diam / 4, 0])
				cylinder(d=cable_diam, h=wall_thickness+0.1);
			translate([0, -inner_diam / 4, 0])
				cylinder(d=led_diam, h=wall_thickness+0.1);
		}

		intersection() {
			shape();
			
			union() {
				translate([-screw_spacing / 2, 0, wall_thickness])
					cylinder(d=screw_thread_diam+wall_thickness*2, h=base_height+insert_height);
				translate([+screw_spacing / 2, 0, wall_thickness])
					cylinder(d=screw_thread_diam+wall_thickness*2, h=base_height+insert_height);
			}
		}
	}

	translate([-screw_spacing / 2, 0, wall_thickness])
		cylinder(d=screw_thread_diam, h=base_height+insert_height);
	translate([+screw_spacing / 2, 0, wall_thickness])
		cylinder(d=screw_thread_diam, h=base_height+insert_height);
}

