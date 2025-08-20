// MIT licence copyright 2025 Jim Dodgen

$fn=120;

base_x= 130;  // width
base_y=67;      // depth
base_z=6;  // thickness/height

mount_x = 48;
mount_y = 57;
mount_z_raw = 30;
mount_z = base_z + mount_z_raw; // makes simpler code
cutout_x = 30; // fox and jonson 32, mccoy-35 33.5, mccoy-19 30
cutout_z = 24; // fox combat special 16.4; Jonson ss 24
//screw_spread_y = 0.625 * 2.54 * 10;  // 5/8 inch;
screw_spread_y = 0.5 * 2.54 * 10;  // 1/2 inch;
echo("screw_spread_y", screw_spread_y);
screw_spread_x = 36.5; //  fox combat special 38.2;  Johnson SS 41.1,  mccoy-35 40, mccoy-19 36.5
offset_from_edge = 33;
hole_d=3;
chop_bottom=false;
difference()
{
    union()
    {
        base();
        mount();
    }
    color("green") cutout();
    holes();
    rounding();
    if (chop_bottom == true)
        translate([0,base_y/2,(mount_z/2)-60])
            cube([base_x,base_y,100], center=true);
}
module holes(offset_from_edge=offset_from_edge, 
        screw_spread_y=screw_spread_y,screw_spread_x=screw_spread_x,hole_d=hole_d)
{
    translate([screw_spread_x/2, offset_from_edge, mount_z/2])
        cylinder(d=hole_d, h=mount_z);
    translate([-screw_spread_x/2, offset_from_edge, mount_z/2])
        cylinder(d=hole_d, h=mount_z);
    translate([screw_spread_x/2, offset_from_edge+screw_spread_y, mount_z/2])
        cylinder(d=hole_d, h=mount_z);
    translate([-screw_spread_x/2, offset_from_edge+screw_spread_y, mount_z/2])
        cylinder(d=hole_d, h=mount_z);
}

module base(base_x=base_x, base_y=base_y, base_z=base_z)
{
    translate([0,base_y/2,base_z/2])
        cube ([base_x,base_y,base_z], center=true);
}

module mount(mount_x=mount_x, mount_y=mount_y, mount_z=mount_z)
{
    translate([0,mount_y/2,mount_z/2])
        cube ([mount_x,mount_y,mount_z], center=true);
}

module cutout(cutout_x=cutout_x, mount_y=mount_y, cutout_z=cutout_z)
{
    translate([0, mount_y/2, mount_z-(cutout_z/2)])
        cube ([cutout_x,mount_y,cutout_z], center=true);
}

module rounding()
{
    translate([-mount_x/2,0,mount_z])
        rotate([0,90,0])
            fillet(0,r=mount_z_raw,h=mount_x);
}

module fillet(rot, r, h) {
    translate([r / 2, r / 2, h/2])
    rotate([0,0,rot]) difference() {
        cube([r + 0.01, r + 0.01, h], center = true);
        translate([r/2, r/2, 0])
            cylinder(r = r, h = h + 1, center = true);
    }
}