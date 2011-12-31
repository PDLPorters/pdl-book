#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

# Save the image to a postscript file
my $pl = PLplot->new(
      DEV => 'pscairo',
      FILE => 'stripplots.eps'
 );

# Generate a time series
my $time = sequence(100)/10;

# Make stripplots with the
#      different time series
$pl->stripplots($time,
      [sin($time), cos($time)],
      XLAB => 'x',
      YLAB => ['sine', 'cosine'],
      COLOR => ['BLUE', 'RED'],
      TITLE => 'Sine and Cosine'
 );

$pl->close;
