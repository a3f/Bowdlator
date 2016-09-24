#!/usr/bin/perl
use strict;
use warnings;
use UI::Bowdlator::InputFilter;

print "$0 starting..\n";
my $filt = UI::Bowdlator::InputFilter->new();
die "Bowdlator server not online\n" unless $filt;

my $composed = '';
while ($filt->getKey) {
    print "got " . (length $_). "b: chr=$_ ord=" . (ord $_), "\n";
    $_ = substr $_, 0, 1;

    if (/^[\b]/) {
        chop $composed;
        $_ = chop $composed;
    }

    if (/^[^\41-\176]/) {
        print "commit\n";
        $filt->commit($composed);
        next;
    }

    $composed .= uc;
    print "suggest $composed\n";
    $filt->suggest($composed);
}
