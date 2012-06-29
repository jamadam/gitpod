#!/home/sugama/perl5/perlbrew/perls/perl-5.14.2/bin/perl
#!/usr/bin/env perl
use strict;
use warnings;

use File::Basename 'dirname';
use File::Spec;
use lib join '/', File::Spec->splitdir(File::Spec->rel2abs(dirname(__FILE__))), 'lib';
use lib join '/', File::Spec->splitdir(File::Spec->rel2abs(dirname(__FILE__))), 'extlib';
use Myapp;

my $app = Myapp->new;
$app->start;
