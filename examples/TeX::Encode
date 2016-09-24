#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use UI::Bowdlator::InputFilter;
use UI::Notify::Cocoa;
use IO::Socket::UNIX;
use Encode;
use TeX::Encode;
use charnames ':full';

print ">== START!!\n";
my $filt = UI::Bowdlator::InputFilter->new();
die "Bowdlator server not online\n" unless $filt;
UI::Notify::Cocoa->show("Starting");
my $texing = 0;
my $composed = '';
while ($filt->getKey) {
    $_ = substr $_, 0, 1;
    print "[TEX $texing]got " . (length $_). "b: chr=$_ ord=" . (ord $_), "\n";
    if (/^[\b]/) {
        chop $composed;
        $_ = chop $composed;
    }

    if ($texing) {
        if (/\\|[^\41-\176]/) {
            $filt->commit(), next if $composed =~ /^\\$/;
            $composed = decode 'latex', $composed;

            $filt->commit($composed);
            $texing = 0;
        } else {
            $composed .= $_;
        }
    } else {
        if (/\\/) {
            $composed .= $_;
            $texing = 1;
        } else {
            $filt->commit($composed);
        }
    }


    $filt->suggest($composed);
}
UI::Notify::Cocoa->show("Exiting");
print "== END\n"
