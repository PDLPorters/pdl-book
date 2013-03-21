#!/usr/bin/perl
use strict; 
use warnings; 
use PDL;
use aliased 'PDL::Graphics::PLplot';

my $pl = PLplot->new(
       DEV => 'pscairo',
       FILE => 'bargraph2.eps');

# Generate some data:
my @colors = qw(red orange yellow green blue purple);
my $votes = random(scalar(@colors));

# Normalize the votes
 $votes /= $votes->sum;

# Make a barchart of the votes.
$pl->bargraph(\@colors, $votes,
      COLOR => 'BLUE',
      BOX => [0, scalar(@colors), 0, 1.1 * $votes->max]
);

$pl->close;
