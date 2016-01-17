package me::tag_stnz;
use strict;
use chobxml::toolk;
use me::tag_l;

my $intag;

$intag = chobxml::toolk->new;
$intag->define_tag('l',\&me::tag_l::tag_on,\&me::tag_l::tag_off);


sub tag_on {
  $_[0]->{'cont'}->{'forma'} .= "<br/>\n";
  $_[0]->{'cont'}->{'formb'} .= "\n<p>";
  $_[0]->{'btwix'} = "";
  
  $intag->claim($_[1]);
}

sub tag_off {
  $_[0]->{'cont'}->{'forma'} .= "<br/>";
  $_[0]->{'cont'}->{'formb'} .= "</p>\n";
}


1;
