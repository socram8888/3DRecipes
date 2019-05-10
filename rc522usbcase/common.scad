
$fn = 50;

// These are the sizes of the INSIDE of the case
casewidth = 47; // was 45
caselength = 67; // was 65
caseheight = 12;

// This is the normal thickness of the wall for the whole case and the USB supports
casethickness = 1.5; // was 2

// This is the thickness of the wall on the USB adapter
// It has to be slightly thinner there because the USB port doesn't mate otherwise
usbcasethickness = 1.2; // was 1.5

// This is the height of the thinner wall for the USB board
usbcaseheight = 6;

// This is an estimation of the USB board width.
// It's somewhat wider than the real size to account for printing variations and the voltage switch.
usbboardwidth = 16.5; // was 19

// This is the length of the USB board.
// This NEEDS to be precise, because if the board is loose, it'll be pushed inside the case when connecting the USB, and make connection impossible.
usbboardlength = 25.5;
//usbboardlength = 0;

// This is the height of the tabs that support the USB board
usbsupportheight = 5; // was 4

// These variables are the position and size of the USB hole
usbholey = 0.8; // was 2
usbholez = 1;
usbholewidth = 8.5; // was 9
usbholeheight = 3.8; // was 4

// The position and width of the USB voltage selection switch from the front wall.
// They don't need to be particularly accurate.
usbswitchpos = 10;
usbswitchwidth = 3;

// Top lid tab height
toplidtabheight = 4;

// Top lid engraving depth
toplidengraving = 1;

module casebase() {
    translate([casethickness, casethickness, casethickness]) {
        minkowski() {
            cube([casewidth, caselength, caseheight]);
            sphere(r=casethickness);
        }
    };
}
