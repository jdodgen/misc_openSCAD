$fn=60;
outer_d = 23.5;
inner_d = 19.5;
height = 65.0;
difference()
{
    cylinder(d=outer_d, h= height,$fn=7);
    cylinder(d=inner_d, h= height,$fn=60);
    translate([0,0,5]) cylinder(d=inner_d+2, h= height-10,$fn=60);
}