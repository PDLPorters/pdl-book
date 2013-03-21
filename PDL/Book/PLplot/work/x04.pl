#! /usr/bin/env perl
#
# Demo x04 for the PLplot PDL binding
#
# Log plot demo
# (inspired from t/x04.t of module Graphics::PLplot, by Tim Jenness)
#
# Copyright (C) 2004  Rafael Laboissiere
#
# This file is part of PLplot.
#
# PLplot is free software; you can redistribute it and/or modify
# it under the terms of the GNU Library General Public License as published
# by the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# PLplot is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.
#
# You should have received a copy of the GNU Library General Public License
# along with PLplot; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

# SYNC: x04c.c 1.17

use PDL;
use PDL::Graphics::PLplot;
use Math::Trig qw [pi];

# Parse and process command line arguments

plParseOpts (\@ARGV, PL_PARSE_SKIP | PL_PARSE_NOPROGRAM);

# Initialize plplot

plinit ();

plfont (2);

&plot1 (0);
&plot1 (1);

plend ();

sub plot1 {
  my $type = shift;

  pladv (0);

  # Set up data for log plot

  my $f0 = 1.0;
  my ($freql, $ampl, $phase);
  my $i = sequence (101);
  $freql = -2.0 + $i / 20.0;
  my $freq = 10 ** $freql;
  $ampl = 20 * log10 (1 / sqrt (1 + ($freq / $f0) ** 2 ));
  $phase = -(180/pi) * atan2 ($freq, $f0);

  plvpor (0.15, 0.85, 0.1, 0.9);
  plwind (-2, 3, -80, 0);

  # Try different axis and labelling styles

  plcol0 (1);
  if ($type == 0) {
    plbox (0, 0, 0, 0, "bclnst", "bnstv");
  } else {
    plbox (0, 0, 0, 0, "bcfghlnst", "bcghnstv");
  }

  # Plot ampl vs freq

  plcol0 (2);
  plline ($freql, $ampl);
  plcol0 (2);
  plptex (1.6, -30, 1, -20, 0.5, "-20 dB/decade");

  # Put labels on

  plcol0 (1);
  plmtex (3.2, 0.5, 0.5, "b", "Frequency");
  plmtex (2, 0.5, 0.5, "t", "Single Pole Low-Pass Filter");
  plcol0 (2);
  plmtex (5, 0.5, 0.5, "l", "Amplitude (dB)");
  my $nlegend = 1;

  # For the gridless case, put phase vs freq on same plot

  if ($type == 0) {
    plcol0 (1);
    plwind (-2, 3, -100, 0);
    plbox (0, 0, 30, 3, "", "cmstv");
    plcol0 (3);
    plline ($freql, $phase);
    plstring($freql, $phase, "*");
    plcol0 (3);
    plmtex (5, 0.5, 0.5, "r", "Phase shift (degrees)");
    $nlegend = 2;
  }

  # Draw a legend
  my @opt_array   = (PL_LEGEND_LINE, PL_LEGEND_LINE | PL_LEGEND_SYMBOL);
  my @text_colors = (2, 3);
  my @text        = ("Amplitude", "Phase shift");
  my @line_colors = (2, 3);
  my @line_styles = (1, 1);
  my @line_widths = (1, 1);
  my @symbol_colors = (3, 3); # ???
  my @symbol_scales = (1, 1); # ???
  my @symbol_numbers = (4, 4);# ???
  my @symbols        = ('*', '*'); # ???
  
  plscol0a(15, 32, 32, 32, 0.70);
  my ($legend_width, $legend_height) = pllegend(
      PL_LEGEND_BACKGROUND | PL_LEGEND_BOUNDING_BOX, 0,
      0.0, 0.0, 0.1, 15,
      1, 1, 0, 0,
      $nlegend, \@opt_array,
      1.0, 1.0, 2.0,
      1., \@text_colors, \@text,
      0, 0, 0, 0,
      \@line_colors, \@line_styles, \@line_widths,
      \@symbol_colors, \@symbol_scales, \@symbol_numbers, \@symbols);

}
