#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

# Generate a time series
my $time = sequence(100)/10;

# Save the image to a postscript file
my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'subpages.eps',
       SUBPAGES => [2,2]);

# Plot the time series
$pl->xyplot($time, sin($time), TITLE => 'Sine');

$pl->xyplot($time, cos($time), TITLE => 'Cosine', 
            SUBPAGE => 0);

$pl->xyplot($time, tan($time), TITLE => 'Tangent', 
            SUBPAGE => 4);

$pl->xyplot($time, $time**2, TITLE => 'Squared', 
            SUBPAGE => 3);

$pl->close;
