#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $x = zeroes(20)->xlinvals(-3, 3);
my $y = $x**2;
my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'box example 4.eps',
       BACKGROUND => 'SKYBLUE'
 );

# Center the plot
$pl->xyplot($x, $y,
      YLAB => 'y', XLAB => 'x',
      VIEWPORT => [0.3, 0.7, 0.3, 0.7]
      );

$pl->close;
