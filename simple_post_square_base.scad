// MIT Licence copyright 2026 Jim Dodgen
// simple round post with a square base 
// created to stack things with holes like washers
// base size is calculated by size of container 
// container_width & container_depth to 0 to print one with minimum
// vars
$fn=120;  // adjust
post_dia = 27;
post_hight = 130 - post_dia/2;
base_thickness = 6;
base_minimum = 56; //minimum 
container_width = 275;
container_depth = 275;
//
// math
set_width = base_minimum > container_width ? base_minimum : container_width;
set_depth = base_minimum > container_depth ? base_minimum : container_depth;
posts_per_width = floor(set_width/base_minimum);
posts_per_depth = floor(set_depth/base_minimum);
base_width = set_width/posts_per_width;
base_depth = set_depth/posts_per_depth;
//
echo("base_width",base_width,"base_depth", base_depth);
// shapes and movement
cylinder(d=post_dia, h=post_hight);
cube([base_width,base_depth,base_thickness], center=true);
translate([0,0,post_hight]) 
    sphere(d=post_dia);
