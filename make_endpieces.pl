#!/usr/bin/perl 
#===============================================================================
#
#===============================================================================
use strict;
use warnings;

use PDF::API2;

# Create a blank PDF file
my $pdf = PDF::API2->new();
# Add a blank page
my $page = $pdf->page();

# Set the page size
$page->mediabox('A4');

# Add a built-in font to the PDF
my $font = $pdf->corefont('Helvetica-Bold');


# Add some text to the page
my $text = $page->text();
$text->font($font, 64);
$text->translate(70, 700);
$text->text('The PDL Book');

$text->font($font, 24);
$text->translate(70, 500);
$text->text('February 2012');

$text->font($font, 24);
$text->translate(70, 90);
$text->text('for PDL v2.4.10');
# Save the PDF
$pdf->saveas('FrontPage.pdf');

