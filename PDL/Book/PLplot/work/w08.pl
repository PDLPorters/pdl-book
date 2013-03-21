#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

# Generate a time series
my $time = sequence(100)/10;
my $sinewave = 5 * sin($time);
my $cosinewave = 6 * cos($time);

# Save the image to a postscript file
my $pl = PLplot->new(
      DEV => 'pscairo',
      FILE => 'Multiple curves3.eps'
 );

# Plot the sine with full bounds
$pl->xyplot($time, $sinewave,
      BOX => [$time->minmax, $cosinewave->minmax]);

# Plot the cosine in red
$pl->xyplot($time, $cosinewave , COLOR => 'RED');

$pl->close;
