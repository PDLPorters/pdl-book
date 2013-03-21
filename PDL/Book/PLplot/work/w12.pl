#!/usr/bin/perl
use strict; 
use warnings;
use PDL::Graphics::PLplot;
use PDL;
use PDL::NiceSlice;

# Generate a noisy time series
my $time = sequence(1000) /10;
my $sinewave = 1 * sin($time) + grandom($time) / 3;

# Save the image to a postscript file
my $pl = PDL::Graphics::PLplot->new( DEV => 'pscairo', FILE => 'inset.eps');

# Plot subset as the main plot
$pl->xyplot($time(0:65), $sinewave(0:65), TITLE => 'Noisy Pendulum', 
          YLAB => 'Displacement d [m]', XLAB => 'Time t [s]');

# Plot full data set as inset
$pl->xyplot($time, $sinewave,
     TITLE       => undef,
     VIEWPORT => [0.525, 0.825, 0.525, 0.775],
     BOX         => [$time->minmax, $sinewave->minmax],
     CHARSIZE => 0.6
  );
$pl->close;
