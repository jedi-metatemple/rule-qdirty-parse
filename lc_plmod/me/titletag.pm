package me::titletag;
use strict;


sub open_title_t {
  $_[1]->{'tagdata'}->{'ochar'} = $_[0]->{'fnc'}->{'char'};
  $_[0]->{'fnc'}->{'char'} = \&char_title;
  $_[0]->{'title'} = "";
}

sub close_title_t {
  $_[0]->{'fnc'}->{'char'} = $_[1]->{'tagdata'}->{'ochar'};
  print "\nTITLE: " . $_[0]->{'title'} . " :\n";
}

sub char_title {
  $_[0]->{'title'} .= $_[1]->{'text'};
}



1;
