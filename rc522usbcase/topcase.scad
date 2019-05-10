
include <common.scad>;
include <waves.scad>;
use <orca_simplified.scad>;

difference() {
    intersection() {
        casebase();

        // Get only top lid
        cube([casewidth + 2 * casethickness, caselength + 2 * casethickness, casethickness]);
    }

    translate([casewidth / 2 + casethickness, caselength / 2 + casethickness, 0]) {
        linear_extrude(toplidengraving) {
            waves();
            mirror([1, 0, 0]) {
                translate([0, caselength / 4, 0])
                    text("USB522", 6, halign="center", valign="center");
                
                translate([casewidth / 2 - 7, -caselength / 2 + 6, 0]) {
                    rotate([0, 0, 90]) {
                        //text("\U01F432.cf", 5, "Segoe UI Emoji");//
                        scale(0.08) {
                            orca_simplified();
                        }
                        translate([-1, -4, 0]) {
                            text(".pet", 5);
                        }
                    }
                }
            }
        }
    }
}

// Create the walls
translate([casethickness, casethickness, casethickness])
    difference() {
        cube([casewidth, caselength, toplidtabheight]);
        translate([casethickness, casethickness, 0])
            cube([casewidth - 2 * casethickness, caselength - 2 * casethickness, toplidtabheight]);
}


