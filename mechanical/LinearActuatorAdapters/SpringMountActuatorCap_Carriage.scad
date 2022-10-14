actuatorShaftDia = 1.14*25.4; // mm
actuatorShaftHoleDia = 0.5*25.4; // mm
actuatorShaftHoleOffset = (1.29 - 0.93)*25.4; // mm
actuatorShaftHoleOffsetClearance = 6; // mm

capWallThickness = 5; // mm
capOD = actuatorShaftDia + 2 * capWallThickness; // mm
capShaftDepth = 1 * 25.4 + actuatorShaftHoleOffsetClearance; // mm
capEndThickness = 15; // mm
stoveBoltCapDepth = 5; // mm
stoveBoltCapDia = 18.4; // mm 0.4 margin
stoveBoltSqDepth = 4; // mm
stoveBoltSqLen = 8.4; // mm 0.4 margin
stoveBoltDia = 8; // mm

module endCap () {
difference() {
  cylinder(h = capEndThickness, r = capOD / 2, $fn = 100);
  translate([0,0,-1]) cylinder(h = stoveBoltCapDepth + 1, r = stoveBoltCapDia / 2, $fn = 100);
    color("red")translate([-stoveBoltSqLen/2,-stoveBoltSqLen/2,stoveBoltCapDepth-1]) cube([stoveBoltSqLen,stoveBoltSqLen,stoveBoltSqDepth+1]);
    translate([0,0,1]) cylinder(h = capEndThickness, r = stoveBoltDia/2, $fn=100);}
}

translate([0,0,capShaftDepth]) endCap();

difference() {
cylinder(h = capShaftDepth , r = capOD / 2, $fn=100);
translate([0,0,-1]) cylinder(h = capShaftDepth + 1 , r = actuatorShaftDia / 2, $fn=100);
translate([-capOD/2-1,0,capShaftDepth - actuatorShaftHoleDia / 2 - actuatorShaftHoleOffsetClearance]) rotate([0,90,0]) cylinder(h = capOD + 2, r = actuatorShaftHoleDia / 2, $fn=100);}

