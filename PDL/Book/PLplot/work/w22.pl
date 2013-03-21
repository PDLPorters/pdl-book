#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'shadeplot3.eps');

# Define z = sin(x) + cos(y), a 2D piddle:
my $x=zeroes(51)->xlinvals(-10, 10);
my $y=zeroes(51)->xlinvals(1, 7);
my $z=sin($x) + cos($y->transpose);

# Make a shade plot with 15 color steps:
$pl->shadeplot($z, 15,
    BOX => [$x->minmax, $y->minmax],
    XLAB => 'x', YLAB => 'y',
    TITLE => 'Egg Carton');

# Add a 'vertical' color key:
$pl->colorkey($z, 'v', VIEWPORT
    => [0.93, 0.96, 0.15, 0.85],
    XLAB => '', YLAB => '', TITLE => 'depth');

$pl->close;


