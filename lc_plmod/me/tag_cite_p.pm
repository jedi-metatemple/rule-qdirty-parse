package me::tag_cite_p;
use strict;



sub tag_on {
  $_[0]->{'cont'}->{'forma'} .= '&lt;&lt;';
  $_[0]->{'cont'}->{'formb'} .= '<span class = "cite">(';
}

sub tag_off {
  $_[0]->{'cont'}->{'forma'} .= '&gt;&gt;';
  $_[0]->{'cont'}->{'formb'} .= ')</span>';
}


1;
