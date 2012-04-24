#!/usr/bin/perl
use strict;
use warnings;

use lib ( qw(inc) );
use pod2pdf;
use POSIX qw(locale_h);

=pod

=head1 make_chapters.pl

Reads a user defined list of POD chapters and produces a PDF file in the
root directory.

This program converts "=for html <img sec="xxx">" tags
to C<< O <xxx> >> tags for the C<pod2pdf> converter and
adjusts the relative paths so that you can run C<pod2pdf> in the root
directory.

=head1 USAGE

Edit the command line options in the USER SELECTABLE OPTIONS area of
this program.

=head2 AUTHOR

Matthew Kenworthy <matthew.kenworthy@gmail.com>, 2012 Feb 02

=cut

##################################################
# USER SELECTABLE OPTIONS

my $book_dir        = "PDL/Book/"; # relative path to the PDL Book files
my $book_chapters   = "Genesis FirstSteps Creating Manipulation Operations NiceSlice Functions Threading PGPLOT PLplot graphics_3d Transform Complex Pthreads PP Credits"; # an ordered list of POD files to process

my $tmp = "book_pdf.pod.tmp"; # temporary filename for POD processing

##################################################
# END OF USER SELECTABLE OPTIONS

##################
# old TOC file removal
#
# toc.txt is generated from =head directives in pod2pdf
# so remove any old toc.txt files first
#

if (-e "toc.txt") {unlink "toc.txt"; print "Deleted old toc.txt\n"};

my %config = (
    page_number => 0,
    icon_scale => 0.25,
    title => "Foreward",
    icon => $book_dir."logo2.png",
    toc => 1
);

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

my $last_page_number = 0;

# loop through all the book chapters in order

my $chap_num = 1;

foreach (split " ",$book_chapters) {
    my $chapter = $book_dir . $_ .".pod";

    # check for its existence
    unless (-e $chapter) {
        print "$chapter doesn't exist - skipping\n";
        next;
    }

    # filter on each chapter to put in O<image.png> tags
    print "Found $chapter...";

    open(FIN,$chapter) or die "Cannot open $chapter for reading\n";

    my @chapter_text = <FIN>;

    close(FIN);

    # take the header from the FIRST =head1
    my $title = "Chapter";
    foreach (@chapter_text) {
        if (/^=head1/)
        {
            $title = $_;
            chomp $title;
            $title =~ s/=head1\W*//;
            last;
        }
    }

    my $header = "Chapter $chap_num: $title";
    print "$header from $chapter\n";

    open(FOUT, ">$tmp") or die "Cannot create temporary file $tmp\n";

    while ($_ = shift @chapter_text) {

        my $whole_line = "";
        if (/^=for html/) { # now push on non-empty lines until finished

            chomp;
            $whole_line = $_;

            # ugly, but it works
            while(1) {
                $_ = shift @chapter_text;
                last if ($_ =~ /^$/); # match blank lines
                $whole_line = $whole_line . $_;
            }

            $whole_line =~ /.*src=\"(.*)\">/; # search for quoted image filename
            print FOUT "O<" . $book_dir . "$1>\n\n";

       } else {print FOUT $_;}

    }

    close(FOUT);

    # FOUT now has the text ready for PDF
    my $chapter_file = sprintf("Chapter%02d.pdf", $chap_num);
    print "Writing out $header to $chapter_file\n";

    $config{title} = $header;
    $config{page_number} = $last_page_number;
    ($last_page_number) = make_pdf_wrapper($tmp, $chapter_file);

    #   my $exec_string = "pod2pdf $tmp --icon-scale 0.25 --title '$header' --icon ".$book_dir."logo2.png --output-file ". $chapter_file;

    #  print "Execing $exec_string\n";
    # go ahead and make the call

    ##`$exec_string`;

    $chap_num += 1;

}


# delete the temporary file

unlink($tmp);

print "\n$0 finished.\n\n";


