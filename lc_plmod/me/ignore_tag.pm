package me::ignore_tag;
use strict;
use chobxml::toolk;


my $intag;

$intag = chobxml::toolk->new;
$intag->default_hnd(\&nulldo,\&nulldo);


sub tag_on {
  $intag->claim($_[1]);
  
  $_[1]->{'tagdata'}->{'ochar'} = $_[0]->{'fnc'}->{'char'};
  $_[0]->{'fnc'}->{'char'} = \&nulldo;
}

sub tag_off {
  $_[0]->{'fnc'}->{'char'} = $_[1]->{'tagdata'}->{'ochar'};
}


sub nulldo { }

1;
