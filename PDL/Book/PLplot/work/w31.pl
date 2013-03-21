#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $pl = PLplot->new(
         DEV => 'pscairo',
         FILE => 'text1.eps');

my $x = zeroes(100)->xlinvals(-3,3);
my $y = $x**2;
$pl->xyplot($x, $y);

$pl->setparm(CHARSIZE => 1.2);
# x label on the lower right
$pl->text('Position x [m]',
           TEXTPOSITION => ['b', 3, 1, 1]);

# y label on the upper left
$pl->text('Potential Energy V [J]',
           TEXTPOSITION => ['l', 3.5, 1, 1]);

# title at the center top
$pl->text('Harmonic Oscillator',
           CHARSIZE => 2.5, 
           TEXTPOSITION => ['t', 1.5, 0.5, 0.5]);

$pl->close;
