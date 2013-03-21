#!/usr/bin/perl
use warnings;
use strict;
use PDL;
use PDL::Graphics::PLplot;

# Generate a time series
my $time = sequence(100)/10;
my $sinewave = 5 * sin($time);
# Create the PLplot object: use xwin for display
my $pl = PDL::Graphics::PLplot->new( DEV => "xwin");

# Plot the time series
$pl->xyplot($time, $sinewave
     , XLAB => 'time [s]'
     , YLAB => 'position [cm]'
     , TITLE => 'Mass on Spring'
     );
# Close the PLplot object to finalize
$pl->close;
