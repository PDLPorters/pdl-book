#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $x = zeroes(20)->xlinvals(-3, 3);
my $y = $x**2;
my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'box example 6.eps',
       BACKGROUND => 'SKYBLUE');

# Big plot on left
$pl->xyplot($x, $y, VIEWPORT
       => [0.1, 0.6, 0.1, 0.8]);
# Medium plot on upper right
$pl->xyplot($x, $y, VIEWPORT
       => [0.5, 0.9, 0.6, 0.9]);
# Small plot on lower right
$pl->xyplot($x, $y, VIEWPORT
       => [0.7, 0.9, 0.1, 0.4]);

$pl->close;
