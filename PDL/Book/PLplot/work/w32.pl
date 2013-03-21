#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'text2.eps');

# Plot a quadratic
my $x = zeroes(100)->xlinvals(-3,3);
my $y = $x**2;

$pl->xyplot($x, $y, TITLE => 'SHO',
       XLAB => 'Position x [m]',
       YLAB => 'Potential V [J]');

# annotate negative slope at (-2, 4)
$pl->text('Slope is negative',
         TEXTPOSITION => [-1.8, 4.1, 1, -4, 0.5]);

# annotate positive slope at (2, 4)
$pl->text('Slope is positive',
         TEXTPOSITION => [1.9, 3.9, 10, 40, 1]);

$pl->close;
