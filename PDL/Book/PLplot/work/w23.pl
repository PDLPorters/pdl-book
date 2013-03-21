#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'histogram.eps');

# Generate some data:
my $data = grandom(1000);

# Make a histogram of that data in 20 bins:
$pl->histogram($data, 20);

$pl->close;
