// under_shelf_glass_holder
// Creative commons licence copyright 2025 Jim Dodgen
$fn=60;
holder_width = 200;
holder_depth = 95;//100;
holder_base_thickness =5;
// 4mm screw_hole using #8 1.25 inch (31mm) screws 
// into ~3/4 inch (~20mm) oak shelf 
screw_hole_d= 5;
screw_lth = 31;
max_penatration_into_shelf = 15;
screw_head_clearance = 17; 

screw_hole_recess = screw_lth - max_penatration_into_shelf;

glass_width = 80;
cutout_width = 48;
cutout_thickness = 17;
cutout_lip_width = 37;
cutout_lip_thickness = 5;

raw_slots = (holder_width/glass_width);
slots = floor(raw_slots);
remainder =  (raw_slots - slots)*glass_width;
spacing = holder_width/slots;
echo("slots", slots, "spacing", spacing, "remainder", remainder);

holder_thickness = cutout_thickness+cutout_lip_thickness+holder_base_thickness;
holder();
module holder()
{
    indent = (spacing-cutout_width)/2;
    difference()
    {
        cube([holder_width,holder_depth, holder_thickness]);
        translate([indent,0,0])
        for(i = [0:slots])
        {
            translate([(i*spacing), 0, holder_base_thickness])
            { 
                cut_out();
            }
            
        }
        translate([(indent/2),(holder_depth/2),0])
            drill_screw_hole();
        translate([holder_width-(indent/2),holder_depth/2,0])
            drill_screw_hole(); 
        translate([(holder_width/2),holder_depth/2,0])
            drill_screw_hole();
    }
    //cylinder(holder_thickness, d=6); 
}
//drill_screw_hole();
module drill_screw_hole()
{
    cylinder(holder_thickness, d=screw_hole_d);
    translate([0,0,screw_hole_recess])
        cylinder(holder_thickness-screw_hole_recess, d=screw_head_clearance); 

}

//cut_out();
module cut_out()
{
    lip_offset = (cutout_width-cutout_lip_width)/2;
    difference()
    {
        union()
        {
            cube([cutout_width, holder_depth, cutout_thickness]);
            
            translate([lip_offset,0,cutout_thickness])
                color("red") cube([cutout_lip_width, holder_depth, cutout_lip_thickness]);
        }         
        translate([0,0,cutout_thickness])
            rotate([-90,0,0])
            color("green")
            fillet(0, lip_offset, holder_depth);
        translate([cutout_width-lip_offset,0,cutout_thickness])
            rotate([-90,0,0])
            color("blue")
            fillet(90, lip_offset, holder_depth);
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

