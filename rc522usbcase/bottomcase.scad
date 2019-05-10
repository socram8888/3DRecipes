
include <common.scad>;

difference() {
    intersection() {
        casebase();

        // Remove top lid
        cube([casewidth + 2 * casethickness, caselength + 2 * casethickness, casethickness + caseheight]);
    }

    // Make it hollow
    translate([casethickness, casethickness, casethickness]) {
        cube([casewidth, caselength, caseheight]);
    }

    // Thinnen USB wall
    translate([usbcasethickness, casethickness, casethickness]) {
        cube([casethickness - usbcasethickness, usbboardwidth, usbholez + usbholeheight]);
    }

    // Make hole for USB
    translate([0, casethickness + usbholey, casethickness + usbholez])
        cube([casethickness, usbholewidth, usbholeheight]);
}

// Back wall
translate([usbcasethickness + usbboardlength, casethickness, casethickness])
    cube([casethickness, usbboardwidth, usbsupportheight]);

// Side wall, with hole for 
translate([usbcasethickness, casethickness + usbboardwidth, casethickness])
    difference() {
        cube([usbboardlength + casethickness, casethickness, usbsupportheight]);
        translate([usbswitchpos - usbswitchwidth / 2, 0, 0])
            cube([usbswitchwidth, casethickness, usbsupportheight]);
}