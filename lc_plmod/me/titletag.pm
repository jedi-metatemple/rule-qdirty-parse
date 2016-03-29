package me::titletag;
use strict;

my $titl_var = "Untitled";
my $titl_yet = 0;

sub open_title_t {
  $_[1]->{'tagdata'}->{'ochar'} = $_[0]->{'fnc'}->{'char'};
  $_[0]->{'fnc'}->{'char'} = \&char_title;
  $_[0]->{'title'} = "";
}

sub close_title_t {
  $_[0]->{'fnc'}->{'char'} = $_[1]->{'tagdata'}->{'ochar'};
  if ( $titl_yet < 5 )
  {
    $titl_var = $_[0]->{'title'};
    $titl_yet = 10;
  }
  print "\nTITLE: " . $_[0]->{'title'} . " :\n";
}

sub char_title {
  $_[0]->{'title'} .= $_[1]->{'text'};
}

sub ret_ttl {
  return $titl_var;
}



1;
