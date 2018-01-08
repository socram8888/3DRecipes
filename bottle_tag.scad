
// Tweak these parameters to your hearth's content

// Detail
$fn = 100;

// Tag height, in mm
height = 7;

// Inner radius, in mm
radius = 14.5;

// Thickness
thickness = 1.5;

// Name on the tag
name = "Marcos";

// Font for the name. Monospaces works best
font = "Consolas";

// Letters height, in mm
letterheight = 4;

// Spacing between letters, in degrees
letterspacing = 15;

// Letter relief size, in mm
letterrelief = 1;

// END OF CONFIGURATION

difference() {
    // Outer shell
    cylinder(h=height, r=radius+thickness);

    // Inner shell
    cylinder(h=height, r=radius);

    // Hole on the back
    translate([-radius*1.8/2,radius*0.4,0])
    cube([radius*1.8,radius*0.7+thickness,height]);
}

// Draw each letter
for (i = [0 : len(name) - 1]) {
    angle = 90 - (len(name) - 1) * letterspacing / 2 + i * letterspacing;

    translate([-radius * cos(angle), -radius * sin(angle), height / 2 - letterheight / 2])
    rotate([90, 0, angle - 90])
    linear_extrude(height = (thickness + letterrelief))
    text(name[i], size = letterheight, font = font, halign = "center");
}
