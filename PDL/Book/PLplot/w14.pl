#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $x = zeroes(20)->xlinvals(-3, 3);
my $y = $x**2;

my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'box example 3.eps',
       BACKGROUND => 'SKYBLUE'
 );

# Put the plot in the upper right:
$pl->xyplot($x, $y,
       YLAB => 'y', 
       XLAB => 'x',
       VIEWPORT => [0.5, 0.9, 0.6, 0.8]
       );

$pl->close;
