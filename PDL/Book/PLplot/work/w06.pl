#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $pl = PLplot->new(
    DEV => 'pscairo',
   FILE => 'Multidimensional2.eps');

# Generate a time series and phase offset
my $time = sequence(100)/10;
my $phi = zeroes(4)->xlinvals(0, 3)->transpose;

my $sinewaves = 5*sin($time + $phi);
# Plot the time series and phi color key
$pl->xyplot($time, $sinewaves,
     PLOTTYPE => 'POINTS',
     COLORMAP => $phi,
     TITLE => 'sin(x + #gf)');

$pl->colorkey($phi, 'v',
      TITLE => '#gf',
      VIEWPORT => [0.93, 0.96, 0.15, 0.85]);
$pl->close;
