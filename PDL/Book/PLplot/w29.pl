#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';
use PDL::IO::Pic;

# Load an image
# (has dims 3 x width x height)
my $pic = rpic('earth.jpg');


# Flip the y axis
$pic = $pic->slice(':,:,-1:0:-1');
# Whiten the image a bit
$pic = 127 + $pic / 2;

my $pl = PLplot->new( DEV => 'mem',
                      MEM => $pic);

# Plot a quadratic curve over the image
my $x=zeroes(51)->xlinvals(-10, 10);
$pl->xyplot($x, $x**2);
$pl->close;

# flip the y axis back and save the image
$pic = $pic->slice(':,:,-1:0:-1');
wpic($pic, 'earth_plot.png');
