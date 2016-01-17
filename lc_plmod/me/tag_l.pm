package me::tag_l;
use strict;


sub tag_on {
  $_[0]->{'cont'}->{'forma'} .= "&nbsp <i>";
  $_[0]->{'cont'}->{'formb'} .= $_[0]->{'btwix'} . "&nbsp <i>";
  $_[0]->{'btwix'} = "<br/>";
}

sub tag_off {
  $_[0]->{'cont'}->{'forma'} .= "</i><br/>";
  $_[0]->{'cont'}->{'formb'} .= "</i>\n";
}


1;