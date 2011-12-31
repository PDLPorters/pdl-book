#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $x = zeroes(20)->xlinvals(-3, 3);
my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'box example 10.eps',
       BACKGROUND => 'SKYBLUE');

# Sine wave
$pl->xyplot($x, sin($x));

# Changing the box for the quadratic
# does not work - bad y ticks
$pl->xyplot($x, $x**2,
       BOX => [-3, 3, 0, 9]);

$pl->close;
