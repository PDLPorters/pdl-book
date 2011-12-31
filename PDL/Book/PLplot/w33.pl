#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use PDL::Graphics::PLplot;

my $pl = PDL::Graphics::PLplot->new(
              DEV => 'pscairo',
              FILE => 'legend.eps');


my $x = zeroes(100)->xlinvals(-1.2, 1.2);
my @colors = qw(BLACK GREEN BLUE);
my @labels = qw(Linear Quadratic Cubic);
my $legend_x = pdl(0.3, 0.5);
my $legend_y = -0.5;

# Plot linear, quadratic, and cubic curves with a legend
for my $i (0..2) {

 $pl->xyplot($x, $x**($i+1), COLOR => $colors[$i]);
 
 $pl->xyplot($legend_x, pdl($legend_y, $legend_y), 
         COLOR => $colors[$i]);
 
 $pl->text($labels[$i], COLOR => 'BLACK', 
     TEXTPOSITION => [0.6, $legend_y, 1, 0, 0]);
 
 $legend_y -= 0.2;
}

$pl->close;
