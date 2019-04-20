// Copyright 2019 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

module pie_slice(a1, a2, r=1, d=undef) {
	start = min([a1, a2]);
	end = max([a1, a2]);

	r = (d == undef ? r : d / 2);

	delta = (end - start) % 360;
	delta_pos = delta < 0 ? delta + 360 : delta;

	points = [
		[ 0,  0], // Center
		[+r,  0], // Start (a=0)
		[+r, +r], // Corner of first quadrant
		[-r, +r], // Corner of second quadrant
		[-r, -r], // Corner of third quadrant
		[+r, -r], // Corner of fourth quadrant
		[r * cos(delta_pos), r * sin(delta_pos)] // End point
	];

	possible_paths = [
		[0, 1, 2, 6],
		[0, 1, 2, 3, 6],
		[0, 1, 2, 3, 4, 6],
		[0, 1, 2, 3, 4, 5, 6]
	];

	paths = [possible_paths[floor(delta_pos / 90)]];

	rotate([0, 0, start]) {
		intersection() {
			circle(r=r);
			polygon(points=points, paths=paths);
		}
	}
}
