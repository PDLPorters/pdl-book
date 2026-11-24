requires 'perl' => '5.006';

requires 'App::pod2pdf';
requires 'File::Type';
requires 'Getopt::Long';
requires 'Image::Size';
requires 'PDF::API2';
requires 'Pod::Checker';
requires 'Pod::Parser';
requires 'Pod::Usage';

on 'develop' => sub {
  requires 'perl' => '5.020';

  requires 'File::Find'; # for the pre-commit hook
};
