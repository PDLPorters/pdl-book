#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use PDL::Graphics::PLplot;

# Generate a time series
my $time = sequence(100)/10;
my $sinewave = 5 * sin($time);

# Save the image to a postscript file

my $pl = PDL::Graphics::PLplot->new(
       DEV => 'pscairo'
     , FILE => 'Symbols.eps'
 );

 # Plot the time series as points
 $pl->xyplot($time, $sinewave
          , PLOTTYPE => 'POINTS'
          , SYMBOL       => 843
          , YERRORBAR => grandom($time)/2
     );

 $pl->close;
