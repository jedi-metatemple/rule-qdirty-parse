package me::expt::p::t_a;
use strict;
use chobxml::toolk;




sub tag_on {
  $_[0]->{'expt'}->{'body'} .= '<a href = "';
  $_[0]->{'expt'}->{'body'} .= &chobxml::toolk::escap($_[1]->{'param'}->{'href'});
  $_[0]->{'expt'}->{'body'} .= '" target = "_blank">';
}


sub tag_off {
  $_[0]->{'expt'}->{'body'} .= "</a>";
}




1;
