// MIT licence copywrite jim dodgen 2021, 2025 
// wine celler tag holder:
// two mounts vertical and horizontal also a template for cutting out tags
//
$fn=60;

holeD=4;
recessD=8.1;

base = 200;
width = sqrt(base*base/2);
//thickness = 5;

slot_width = 110;  // for 4.25 inch paper (2 across per sheet) see template for cutting guide
slot_height = 40;  // for 1.5  inch
silly_slot_height = 300;  // very big
silly_slot_width = 150;  // very big
flat_width = slot_width+5;
additional_for_width_flat = 4;
flat_height = slot_height+additional_for_width_flat;
paper_slot_thickness = 3;
thickness = paper_slot_thickness+2.4;
paper_slot_offset = (thickness - paper_slot_thickness)/2;
tab_y_offset = -4.5;

// two styles, horz or vertical
// tilt_cube  makes a mount for tilted cube wine racks 
// tilt_cube(1); // 0 for top 1 for bottom mounting
//flat(1);

template();  // use to cut out tags

module template() {
    text("LABEL", bold=true, font="OCR\\-A II:style=Regular")
    difference()
    {
        border=20;
        offset=50;
        slot_shift=(offset-border)/2;
        cube([slot_height+border,slot_width+offset,2], center=true);
        translate([0,slot_shift,0])
            cube([slot_height-1,slot_width-0.4,2], center=true);
    } 
}

module flat(flip) {
    difference() {
        union() {
            cube([flat_width, flat_height ,thickness]);
            if (flip == 1) {
                translate([20,0,0]) tab(0,tab_y_offset);
                translate([flat_width-20,0,0]) tab(0,tab_y_offset);                          
            } else {
                translate([20,0,0])  tab(180,(tab_y_offset*-1)+flat_height);
                translate([flat_width-20,0,0])  tab(180,(tab_y_offset*-1)+flat_height);     
            }            
        }
        translate([(slot_width+10)/2+(additional_for_width_flat/2), additional_for_width_flat/2, paper_slot_offset]) slot(slot_height, slot_width+10);        
        // drill holes  
        if (flip == 1) {
            translate([20,tab_y_offset,0]) hole();
            translate([flat_width-20,tab_y_offset,0]) hole();
        } else {
            translate([20,(tab_y_offset*-1)+flat_height,0]) rotate([0,0,180]) hole();
            translate([flat_width-20,(tab_y_offset*-1)+flat_height,0]) hole();     
        } 
    }

}


module tilt_cube(flip) {
    difference() {
        translate([0,-(base/2),0]) rotate([0,0,45]) cube([width,width,thickness]);
        translate([-(base/2),-base,0]) cube([base,base,thickness]);
        translate([-(base/2),(base/2)-57,0]) cube([base,base,thickness]);
        if (flip == 1)
        {
           translate([0,-silly_slot_height+40,paper_slot_thickness])tilt_slot(silly_slot_height, slot_width);
        }
        else
        {
           translate([0,4,paper_slot_offset])tilt_slot(silly_slot_height, slot_width);
        }

        from_edge = 35;
        up = 28;
        translate([(base/2)-from_edge,up,0]) hole();
        translate([-(base/2)+from_edge,up,0]) hole();

        fillet_offset = 60;
        edge_offset = fillet_offset+22;

        translate([fillet_offset,0,-1]) fillet(90, 22, thickness+2);
        translate([edge_offset,0,0]) cube([base,base,thickness]);

        translate([-(base/2)+18,0,-1]) fillet(0, 22, thickness+2);
        translate([-edge_offset-base,0,0]) cube([base,base,thickness]);
    }
}

module slot(height, width, center=true) {
    union() {
        tab=6;
        translate([0,height/2,(paper_slot_thickness*4/2)]) cube([width, height-tab, paper_slot_thickness*4], center = center);
        translate([0,height/2,paper_slot_thickness/2]) cube([width, height, paper_slot_thickness], center = center);
    }
}

module tilt_slot(height, width) {
    union() {
        tab=6;
        translate([0,height/2,(paper_slot_thickness*4/2)]) cube([width-tab, height-tab, paper_slot_thickness*4], center = true);
        translate([0,height/2,paper_slot_thickness/2]) cube([width, height, paper_slot_thickness], center = true);
    }
}

pop_up = thickness/2;
module hole() {

translate([0,0,pop_up]) cylinder(d = holeD, h = thickness, center = true);
translate([0,0,pop_up + 2]) cylinder(d = recessD, h = thickness, center = true);

}

module fillet(rot, r, h) {
    translate([r / 2, r / 2, h/2])
    rotate([0,0,rot]) difference() {
        cube([r + 0.01, r + 0.01, h], center = true);
        translate([r/2, r/2, 0])
            cylinder(r = r, h = h + 1, center = true);
    }
}
//tab(0, tab_y_offset);
module tab (degrees, Yoffset) {
    radi = thickness-pop_up;
    tabD = recessD+6;
    fillet_offset = degrees ? Yoffset - flat_height - radi : -Yoffset - radi;
    translate([0,Yoffset,0]) {
        rotate([0,0,degrees]) {
            translate([0,0,pop_up/2]) {
                cylinder(d = tabD, h = pop_up, center = true); 
                translate([0,tabD/2,0]) cube([tabD,tabD, pop_up], , center = true);
                translate([tabD/2,fillet_offset, pop_up/2])  rotate([0,-90,0]) fillet(-90, radi, tabD);
                //translate([tabD/2,-(Yoffset/2)-.5, pop_up/2])  rotate([0,-90,0]) fillet(-90, radi, tabD);

            }
        }
    }
}

module tilt_tab (degrees, Yoffset) {
    radi = thickness-pop_up;
    tabD = recessD+6;
    fillet_offset = degrees ? Yoffset - (flat_height+10) - radi : -Yoffset - radi;
    translate([0,Yoffset,0]) {
        rotate([0,0,degrees]) {
            translate([0,0,pop_up/2]) {
                cylinder(d = tabD, h = pop_up, center = true); 
                translate([0,tabD/2,0]) cube([tabD,tabD, pop_up], , center = true);
                translate([tabD/2,fillet_offset, pop_up/2])  rotate([0,-90,0]) fillet(-90, radi, tabD);
                //translate([tabD/2,-(Yoffset/2)-.5, pop_up/2])  rotate([0,-90,0]) fillet(-90, radi, tabD);

            }
        }
    }
}




