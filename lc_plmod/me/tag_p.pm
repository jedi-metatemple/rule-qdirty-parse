package me::tag_p;
use strict;
use chobxml::toolk;
use me::tag_i_p;
use me::tag_vc_p;
use me::tag_dcn_p;
use me::tag_cite_p;

my $intag;

$intag = chobxml::toolk->new;
$intag->define_tag('i',\&me::tag_i_p::tag_on,\&me::tag_i_p::tag_off);
$intag->define_tag('vc',\&me::tag_vc_p::tag_on,\&me::tag_vc_p::tag_off);
$intag->define_tag('dcn',\&me::tag_dcn_p::tag_on,\&me::tag_dcn_p::tag_off);
$intag->define_tag('cite',\&me::tag_cite_p::tag_on,\&me::tag_cite_p::tag_off);


sub tag_on {
  $_[0]->{'cont'}->{'forma'} .= "<br/>\n";
  $_[0]->{'cont'}->{'formb'} .= "\n<p>";
  
  $intag->claim($_[1]);
}

sub tag_off {
  $_[0]->{'cont'}->{'forma'} .= "<br/>";
  $_[0]->{'cont'}->{'formb'} .= "</p>\n";
}


1;
