// funnel.scad copyright Jim Dodgen 2025 GNU General Public License v3
// first made for wide tip funnel for filling jars.
// then modified when a small 8mm funnel was needed
// should be easy to changes  values for other sizes and styles  
// inside uses a fine $fn and outside very coarse to allow air to escape.

testing = false;  // set to true to cut half off to view walls and adjustments


///*  large 48mm hole   
fine=400;
course=18;
mouth_d = 120;
tip_d = 48;
tip_lth = 0;  // adjustment value
height = (mouth_d/2) + 30;  // too shallow will cause supports to be needed
mouth_wall = 4;  // affexts cut_height also
tip_wall = 4;
mouth_height = 80;
cut_mouth_d = mouth_d - mouth_wall - 5;
cut_height = cut_mouth_d/2 + 12;
total_height = mouth_height+tip_lth;
//*/

/*   tiny 48mm hole
fine=400;
course=10;
mouth_d = 50;
mouth_height = 35;
tip_d = 8.3;  // outer D
tip_lth = 10; 
mouth_wall = 4;
tip_wall = 2;
cut_mouth_d = mouth_d - mouth_wall;
cut_height = mouth_height - mouth_wall; //cut_mouth_d/2 - 3;
total_height = mouth_height+tip_lth;
*/


difference()
{
	union()
	{
		color("red") cylinder(d1=mouth_d, d2=0, h=mouth_height, $fn=course);
		color("pink")cylinder(d=tip_d,  h=total_height, $fn=course);
	}
	color("blue")cylinder(d1=cut_mouth_d, d2=0, h=cut_height, $fn=fine);
	color("purple")cylinder(d=tip_d-tip_wall,  h=total_height, $fn=fine);
	if (testing) // cutout view of walls after adjustments
		translate([0,-mouth_d/2, 0]) cube([mouth_d,mouth_d,mouth_d]);
}
	
