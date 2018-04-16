// Copyright 2018 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

// Detail
$fn = 60;

// Outer drainer radius, in mm
radius = 60;

// Outer drainer height, in mm
height = 20;

// Thickness of the walls, in mm
wallwidth = 5;

// Width of each fin, in mm
finwidth = 3;

// Space between each fin, in mm
finspacing = 10;

// Height of each fin, in mm
finheight = 5;

intersection() {
    union() {
        difference() {
            cylinder(r=radius, h=height);
            translate([0, 0, wallwidth]) {
                cylinder(r=radius - wallwidth, h=height-wallwidth);
            }
        }

        for (finpos = [finspacing / 2 : finspacing + finwidth : radius]) {
            translate([finpos, -radius, 0])
                cube([finwidth, radius * 2, finheight + wallwidth]);

            translate([-finpos - finwidth, -radius, 0])
                cube([finwidth, radius * 2, finheight + wallwidth]);
        }
    }
    cylinder(r=radius, h=height);
}