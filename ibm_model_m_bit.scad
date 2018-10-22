// Copyright 2018 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

module regular_polygon(order, r=1){
	angles=[ for (i = [0 : order - 1]) i * (360 / order) ];
	coords=[ for (th = angles) [r * cos(th), r * sin(th)] ];
	polygon(coords);
}

translate([-12, -4.5, 0]) {
	cube([24, 9, 4]);
}

difference() {
	cylinder(r=4.5, h=42);
	translate([0, 0, 39]) {
		linear_extrude(3) {
			regular_polygon(6, r=3.2);
		}
	}
}
