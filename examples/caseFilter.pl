#!/usr/bin/perl
use strict;
use warnings;
use UI::Bowdlator::Filter;

# connect to Bowdlator server
my $bowdlator = UI::Bowdlator::Filter->new()
    or die "Bowdlator server not online\n";

my $composed = '';
while ($bowdlator->getKey(handle_backspace => \$composed)) {

    if (/^[^[:graph:]]/a) { # non graphical character ends composition
        $bowdlator->commit(\$composed);
        next;
    }

    $composed .= uc;

    $bowdlator->suggest($composed);
}
