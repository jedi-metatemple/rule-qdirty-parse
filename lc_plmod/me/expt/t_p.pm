package me::expt::t_p;
use strict;
use chobxml::toolk;
use me::expt::p::t_a;


my $intag;

$intag = chobxml::toolk->new;
$intag->define_tag('a',\&me::expt::p::t_a::tag_on,\&me::expt::p::t_a::tag_off);


sub tag_on {
  $intag->claim($_[1]);
  
  $_[1]->{'tagdata'}->{'ochar'} = $_[0]->{'fnc'}->{'char'};
  $_[0]->{'fnc'}->{'char'} = \&tagchar;
  
  $_[0]->{'expt'}->{'body'} .= "\n<p>";
}


sub tag_off {
  $_[0]->{'fnc'}->{'char'} = $_[1]->{'tagdata'}->{'ochar'};
  
  $_[0]->{'expt'}->{'body'} .= "</p>\n";
}


sub tagchar {
  my $lc_tex;
  $lc_tex = &chobxml::toolk::escap($_[1]->{'text'});
  $_[0]->{'expt'}->{'body'} .= $lc_tex;
}


1;
