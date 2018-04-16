// Copyright 2018 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

// Detail
$fn=50;

// Thickness of the walls
wallsize = 1.2;

// Inner coil radius
// Note it's not the radius of the 3D plastic support, but the coil's
iradius = 30;

// Outer radius
oradius = 32;

// Height of the coil
height = 3;

difference() {
    union() {
        cylinder(r=oradius, h=wallsize);
        translate([0, 0, wallsize]) {
            cylinder(r=iradius, h=height);
        }
        translate([0, 0, wallsize+height]) {
            cylinder(r=oradius, h=wallsize);
        }
    }
    cylinder(r=iradius-wallsize, h=2*wallsize+height);
    translate([iradius, -wallsize, wallsize+height]) {
        cube([oradius-iradius, wallsize*2, wallsize]);
    }
}

