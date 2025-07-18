// musubi press
// copyright Jim Dodgen 2025 GNU General Public License v3

$fn=200;
x_interior_width = 100;
y_interior_depth = 50;
z_height = 50;
wall = 3;
plunger_thick = 6;
plunger_post_height = z_height - wall;
plunger_diameter = 20;
plunger_clearance = 3;
slot_height = 3;
slot_offset = 4;


make_tube();
make_plunger(offset=y_interior_depth+5);

module make_tube()
    translate([0,0,+z_height/2])
{   difference()
    {
        cube([x_interior_width+wall*2, 
              y_interior_depth+wall*2,
              z_height], center=true);
        cube([x_interior_width, 
              y_interior_depth,
              z_height], center=true);
    }
}

module make_plunger(offset = 0)
{   
    translate([0,offset,0])
    {
        translate([0,0,plunger_thick/2])
        cube([x_interior_width-plunger_clearance, 
              y_interior_depth-plunger_clearance,
              plunger_thick], center=true);
        // bottom shaft
        cylinder(d=plunger_diameter, 
            h=plunger_post_height-slot_offset-slot_height);
        // bottom flare
        flare_d = plunger_diameter*2;
        cylinder(d1=flare_d, d2=0,
                    h=flare_d/1.5);
        cone_height = plunger_diameter/2;  // 45 degree slope
        // lower cone
        translate([0,0,plunger_post_height-slot_offset-slot_height])
            difference() // remove point
            {
                    cylinder(d1=plunger_diameter, d2=0,
                    h=cone_height);
                    translate([0,0,cone_height/2])
                        cylinder(d=plunger_diameter,
                            h=cone_height);          
            }
        // top _cone
        translate([0,0, 
            plunger_post_height-slot_height-cone_height])
            cylinder(d2=plunger_diameter, d1=0,
            h=cone_height);
        // top shaft   
        translate([0,0, 
            plunger_post_height-slot_height])
            cylinder(d=plunger_diameter,
            h=slot_offset);

    }
}
