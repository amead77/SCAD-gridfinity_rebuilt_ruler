include <d:\Portableapps\Files\Programming\SCAD-gridfinity_rebuilt\gridfinity-rebuilt-utility.scad>
//it needs gridfinity-rebuilt to work, this is available on printables.com
//easiest way to test is to download the above, then dump this in the same folder and open it in OpenSCAD
$fa = 8;
$fs = 0.25;

//how many grids in the x, y direction
gridx = 1;
gridy = 3;

gridz = 0;// leave
length = 42; //leave, unless you're using a non standard grid
style_lip = 1; //does nothing right now

//change these to change the angle of the rows
cBackAngle = 30; 

//does nothing, because I made an oopsie
cBackLen = 2; //can you spot what I did ;) <hint... it was supposed to set the gap, instead the gap is defined by the thickness of the slanted parts

//thickness of the slanted parts
cBaseThick = 3;

//change these to change the height of the rows
cRow1height = 10;
cRow2height = 15;
cRow3height = 20;
cRow4height = 25;

//0 for flat bottom, 1 for mag holes, 2 for screw holes, which don't actually go right through, I was thinking it was for heat inserts, but then realised that wouldn't work
cHoles = 2;



function aoffset(ang, reqlen) = 
    reqlen / cos(ang);

module baseplate() {
    // Builds the base plate, this part is taken 99.9% from gridfinity-rebuilt, I just reused the code
    difference() {
        union () {
            gridfinityInit(gridx, gridy, height(gridz), 0, length) {

            };
            gridfinityBase(gridx, gridy, length, 1, 1, cHoles);
        };
    };
};


module slanted_cubes() {
//row 1 (front row first)
//    translate([aoffset(30, cBaseThick), 0, 0]) {
        rotate(a=30, v=[0, 1, 0]) {
            cube([cBaseThick, (length)-4, cRow1height]);
        };
//    }
//row 2
    translate([aoffset(30, cBaseThick) + cBaseThick, 0, 0]) {
        rotate(a=30, v=[0, 1, 0]) {
            cube([cBaseThick, (length)-4, cRow2height]);
        };
    };
//row 3
    translate([aoffset(30, cBaseThick*3) + cBaseThick, 0, 0]) {
        rotate(a=30, v=[0, 1, 0]) {
            cube([cBaseThick, (length)-4, cRow3height]);
        };
    };
//row 4
    translate([aoffset(30, cBaseThick*5) + cBaseThick, 0, 0]) {
        rotate(a=30, v=[0, 1, 0]) {
            cube([cBaseThick, (length)-4, cRow4height]);
        };
    };

};

module main() {
    baseplate();
    translate([-20, -60, 5]) {
        slanted_cubes();
    };
    translate([-20, 22, 5]) {
        slanted_cubes();
    };
}

main();