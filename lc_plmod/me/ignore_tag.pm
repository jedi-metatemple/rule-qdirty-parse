package me::ignore_tag;
use strict;
use chobxml::toolk;


my $intag;

$intag = chobxml::toolk->new;
$intag->default_hnd(\&nulldo,\&nulldo);


sub tag_on {
  $intag->claim($_[1]);
}

sub tag_off {
}


sub nulldo { }

1;
