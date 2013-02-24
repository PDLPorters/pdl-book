#!/usr/bin/perl 
#===============================================================================
#
#===============================================================================
use strict;
use warnings;

use PDF::API2;


use lib ( qw(inc) );
use pod2pdf;
use POSIX qw(locale_h);


print "Making FrontPage.pdf...";
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
$text->text('March 2013');

$text->font($font, 24);
$text->translate(70, 90);
$text->text('for PDL 3.000');
# Save the PDF
$pdf->saveas('FrontPage.pdf');

print "done\n";

##############################
# TOC
#############################


open (FIN, "<toc.txt") or die "cannot open toc.txt";

if (-e "toc.pod") {unlink "toc.pod"; print "Deleted old toc.pod\n"};

open (FOUT, ">toc.pod") or die "cannot open toc.pod";

my $h1 = 0;
my $h2 = 0;
my $h3 = 0;
my $h4 = 0;

my $last_level = 1;

print FOUT "=head1 Table of Contents\n\n";

while (<FIN>) {
    next if (! /TOC/);
    chomp;
    my @p = split;
    shift @p;
    shift @p;
    my $page = shift @p;
    my $head = shift @p;
    my $title = join " ", @p;

    my $curr_level = substr $head, -1, 1;

    if ($curr_level == 1) {$h1++;}
    if ($curr_level == 2) {$h2++;}
    if ($curr_level == 3) {$h3++;}
    if ($curr_level == 4) {$h4++;}

    if ($curr_level < $last_level) {
        if ($curr_level == 1) {$h2=0;$h3=0;$h4=0;}
        if ($curr_level == 2) {$h3=0;$h4=0;}
        if ($curr_level == 3) {$h4=0;}
    }

    print FOUT "  ";
    if ($curr_level == 1) { print FOUT "\n  $h1.  "; }
    if ($curr_level == 2) { print FOUT "$h1.$h2  "; }
    if ($curr_level == 3) { print FOUT "$h1.$h2.$h3  "; }
    if ($curr_level == 4) { print FOUT "$h1.$h2.$h3  "; }

    print FOUT "$title - p.$page\n";;

   $last_level = $curr_level;
}

close(FOUT);


my %config = (
    page_number => 0,
    icon_scale => 0.25,
    title => "Table of Contents",
    icon => "PDL/Book/logo2.png",
);

&make_pdf_wrapper("toc.pod","toc.pdf");


sub make_pdf_wrapper {
    my $file = shift;
    my $outpdf = shift;

    print "Making $outpdf from $file...";

    # uses %config from global. yes, I'm lazy.

    open (BLARG,">$outpdf") or die("Cannot open output file $outpdf: $!\n");

    #--Tell the OS we are going to create binary data--------------------------

    setlocale(LC_ALL,'C');
    binmode *BLARG;


    #--Parse our Pod-----------------------------------------------------------

    my $parser = App::pod2pdf->new(%config);
    $parser->parse_from_file($file);
    #$parser->output;
    print BLARG $parser->{pdf}->stringify;
    close(BLARG);

    print "done\n";
    return ($parser->{page_number});

}



