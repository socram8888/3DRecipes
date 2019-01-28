// Copyright 2018 Marcos Del Sol Vives
// SPDX-License-Identifier: ISC

widewidth = 66;
wideheight = 17;

thinwidth = 63;
thinheight = 17;

thickness = 2;

count_x = 2;
count_y = 4;

margin = 1;

for (x = [0 : count_x - 1]) {
    for (y = [0 : count_y - 1]) {
        translate([x * (widewidth + margin), y * (wideheight + thinheight + margin), 0]) {
            translate([(widewidth - thinwidth) / 2, 0, 0])
                cube([thinwidth, thinheight, thickness]);

            translate([0, thinheight, 0])
                cube([widewidth, wideheight, thickness]);
        }
    }
}
