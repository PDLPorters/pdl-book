#!/usr/bin/perl
use warnings;
use strict;
use PDL;
use PDL::Graphics::PLplot;

my $pl = PDL::Graphics::PLplot->new( DEV => "xwin");
my $x  = sequence( 10 );
my $y  = $x**2;
$pl->xyplot( $x, $y );
$pl->close;

