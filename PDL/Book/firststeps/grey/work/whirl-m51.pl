#!/usr/bin/perl 
#===============================================================================
#
#===============================================================================
use strict;
use warnings;

use PDL;
use PDL::Graphics::PGPLOT;
use PDL::AutoLoader;
use PDL::Transform;

my $dev = "whirl_m51.ps/ps";

dev($dev,3,1,{Color=>1,AxisColour=>1, Linewidth=>1, HardLw => 3,
            HardCH=>1.0, WindowWidth=>10, Aspect=>1.0/3});

my $a = rfits "../m51_raw.fits";
imag $a;
imag $a, 0, 1000;
imag $a, 0, 300;


my $PI = 4*atan2(1,1);
use PGPLOT;
$|=1;

##if ($#ARGV < 1) {print "Usage: $0 <opt1> <opt2>\n"; exit;}


