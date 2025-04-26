// funnel Jim Dodgen 2025 GNU General Public License v3
// first made for wide mouth funnel for filling jars.
// then modified when a small 8mm funnel was needed
// should be easy to changes  values for other sizes and styles  
// inside uses a fine $fn and outside very coarse to allow air to escape.

/*  large 48mm hole
fine=400;
course=18;
mouth_d = 120;
tip_d = 48;
height = (mouth_d/2) + 30;
wall = 4;
mouth_height = 70;
cut_mouth_d = mouth_d - wall;
cut_height = cut_mouth_d/2 + 25;

*/
/*   tiny 48mm hole
fine=400;
course=10;
mouth_d = 50;
mouth_height = 35;
tip_d = 8.3;  // outer D
tip_lth = 10;  // subtract a little 
mouth_wall = 4;
tip_wall = 2;

cut_mouth_d = mouth_d - mouth_wall;
cut_height = mouth_height - mouth_wall; //cut_mouth_d/2 - 3;

total_height = mouth_height+tip_lth;

*/



difference()
{
	
	//translate([8,0,0]) 
	color("red")
	union()
	{
		cylinder(d1=mouth_d, d2=0, h=mouth_height, $fn=course);
		cylinder(d=tip_d,  h=total_height, $fn=course);
	}
	cylinder(d1=cut_mouth_d, d2=0, h=cut_height, $fn=fine);
	cylinder(d=tip_d-tip_wall,  h=total_height, $fn=fine);
	//translate([-mouth_d/2,-mouth_d/2, mouth_height]) cube([mouth_d,mouth_d,mouth_d]);
}
	
