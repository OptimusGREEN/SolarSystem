// Access controller case
$fn=120;

module top()
{
    difference()
    {
        hull()for(x=[0,50])for(y=[0,33])translate([x,y,0])cylinder(r=4,h=7);
        translate([-2,-2,-1])cube([54,37,7]);
        translate([3-2.45,-2,-1])cube([50-.55-.55,40,7]);
        translate([3-2.45,27.35+6.6-4.9,2])cube([48.9,10,6]); // SPOX
    }
    for(x=[10-2,54-10-2])translate([x-5,-3,0])hull(){cube([10,2,1]);cube([10,1,2]);}
    translate([7,1,5.25])cube([18,17,1.5]);
    translate([41,12,5.1])cube([9+3,13,1.5]);
    translate([33,18,2])cube([2,2,4.5]);
    for(x=[-3,51])for(y=[-2,31])translate([x,y,3])cube([2,4,3.9]);
}

module base()
{
    difference()
    {
        translate([-2,-2,0])cube([54,37,3]);
        for(x=[10-2,54-10-2])translate([x-5,-3,-0.001])hull(){cube([10,2,1]);cube([10,1,2]);}
        translate([-0.2,-0.2,1.2])cube([50+0.4,34+0.4,2]);
        for(x=[1,2,3,4,5,6,8,9,10,11,13,14,15,17,18])translate([x*2.5+0.5,27.35,0.2])cylinder(d1=1.5,d2=2.5,h=1.5);
        for(y=[-0.635,0.635])translate([42.1,24.3+y,0.2])cylinder(d1=1.5,d2=2.5,h=1.5);
        translate([3-2.45,27.35+6.6-4.9,2])cube([48.9,10,4.9]); // SPox
        translate([29.5,16.5,-1])cylinder(d=3.5,h=9);
        translate([43.8-0.2,15.4-0.2,2])cube([7.4+0.4,9+0.4,3.2]);
    }
    translate([-1,2,1])cube([6.8,21.8,2]);
}

rotate([0,180,0])translate([-50,0,-7])top();
translate([0,40,0])base();