#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'histogram2.eps');

# Generate some data:
my $data = grandom(1000);

# Get approximate binning:
my $nbins = 20;
my $binwidth =
   ($data->max-$data->min) / $nbins;

my ($x, $y) = hist($data , $data->minmax, $binwidth);

# Make a histogram of that data in 20 bins:
my $fudgefactor = 1.1;

$pl->histogram($data, $nbins,
      BOX => [$x->minmax, 0, $y->max * $fudgefactor]);

$pl->close;
