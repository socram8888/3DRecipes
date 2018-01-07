
// Tag height, in mm
height = 10;

// Inner radius, in mm
radius = 15;

// Thickness
thickness = 2;

// Name on the tag
name = "Marcos";

// Font for the name. Monospaces works best
font = "Consolas";

// Letters height, in mm
letterheight = 7;

// Spacing between letters, in degrees
letterspacing = 20;

difference() {
    // Outer shell
    cylinder(h=height, r=radius+thickness);

    // Inner shell
    cylinder(h=height, r=radius);

    // Hole on the back
    translate([-radius*1.6/2,radius/2,0])
    cube([radius*1.6,radius*0.5+thickness,height]);

    // Draw each letter
    for (i = [0 : len(name) - 1]) {
        angle = 90 - (len(name) - 1) * letterspacing / 2 + i * letterspacing;
        
        translate([-radius * 0.9 * cos(angle), -radius * 0.9 * sin(angle), height / 2 - letterheight / 2])
        rotate([90, 0, angle - 90])
        linear_extrude(height = 2 * thickness)
        text(name[i], size = letterheight, font = font, halign = "center");
    }
}
