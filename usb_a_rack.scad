

usba_x = 12.5;
usba_y = 5.1;
usba_z = 10;

spacing_x = 20;
spacing_y = 10;

base_x = 62;
base_y = 62;
z_offset = 0;
base_z = usba_z+z_offset;

echo(base_y/spacing_x);

module base()
{    
    cube([base_x, base_y, base_z]);
}

difference()
{
    base();
    for(x=[spacing_x/4: spacing_x : floor(base_x) - (spacing_x/4)])
    {
        for(y=[spacing_y/4 : spacing_y : floor(base_y) - (spacing_y/4)])
        {
            echo(x);
            translate([x,y,z_offset]) usba_cutout();
        }
    }
    }


module usba_cutout()
{
  cube([usba_x, usba_y, usba_z]);  
}