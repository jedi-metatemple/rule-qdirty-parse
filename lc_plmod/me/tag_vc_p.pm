package me::tag_vc_p;
use strict;



sub tag_on {
  $_[0]->{'cont'}->{'forma'} .= '*';
  $_[0]->{'cont'}->{'formb'} .= "<u><em>";
}

sub tag_off {
  $_[0]->{'cont'}->{'forma'} .= '*';
  $_[0]->{'cont'}->{'formb'} .= "</em></u>";
}


1;
