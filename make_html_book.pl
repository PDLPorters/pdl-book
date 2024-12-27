#!/usr/bin/env perl
use strict;
use warnings;

=pod

=head1 make_html_book.pl

Reads a user defined list of POD chapters and produces a catenated HTML file in the
root directory.

=head1 USAGE

Run from the command prompt and edit your paths in
the USER SELECTABLE OPTIONS area of this program.

=head2 AUTHOR

Matthew Kenworthy <matthew.kenworthy@gmail.com>, 2012 Jan 25

=cut

##################################################
# USER SELECTABLE OPTIONS

my $book_dir        = "PDL/Book/"; # relative path to the PDL Book files
my $book_chapters   = "../Book FirstSteps NDArray Creating NiceSlice Functions Broadcasting PGPLOT PLplot graphics_3d Transform Complex Pthreads PP Genesis Credits"; # an ordered list of POD files to process

my $book_pdf        = "../pdl-www/content/book/index.html"; # output name of book

my $tmp = "book_pdf.pod.tmp"; # temporary filename for POD processing

my $exec_string = "pod2html --quiet --infile=$tmp --title 'The PDL Book' --index --outfile=". $book_pdf;

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

	    $whole_line =~ s/(.*src=\")(.*\"\/>.*)/$1$book_dir$2/g; # search for quoted image filename
            # want to replace $1 with $book_dir$1
	    $whole_line =~ s/(.*href=\")(.*\">.*)/$1$book_dir$2/g; # search for hyperref
            print FOUT $whole_line;

       } elsif (/^=ff/){
	   #html doesn't need form feeds, just pdf, so just skip those lines
       } else {print FOUT $_;}

    }

    close(FIN);

    print "done\n";

}

close(FOUT);

print "$tmp = POD files have been filtered for input to pod2html\n";

print "execing $exec_string\n";

# go ahead and make the call

`$exec_string`;

# delete the temporary file

## unlink($tmp);

print "\n$0 finished.\n\n";


