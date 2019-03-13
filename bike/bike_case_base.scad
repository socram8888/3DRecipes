
battery_diameter = 18;
battery_length = 65;
battery_holder_thickness = 3;
battery_holder_spacing = 2;
battery_count = 6;
battery_holder_height = battery_count * battery_diameter + 2 * battery_holder_thickness + battery_holder_spacing * (battery_count - 1);

base_width = 100;
base_height = battery_holder_height + 20;
base_thickness = 3;

pcb_width = 56;
pcb_height = 72;
pcb_thickness = 2;
pcb_holder_thickness = 2;
pcb_margin = 4;

cube([base_width, base_height, base_thickness]);

translate([0,0,0]) {
    difference() {
        union() {
            translate([0, battery_diameter/2+battery_holder_thickness, battery_diameter / 2+battery_holder_thickness]) {
                rotate([90, 0, 90]) {

                    difference() {
                        union() {
                            hull() {
                                cylinder(d=battery_diameter+battery_holder_thickness*2, h=battery_length+battery_holder_thickness);
                                translate([(battery_count - 1) * (battery_diameter + battery_holder_spacing), 0, 0]) {
                                    cylinder(d=battery_diameter+battery_holder_thickness*2, h=battery_length + battery_holder_thickness);
                                }
                            }
                            translate([-battery_diameter/2-battery_holder_thickness,-battery_diameter/2-battery_holder_thickness,0]) {
                                cube([battery_holder_height, battery_diameter/2+battery_holder_thickness, battery_length+battery_holder_thickness]);
                            }
                        }

                        for (x = [0:battery_count-1]) {
                            translate([(battery_diameter + battery_holder_spacing) * x, 0]) {
                                cylinder(d = battery_diameter, h=battery_length);
                            }
                        }
                    }
                }
            }
            translate([(battery_length + battery_holder_thickness) / 2 - (pcb_width+2*pcb_holder_thickness) / 2, battery_holder_height / 2 - (pcb_height+2*pcb_holder_thickness) / 2, battery_diameter+battery_holder_thickness*2]) {
                #cube([pcb_width+2*pcb_holder_thickness, pcb_height+2*pcb_holder_thickness, pcb_thickness+pcb_margin+pcb_holder_thickness]);
            }
        }
    }
}