$fn=90;
module extendedStop () {
  import("/Users/Knud/Downloads/switch v6 v1a.stl");
  translate([0,-20,0]) import("/Users/Knud/Downloads/switch v6 v1a.stl");
  translate([0,-23,0]) import("/Users/Knud/Downloads/switch v6 v1a.stl");
  color("red") translate([-4.75,-7,0.5]) cube([9.5,8,6.5]);
  color("blue") translate([0,1,4.25]) rotate([90,0,0]) cylinder(h=8,r=5.5);
}

module stopCrop() {
  translate([0,6.2,0]) rotate([0,0,180]) difference() {
    translate([-13,0,0]) cube([26,40,10]);
    translate([0,0,-1]) cylinder(h=12,d=26);
  }
}

difference() {
  extendedStop();
  stopCrop();
  color("green") translate([-4.75,-7,-6]) cube([9.5,8,6.5]);
}

//color("red") translate([-4.75,-7,0.5]) cube([9.5,8,6.5]);
//color("blue") translate([0,1,4.25]) rotate([90,0,0]) cylinder(h=8,r=5.5);
//color("green") translate([-4.75,-7,-6]) cube([9.5,8,6.5]);
