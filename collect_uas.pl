#!/usr/bin/perl

use strict;
use Data::Dumper;

my %vars;

while (<>)
{
    chomp;
    next unless /"$/;
    $_ =~ s/"(.*?)"/$1/g;
    $vars{$1} = 1;
}

foreach (keys %vars)
{
    print STDOUT $_."\n";
}
