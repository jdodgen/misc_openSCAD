// MIT Licence copyright 2026 Jim Dodgen
// simple round post with a square base 
// base size can be calculated by how many you want in a set
$fn=240;
post_dia = 27;
post_hight = 130 - post_dia/2;
base_thickness = 6;
base_min = 56;
set_width = 143;
posts_per = floor(set_width/base_min);
base_width = set_width/posts_per;
echo( base_width);
cylinder(d=post_dia, h=post_hight);
cube([base_width,base_width,base_thickness], center=true);
translate([0,0,post_hight]) 
    sphere(d=post_dia);
