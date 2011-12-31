#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $x = zeroes(20)->xlinvals(-3, 3);
my $y = $x**2;

# Set a custom page size
my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'box example 2.eps',
       BACKGROUND => 'SKYBLUE',
       PAGESIZE => [360, 240]
 );

# Plot a quadratic function:
$pl->xyplot($x, $y, YLAB => 'y', XLAB => 'x');

$pl->close;
