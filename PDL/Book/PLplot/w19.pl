#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $x = zeroes(20)->xlinvals(-3, 3);
my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'box example 8.eps',
       BACKGROUND => 'SKYBLUE');

# Sine wave on top
$pl->xyplot($x, sin($x), 
       VIEWPORT => [0.1, 0.9, 0.55, 0.9]);

# Quadratic on bottom
 $pl->xyplot($x, $x**2, 
       VIEWPORT => [0.1, 0.9, 0.1, 0.45],
       BOX => [-3, 3, 0, 9]);

$pl->close;
