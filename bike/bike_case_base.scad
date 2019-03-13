
battery_diameter = 18.2;
battery_length = 65;
battery_holder_thickness = 3;
battery_holder_spacing = 1.5;
battery_count = 6;
battery_holder_height = battery_count * battery_diameter + 2 * battery_holder_thickness + battery_holder_spacing * (battery_count - 2) + battery_holder_thickness;
battery_holder_hole = 14;
battery_holder_cable_space = 10;

base_width = 90;
base_height = battery_holder_height + 15;
base_thickness = 3;

pcb_width = 52;
pcb_height = 71;
pcb_thickness = 2;
pcb_holder_tab = 2;
pcb_holder_wall = 2.5;
pcb_margin = 3;

holder_hole = 30;

holder_x_offset = -4;
holder_y_offset = 0;

wall_height = 53;
wall_thickness = 3;
wall_supports = 6;
wall_support_thickness = 5;
wall_side_margin = 10;

wall_usable = base_height - 2 * wall_side_margin;

charge_port_diam = 16;

plug_size = [14, 9];

cube([base_width, base_height, base_thickness]);

translate([base_width-base_thickness, 0, 0]) {
	difference() {
		cube([wall_thickness, base_height, wall_height]);
		translate([0, 99, 35])
		rotate([0, 90, 0])
			#cylinder(d = charge_port_diam, h=wall_thickness+1);
		
		for (y = [0:1]) {
			for (z = [0:1]) {
				translate([0, wall_usable * (y + 1) / wall_supports + wall_side_margin + wall_usable / wall_supports * 0.75, (plug_size[0] + 7) * z + 12])
					cube([wall_thickness, plug_size[1], plug_size[0]]);
			}
		}
	}
}

for (x = [0:wall_supports-1]) {
	if (x != 4) {
		translate([base_width - wall_thickness, wall_usable * ((x + 0.5) / wall_supports) + wall_side_margin - wall_support_thickness/2, 0]) {
			rotate([90, 0, 180]) {
				linear_extrude(height=wall_support_thickness) {
					polygon(points=[
						[0, 0],
						[0, wall_height],
						[1, wall_height],
						[10, 0]
					]);
				}
			}
		}
	}
}

translate([base_width / 2 - (battery_length + battery_holder_thickness) / 2 + holder_x_offset,base_height / 2 - battery_holder_height / 2+holder_y_offset,base_thickness-battery_holder_thickness]) {
    difference() {
        union() {
            translate([0, battery_diameter/2+battery_holder_thickness, battery_diameter / 2+battery_holder_thickness]) {
                rotate([90, 0, 90]) {

                    difference() {
                        union() {
                            hull() {
                                cylinder(d=battery_diameter+battery_holder_thickness*2, h=battery_length+battery_holder_thickness);
                                translate([(battery_count - 1) * battery_diameter + (battery_count - 2) * battery_holder_spacing + battery_holder_thickness, 0, 0]) {
                                    cylinder(d=battery_diameter+battery_holder_thickness*2, h=battery_length+battery_holder_thickness);
                                }
                            }
                            translate([-battery_diameter/2-battery_holder_thickness,-battery_diameter/2-battery_holder_thickness,0]) {
                                cube([battery_holder_height, battery_diameter/2+battery_holder_thickness, battery_length+battery_holder_thickness]);
                            }
                        }

						hull() {
							cylinder(d=battery_holder_cable_space, h=battery_length+battery_holder_thickness);
							translate([2 * (battery_diameter + battery_holder_spacing), 0, 0]) {
								cylinder(d=battery_holder_cable_space, h=battery_length+battery_holder_thickness);
							}
						}
						
						hull() {
							translate([3 * (battery_diameter + battery_holder_spacing), 0, 0]) {
								cylinder(d=battery_holder_cable_space, h=battery_length+battery_holder_thickness);
							}
							translate([5 * (battery_diameter + battery_holder_spacing), 0, 0]) {
								cylinder(d=battery_holder_cable_space, h=battery_length+battery_holder_thickness);
							}
						}

                        for (x = [0:2]) {
                            translate([(battery_diameter + battery_holder_spacing) * x, 0]) {
                                cylinder(d = battery_diameter, h=battery_length);
                                cylinder(d = battery_holder_hole, h=battery_length+battery_holder_thickness);
                            }
                        }
						
                        for (x = [3:5]) {
                            translate([battery_diameter * x + battery_holder_spacing * (x - 1) + battery_holder_thickness, 0]) {
                                cylinder(d = battery_diameter, h=battery_length);
                                cylinder(d = battery_holder_hole, h=battery_length+battery_holder_thickness);
                            }
                        }
                    }
                }
            }
            translate([(battery_length + battery_holder_thickness) / 2 - (pcb_width+pcb_holder_wall) / 2, battery_holder_height / 2 - (pcb_height+2*pcb_holder_wall) / 2, battery_diameter+battery_holder_thickness*2]) {
				difference() {
					cube([pcb_width+pcb_holder_wall, pcb_height+2*pcb_holder_wall, pcb_thickness+pcb_margin+pcb_holder_wall]);
					translate([0, pcb_holder_wall+pcb_holder_tab, 0]) {
						cube([pcb_width-pcb_holder_tab, pcb_height-2*pcb_holder_tab, pcb_thickness+pcb_margin+pcb_holder_wall]);
					}
					translate([0, pcb_holder_wall, pcb_margin]) {
						cube([pcb_width, pcb_height, pcb_thickness]);
					}
				}
            }
        }
		// Add +1 due to rounding errors leaving weird borders
		translate([(battery_length + battery_holder_thickness) / 2 - holder_hole / 2, -1, 0]) {
			cube([holder_hole, battery_holder_height+2, 99]);
		}
    }
}
