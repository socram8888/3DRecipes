
$fn = 60;

radius = 60;
height = 20;
wallwidth = 5;
finwidth = 3;
finspacing = 10;
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