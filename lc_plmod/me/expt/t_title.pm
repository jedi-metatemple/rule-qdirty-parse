package me::expt::t_title;
use strict;
use chobxml::toolk;


my $intag;

$intag = chobxml::toolk->new;


sub tag_on {
  $intag->claim($_[1]);
  
  $_[1]->{'tagdata'}->{'ochar'} = $_[0]->{'fnc'}->{'char'};
  $_[0]->{'fnc'}->{'char'} = \&tagchar;
}


sub tag_off {
  $_[0]->{'fnc'}->{'char'} = $_[1]->{'tagdata'}->{'ochar'};
}


sub tagchar {
  my $lc_tex;
  $lc_tex = &chobxml::toolk::escap($_[1]->{'text'});
  $_[0]->{'expt'}->{'title'} .= $lc_tex;
}


1;
