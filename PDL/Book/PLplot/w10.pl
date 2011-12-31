#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use PDL::Graphics::PLplot;

my ($t, $data) = rcols(*DATA, 0, []);

my $pl = PDL::Graphics::PLplot->new( DEV => "xwin" );

# Make stripplots with the different time series
# notice data must be transposed

$pl->stripplots($t, $data->transpose);

$pl->close;

__DATA__
#    t      x1     x2     x3
     1      4      6     -1
     2      3      9      3
     3      2      8      7
     3     -1      4     10
     5      1      2      6
     6      5     -1      5

