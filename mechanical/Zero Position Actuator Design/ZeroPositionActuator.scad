$fn=90;
module extendedStop () {
  import("/Users/Knud/Downloads/switch v6 v1a.stl");
  translate([0,-20,0]) import("/Users/Knud/Downloads/switch v6 v1a.stl");
  translate([0,-23,0]) import("/Users/Knud/Downloads/switch v6 v1a.stl");
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
}