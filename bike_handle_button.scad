// Copyright 2018 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

// Tweak these parameters to your hearth's content

// Wall thickness
wallthickness = 2.5;

// Width of the support
width = 20;

// Diameter of the handlebar
handlediameter = 71 / PI;

// Height of the tab protecting the contacts of the button
tabwallheight = 12;

// Diameter of the hole for the button
buttondiameter = 7;

// Diameter of the nut holding the button in place
buttonnutdiameter = 14;

// Thickness of the zip tie
zipthickness = 1.5;

// Width of the zip tie
zipwidth = 3;

// Number of zip ties
zipcount = 2;

error = 0.01;

// END OF CONFIGURATION

module bevelsquare(width, length, height) {
    translate([-width / 2, 0, 0])
        cube([width, length - width / 2, height]);
    translate([0, length - width / 2, 0])
        cylinder(d=width, h=height);
}

module handletab(length) {
    intersection() {
        difference() {
            bevelsquare(width, length + wallthickness, wallthickness + tabwallheight);
            translate([0, 0, wallthickness])
                bevelsquare(width - 2 * wallthickness, length, tabwallheight);
        }
        
        translate([-width / 2, 0, 0]) {
            cube([width, length + wallthickness, wallthickness + tabwallheight]);
        }
    }
}

difference() {
    union() {
        cylinder(h=width, d=handlediameter + wallthickness * 2);

        translate([-tabwallheight / 2 - wallthickness / 2, 0, width / 2])
            rotate([0, 90, 0])
                difference() {
                    handletab(handlediameter / 2 + wallthickness + buttonnutdiameter + zipthickness);
                    
                    // Hole for the button
                    translate([0, buttonnutdiameter/2 + handlediameter / 2 + wallthickness + zipthickness, 0]) cylinder(d=buttondiameter, h=wallthickness);
                    
                    // One zip hole
                    translate([-width / 5 - zipwidth/2, handlediameter / 2 + wallthickness, 0]) {
                        cube([zipwidth, zipthickness, wallthickness]);
                    }
                    
                    translate([width / 5 - zipwidth/2, handlediameter / 2 + wallthickness, 0]) {
                        cube([zipwidth, zipthickness, wallthickness]);
                    }
            }
    }

    cylinder(h=width+error, d=handlediameter);
    
    translate([-handlediameter / 2 - wallthickness, -handlediameter / 2 - wallthickness, 0])
        cube([handlediameter + 2 * wallthickness, handlediameter / 2 + wallthickness, width]);

}
