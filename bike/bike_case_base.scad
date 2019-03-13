
battery_diameter = 18.2;
battery_length = 65;
battery_holder_thickness = 2;
battery_holder_spacing = 1.5;
battery_count = 6;
battery_holder_height = battery_count * battery_diameter + 2 * battery_holder_thickness + battery_holder_spacing * (battery_count - 1);
battery_holder_hole = 14;

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

holder_x_offset = -5;
holder_y_offset = 0;

wall_height = 53;
wall_thickness = 3;

cube([base_width, base_height, base_thickness]);
translate([base_width-base_thickness, 0, 0]) {
	cube([wall_thickness, base_height, wall_height]);
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
                                translate([(battery_count - 1) * (battery_diameter + battery_holder_spacing), 0, 0]) {
                                    cylinder(d=battery_diameter+battery_holder_thickness*2, h=battery_length+battery_holder_thickness);
                                }
                            }
                            translate([-battery_diameter/2-battery_holder_thickness,-battery_diameter/2-battery_holder_thickness,0]) {
                                cube([battery_holder_height, battery_diameter/2+battery_holder_thickness, battery_length+battery_holder_thickness]);
                            }
                        }

                        for (x = [0:battery_count-1]) {
                            translate([(battery_diameter + battery_holder_spacing) * x, 0]) {
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