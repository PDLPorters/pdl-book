#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $pl = PLplot->new(
        DEV => 'pscairo',
        FILE => 'bargraph3.eps');

# voting on letters:
my @letters = ('a' .. 'z');
my $votes = random(0 + @letters);

# Normalize the votes
$votes /= $votes->sum;

# Make a barchart of the votes.
$pl->bargraph(\@letters, $votes,
       COLOR => 'LIGHTGOLDENROD',
       BOX => [0, scalar(@letters) , 0, 1.1 * $votes->max],
       MAXBARLABELS => 10
  );

$pl->close;
