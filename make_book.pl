#!/usr/bin/perl
use strict;
use warnings;

=pod

=head1 make_book.pl

Reads a user defined list of POD chapters and produces a PDF file in the
root directory.

This program converts "=for html <img sec="xxx">" tags
to C<< O <xxx> >> tags for the C<pod2pdf> converter and
adjusts the relative paths so that you can run C<pod2pdf> in the root
directory.

=head1 USAGE

Run from the command prompt and edit your paths and the C<pod2pdf>
command line options in the USER SELECTABLE OPTIONS area of this
program.

=head2 AUTHOR

Matthew Kenworthy <matthew.kenworthy@gmail.com>, 2011 Dec 30

=cut

##################################################
# USER SELECTABLE OPTIONS

my $book_dir        = "PDL/Book/"; # relative path to the PDL Book files
my $book_chapters   = "../Book FirstSteps Piddle Creating NiceSlice Functions Threading PGPLOT PLplot graphics_3d Transform Complex Pthreads PP Genesis Credits"; # an ordered list of POD files to process

my $book_pdf        = "book.pdf"; # output name of PDF book

my $tmp = "book_pdf.pod.tmp"; # temporary filename for POD processing

# exectuable command to produce the PDF - edit as necessary
my $exec_string = "pod2pdf $tmp --icon-scale 0.25 --title 'The PDL Book' --icon ".$book_dir."logo2.png --output-file ". $book_pdf;

##################################################
# END OF USER SELECTABLE OPTIONS


open(FOUT, ">$tmp") or die "Cannot create temporary file $tmp\n";

# loop through all the book chapters in their order

foreach (split " ",$book_chapters) {
    my $chapter = $book_dir . $_ .".pod";

    # check for its existence
    unless (-e $chapter) {
        print "$chapter doesn't exist - skipping\n";
        next;
    }

###    $chapter = "test_book.tmp";

    # filter on each chapter to put in O<image.png> tags
    print "Found $chapter...";

    open(FIN,$chapter) or die "Cannot open $chapter for reading\n";

    while (<FIN>) {

        my $whole_line = "";
        if (/^=for html/) { # now push on non-empty lines until finished

            chomp;
            $whole_line = $_;

            # ugly, but it works
            while(1) {
                $_ = <FIN>; chomp;
                last if ($_ =~ /^$/); # match blank lines
                $whole_line = $whole_line . $_;
            }

            $whole_line =~ /.*src=\"(.*)\">/; # search for quoted image filename
            print FOUT "O<" . $book_dir . "$1>\n\n";

       } else {print FOUT $_;}

    }

    print FOUT "\n=ff\n"; 
#add a Form Feed to the end of each chapter so that new chapters start on new pages

    close(FIN);

    print "done\n";

}

close(FOUT);

print "$tmp = POD files have been filtered for input to pod2pdf\n";

print "execing $exec_string\n";

# go ahead and make the call

`$exec_string`;

# delete the temporary file

unlink($tmp);

print "\n$0 finished.\n\n";


