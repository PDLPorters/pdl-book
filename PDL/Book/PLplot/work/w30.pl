#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

# Generate a time series
my $time = sequence(100)/10;
my $sinewave = 5 * sin($time);

# Create the PLplot object:
my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'Typesetting.eps');

# Plot the time series
$pl->xyplot($time, $sinewave,
       XLAB => '#fi time #fn [Hz#u-1#d]',
       YLAB => '#fiposition#fn [cm]',
       TITLE => '#frMass on Spring'
     );

# Close the PLplot object to finalize
$pl->close;
