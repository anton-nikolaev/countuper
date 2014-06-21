#!/usr/bin/perl

use strict;
use LWP::UserAgent;
use Getopt::Long;
use Data::Dumper;

my ($uas_file, $min_period, $max_period, $verbose);
GetOptions
(
    "a=s" => \$uas_file, 
    "m=i" => \$min_period,
    "x=i" => \$max_period,
    "v" => \$verbose
) or die "Cant parse command line options: $!";
$min_period = 5 unless $min_period;
my $target_url = $ARGV[0];
die "Missing url to countup!" unless $target_url;

sub verb
{
    return unless $verbose;
    my $msg = shift;
    chomp $msg;
    warn scalar(localtime)." $msg\n";
};

die "Max period could not be less than min period: $max_period > $min_period"
    if $max_period and ($max_period <= $min_period);

verb("Working on url $target_url");
verb
(
    "Using ".
    (
        $max_period ?
        "random period between $min_period and $max_period" :
        "static period $min_period"
    ).
    " seconds."
);

verb
(
    "Using ".
    (
        $uas_file ?
        "User-Agent values list from file $uas_file" :
        "static User-Agent for all"
    )
);

my @uas;
unless ($uas_file)
{
    @uas = ('CountUPer Ver.0.1 ');
}
else
{
    open(my $fh, $uas_file) or die "Cant read uas_file $uas_file: $!";
    my $err_prefix = "uas_file $uas_file contains";
    while(<$fh>)
    {
        chomp; 
        die $err_prefix." an empty line!"
            if /^\s*$/;
        die $err_prefix." a line with space symbol at EOL: $_"
            if /\s$/;
        push @uas, $_;
    };
    close($fh);
    die "There is no valid User-Agent values in the file $uas_file!"
        unless @uas;
};

my $ua = LWP::UserAgent->new();
$ua->timeout(5);
$ua->env_proxy;

while('forever')
{
    my $ua_str = (@uas == 1) ? $uas[0] : $uas[int(rand(scalar @uas))]; 
    $ua->agent($ua_str);
    verb("GET $target_url $ua_str");
    my $resp = $ua->get($target_url) or die "LWP::UserAgent error: $!";
    verb($resp->status_line);
    my $sleep_time =
        $max_period ?
        $min_period + int(rand($max_period - $min_period)) :
        $min_period;
    verb("Sleeping for $sleep_time seconds...");
    sleep($sleep_time);
};
