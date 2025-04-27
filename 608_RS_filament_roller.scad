// Filament Holder
// Jim Dodgen Feb 2022 
// Creative Commons licence, Attribution - Non-Commercial
// This license allows reusers to distribute, remix, adapt, and build upon the material 
// in any medium or format for noncommercial purposes only, 
// and only so long as attribution is given to the creator.
/*
this uses 2 common 608-2RS bearings aka "skate board bearing"
supports are needed under the threads. 
No other supports are required
the pins do not need to be glued
the caps are held on with qty 4, M3-6 screws or longer
*/
$fn=60;
include <threads.scad>;
//
// uncomment parts to make.


// parts to make
translate([15,0,38]) make_mount();
translate([0,40,0]) make_nut();
translate([50,40,0]) make_roller();
translate([0,80,0]) make_bearing_cap();
translate([40,80,0]) make_bearing_cap();
translate([75,40,0]) make_pin();
translate([75,55,0]) make_pin();
// 
roller_lth=82;  // for the typical filament spool
roller_d = 20;

// you should not have to change much below

//bearing size for 608 skate board bearing
bearing_outside_d = 22;
bearing_inside_d = 8;
bearing_thickness = 7;
bearing_inner_race = 11;

bearing_outside_clearance_d = bearing_outside_d+0.2;  // this helps it fit

bearing_offset_from_roller = 1.3; // this is the thickess of the collar on the pin

roller_pin_base_height = 17;
//depth=roller_pin_base_height+0;
bevel=roller_d+6;  // sets the height before trim
roller_d_with_bevel = bevel - 2;   // amout to trim, remove sharp edge
roller_hole_d = 10;   
roller_height = bearing_thickness-1 + roller_pin_base_height;

pin_bearing_d = bearing_inside_d - 0.1;
pin_base_d = roller_hole_d - 0.25; // to fit 10mm
pin_depth = 8;
pin_stop_h = 4.7;
pin_stop_d = 13;


typical_fillament_spool_hole_d= 55;
typical_fillament_spool_hole_depth = 60;

roller_cutout_d = roller_d_with_bevel + 3;

roller_cutout_lth = roller_lth+(bearing_offset_from_roller*2);

roller_bearing_clearance = roller_cutout_d/2;

mount_screw_d = 30;
mount_screw_lth = 22; //20;
pitch=4;
nut_width = mount_screw_lth-2;

mount_lth = (bearing_thickness*2) + roller_lth + (bearing_offset_from_roller*2)+6;
echo ("mount_lth=", mount_lth);
mount_width = roller_d_with_bevel + 6;
mount_height = 38; 

flange_thickness=8; 
flange_x = 39; 
flange_y = mount_height; 

M3_screw_hole = 2.9; 
M3_clearence_hole = 3.4;
M3_hole_depth=10;
M3_bearing_offset = bearing_outside_d/2+3;
M3_head_clearence_hole = 6.2;


// this is a test to: 1) check to see if it fits in the spool hole. 2) print a piece to check threads and bearing fit.
* difference()
{	
	make_mount(); // -flange_thickness-(mount_lth/2)
	spool_hole();
}
// for debugging
*difference()
{
	make_mount(); 
	translate([0,0,-55]) cube([200,100,100], center=true);
}

module make_mount()
{
	rotate([90,180,90])
	{
		difference()
		{
			union() 
			{
				translate([0,mount_height/2,0]) cube([mount_width, mount_height, mount_lth], center=true);
				translate([0, flange_y/2, mount_lth/2-flange_thickness/2]) color("red") cube([flange_x, flange_y, flange_thickness], center=true);
				translate([0, mount_height/2, -mount_lth/2+flange_thickness/2]) color("red") cube([mount_height, mount_height, flange_thickness], center=true);
				
				*translate([0,0,-mount_lth/2+(flange_thickness/2)])
					bearing_cap();
			}			
			// trim part
			translate([mount_width,mount_height/1.5,-flange_thickness]) rotate([0,0,25]) cube([mount_width,mount_height*3,mount_lth], center=true);
			translate([-mount_width,mount_height/1.5,-flange_thickness]) rotate([0,0,-25]) cube([mount_width,mount_height*3,mount_lth], center=true);					
			translate([0,20,-mount_lth/2-mount_width/2+5]) rotate([25,0,0]) color("pink") cube([mount_width*2, mount_height*2, mount_width], center=true);
			
			roller_cutout();
			
			// screw holes
			translate([0,0,  mount_lth/2 - flange_thickness/2])  color("black") bearing_cap_holes();
			translate([0,0, -mount_lth/2 + flange_thickness/2])  color("black") bearing_cap_holes();
				
		}	
		// threaded mount
		translate([0,mount_screw_d/2,mount_lth/2]) 
		difference() 
		{
			metric_thread (diameter=mount_screw_d-0.7, pitch=pitch, length=mount_screw_lth, internal=false);
			translate([0,31,0]) cube([40,40,50], center=true);
		}	
	}
}
module make_bearing_cap()
{	 
	translate([0,0,flange_thickness/2]) rotate([180,0,0]) difference()
	{
		color("gray") 
		scale([1, 0.8, 1]) 
			cylinder(d=mount_height, h = flange_thickness, center=true);
		translate([0,-50,0]) 
			cube([100,100,100], center=true);
		// drill holes
		bearing_cap_holes(size=M3_clearence_hole, depth=20);
		translate([0,3,0]) bearing_cap_holes(size=M3_head_clearence_hole, depth=20);
		translate([0,0,-flange_thickness/2-2]) cylinder(d= bearing_outside_clearance_d, h=flange_thickness);		
	}
}


