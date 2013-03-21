#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

# Generate a time series
my $time = sequence(100)/10;
my $sinewave = 5 * sin($time);
my $cosinewave = 4 * cos($time);
my $toplot = cat($sinewave, $cosinewave);

# Save the image to a postscript file

my $pl = PLplot->new(
       DEV => 'pscairo'
     , FILE => 'Multidimensional.eps'
 );


# Plot the time series
$pl->xyplot($time, $toplot);

$pl->close;
