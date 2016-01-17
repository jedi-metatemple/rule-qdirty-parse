package me::tag_dcn_p;
use strict;



sub tag_on {
  $_[0]->{'cont'}->{'forma'} .= "<b>";
  $_[0]->{'cont'}->{'formb'} .= "<b>";
}

sub tag_off {
  $_[0]->{'cont'}->{'forma'} .= "</b>";
  $_[0]->{'cont'}->{'formb'} .= "</b>";
}


1;
