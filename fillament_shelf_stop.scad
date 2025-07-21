// MIT Licence Copyright Jim dodgen 2025

spool_d = 200;

height = 10;
depth = 20;  // actual is less spool_d cut out
width = 560;  // I will chop it into pieces for your printer
printer_size = 256;  // min of x or y usualy the same


diagional_c =  sqrt((printer_size*printer_size) + (printer_size*printer_size));
echo("C length", diagional_c);

diaginal_reduction = floor(depth/sqrt(2)+8);
max_piece_width = diagional_c-diaginal_reduction;
pieces = ceil(width/max_piece_width);
echo("pieces", pieces);
each_piece = width/pieces;
echo("each piece", each_piece);



echo("xy reduction", ceil(diaginal_reduction));
rotate([0,0,-45])
{
//cube([max_piece_width, depth, height], center=true);
difference()
    {
    translate([each_piece/2,0,0])
        rotate([0,0,90])
            female_dovetail(max_width=depth-4, min_width=depth-6, depth=5, height=height,           block_width=depth, block_depth=each_piece, clearance=0.25);
    translate([(-each_piece/2)+5,0,0])
        rotate([0,0,90])
            female_dovetail(max_width=depth-3.8, min_width=depth-5.8, depth=5, 
            height=height, block_width=depth, block_depth=10, clearance=0.25);

     translate([-each_piece/2,0+38,spool_d/2])
        rotate([0,90,0]) cylinder(d=spool_d, h=each_piece, $fn=2000);
     translate([-each_piece/2,-depth/2, height])rotate([0,90,0])
        fillet(0, 2,each_piece, $fn=120);   
    }
}

module fillet(rot, r, h) {
    translate([r / 2, r / 2, h/2])
    rotate([0,0,rot]) difference() {
        cube([r + 0.01, r + 0.01, h], center = true);
        translate([r/2, r/2, 0])
            cylinder(r = r, h = h + 1, center = true);
    }
}
 
//   dovetail code   //
/* translate([0,-15,0]) 
	union() {
		male_dovetail(max_width=10, min_width=8, depth=5, height=30, cutout_width=3, cutout_depth=4);
		translate([-10,-5,0]) cube([20,5,30]);
	}
*/

module female_dovetail_negative(max_width=11, min_width=5, depth=5, height=30, clearance=0.25) {
	union() {
		translate([0,-0.001,-0.05])
			dovetail_3d(max_width+clearance,min_width+clearance,depth,height+0.1);
			translate([-(max_width+clearance)/2, depth-0.002,-0.5])
				cube([max_width+clearance,clearance/2,height+1]);
	}
}

module female_dovetail(max_width=11, min_width=5, depth=5, height=30, block_width=15, block_depth=9, clearance=0.25) {
		difference() {
			translate([-block_width/2,0,0]) cube([block_width, block_depth, height]);
			female_dovetail_negative(max_width, min_width, depth, height, clearance);
		}
}

module male_dovetail(max_width=11, min_width=5, depth=5, height=30, cutout_width=5, cutout_depth=3.5) {
	difference() {
		dovetail_3d(max_width,min_width,depth,height);
		translate([0.001,depth+0.001,-0.05])
			dovetail_cutout(cutout_width, cutout_depth, height+0.1);
	}
}

module dovetail_3d(max_width=11, min_width=5, depth=5, height=30) {
	linear_extrude(height=height, convexity=2)
		dovetail_2d(max_width,min_width,depth);
}

module dovetail_2d(max_width=11, min_width=5, depth=5) {
	angle=atan((max_width/2-min_width/2)/depth);
	echo("angle: ", angle);
	polygon(paths=[[0,1,2,3,0]], points=[[-min_width/2,0], [-max_width/2,depth], [max_width/2, depth], [min_width/2,0]]);
}

module dovetail_cutout(width=5, depth=4, height=30) {
	translate([0,-depth+width/2,0])
		union() {
			translate([-width/2,0,0])
				cube([width,depth-width/2,height]);
			difference() {
				cylinder(r=width/2, h=height, $fs=0.25);
				translate([-width/2-0.05,0.05,-0.05]) cube([width+0.1,width+0.1,height+0.1]);
			}
		}
}


