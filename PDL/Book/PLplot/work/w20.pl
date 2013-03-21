#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $x = zeroes(20)->xlinvals(-3, 3);
my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'box example 9.eps',
       BACKGROUND => 'SKYBLUE');

# Sine wave
$pl->xyplot($x, sin($x));

# Plotting a quadratic on top works
# but the bounds are not good
$pl->xyplot($x, $x**2);

$pl->close;
