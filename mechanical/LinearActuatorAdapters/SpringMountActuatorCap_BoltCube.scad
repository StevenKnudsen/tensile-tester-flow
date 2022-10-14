actuatorShaftDia = 1.14*25.4; // mm
actuatorShaftHoleDia = 0.5*25.4; // mm
actuatorShaftHoleOffset = (1.29 - 0.93)*25.4; // mm
actuatorShaftHoleOffsetClearance = 6; // mm

capWallThickness = 5; // mm
capOD = actuatorShaftDia + 2 * capWallThickness; // mm
capShaftDepth = 1 * 25.4 + actuatorShaftHoleOffsetClearance; // mm
capEndThickness = 15; // mm
hexBoltHeadDepth = 6.5; // mm
hexBoltCapDia = 16.4; // mm 0.2 margin
hexBoltDia = 10; // mm

module endCap () {
difference() {
  translate([0,0,capEndThickness/2]) cube([capOD, capOD, capEndThickness], center=true);
//  cylinder(h = capEndThickness, r = capOD / 2, $fn = 100);
  translate([0,0,-1]) cylinder(h = hexBoltHeadDepth + 1, r = hexBoltCapDia / 2, $fn = 6);
    translate([0,0,1]) cylinder(h = capEndThickness, r = hexBoltDia/2, $fn=100);}
}

translate([0,0,capShaftDepth]) endCap();

difference() {
  translate([0,0,capShaftDepth/2]) cube([capOD, capOD, capShaftDepth], center=true);
//cylinder(h = capShaftDepth , r = capOD / 2, $fn=100);
translate([0,0,-1]) cylinder(h = capShaftDepth + 1 , r = actuatorShaftDia / 2, $fn=100);
translate([-capOD/2-1,0,capShaftDepth - actuatorShaftHoleDia / 2 - actuatorShaftHoleOffsetClearance]) rotate([0,90,0]) cylinder(h = capOD + 2, r = actuatorShaftHoleDia / 2, $fn=100);
}

