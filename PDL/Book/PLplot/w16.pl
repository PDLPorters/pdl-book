#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $x = zeroes(20)->xlinvals(-3, 3);
my $y = $x**2;
my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'box example 5.eps',
       BACKGROUND => 'SKYBLUE'
 );

# Try extreme bounds for the viewport
$pl->xyplot($x, $y , 
       YLAB => 'y', 
       XLAB => 'x', 
       VIEWPORT  => [0, 1, 0.3, 1]
       );

 $pl->close;