module bearing_cap_holes(size=M3_screw_hole, depth=M3_hole_depth)
{
	translate([M3_bearing_offset,0, 0])  screw_hole(size=size, depth=depth);
	translate([-M3_bearing_offset,0, 0]) screw_hole(size=size, depth=depth);	
}

//screw_hole();
module screw_hole(size, depth)
{
	rotate([90,0,0]) 
		translate([0,0,-depth]) 
			cylinder(h=depth, d=size, $fn=15, center=false);
}

module roller_cutout()
{ 
	color("green") cylinder(d=roller_cutout_d, h = roller_cutout_lth, center=true);
	color("orange") cylinder(d=roller_bearing_clearance, h = roller_cutout_lth+(bearing_thickness*2)+2, center=true);
	translate([0,0,roller_cutout_lth/2+bearing_thickness/2]) color("blue") cylinder(d=bearing_outside_clearance_d, h = bearing_thickness, center=true);
	translate([0,0,-roller_cutout_lth/2-bearing_thickness/2]) color("purple") cylinder(d=bearing_outside_clearance_d, h = bearing_thickness, center=true);
}

module make_nut()
{
	difference()
	{
		union()
		{
			cylinder(d=mount_screw_d+10,h=nut_width, $fn=6);
			cylinder(d=mount_screw_d+10,h=nut_width/4, $fn=80);
		} 
		metric_thread (diameter=mount_screw_d, pitch=pitch, length=nut_width, internal=true);
	}
}

module make_roller()
{
	roller_hole_depth = pin_depth+2;
	//translate([0,6,0]) 
	difference()
	{
		union()
		{
			cylinder(d=roller_d, h=roller_lth, $fn=80);
			//bevels at each end
			cylinder(h=bevel, d2=0, d1=bevel);
			translate([0,0,roller_lth-bevel]) cylinder(h=bevel, d1=0, d2=bevel);
		}
		// holes
		translate([0,0,roller_lth-roller_hole_depth]) cylinder(d=roller_hole_d, h=roller_hole_depth, $fn=80);
		cylinder(d=roller_hole_d, h=roller_hole_depth, $fn=80);
		
		// trim bevel edge off 
		difference()
		{
			cylinder(d=roller_d_with_bevel+6, h=roller_lth, $fn=80);
			cylinder(d=roller_d_with_bevel, h=roller_lth, $fn=80);
		}
	}
}

module bearing_bracket()
{
	 cylinder(h=total_thickness, d=M3_clearence_hole);
}

module make_pin()
{
	// stop ring
	translate([0,0,-pin_stop_h+pin_depth])
		difference()
		{
			cylinder(d2=pin_stop_d, d1=0, h=pin_stop_h, $fn=80);
			difference()
			{
				cylinder(d=bearing_inner_race+10, h=20, $fn=80);
				cylinder(d=bearing_inner_race, h=20, $fn=80);
			}
		}
	
    // roller insert part
    cylinder(d1=pin_base_d-0.6, d2=pin_base_d, h=pin_depth, $fn=80);
	// bearing insert part
	translate([0,0,pin_depth]) cylinder(d=pin_bearing_d, h=bearing_thickness, $fn=80);
}

module spool_hole()  // for testing the overall size
{
	translate([flange_thickness-4,0,-(typical_fillament_spool_hole_d/2)+(roller_d_with_bevel/2)]) 
		rotate([-90,0,90]) 
			cylinder(d=typical_fillament_spool_hole_d, h=typical_fillament_spool_hole_depth);
}

