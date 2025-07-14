// lamp diffuser Jim Dodgen 2022

top_d = 200;
bottom_d = 100;
height = 100;
wall = 3;
hole=10;


difference()
{	
	color("red")	
		cylinder(d2=top_d, d1=bottom_d, h=height, $fn=120);		
	translate([0,0,wall]) 
		cylinder(d2=top_d, d1=bottom_d, h=height, $fn=120);
	cylinder(d=hole, h=wall, $fn=60);
}
	
