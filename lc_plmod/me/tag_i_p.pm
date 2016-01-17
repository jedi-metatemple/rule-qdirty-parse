package me::tag_i_p;
use strict;



sub tag_on {
  $_[0]->{'cont'}->{'forma'} .= '*';
  $_[0]->{'cont'}->{'formb'} .= "<em>";
}

sub tag_off {
  $_[0]->{'cont'}->{'forma'} .= '*';
  $_[0]->{'cont'}->{'formb'} .= "</em>";
}


1;
