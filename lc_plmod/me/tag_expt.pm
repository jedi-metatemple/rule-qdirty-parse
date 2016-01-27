package me::tag_expt;
use strict;
use chobxml::toolk;
use me::expt::t_title;
use me::expt::t_p;
use me::tag_include;
use me::tag_sub;


my $intag;

$intag = chobxml::toolk->new;
$intag->define_tag('include',\&me::tag_include::tag_on,\&me::tag_include::tag_off);
$intag->define_tag('sub',\&me::tag_sub::tag_on,\&me::tag_sub::tag_off);
$intag->define_tag('title',\&me::expt::t_title::tag_on,\&me::expt::t_title::tag_off);
$intag->define_tag('p',\&me::expt::t_p::tag_on,\&me::expt::t_p::tag_off);


sub tag_on {
  $intag->claim($_[1]);
  
  $_[0]->{'expt'} = {};
  $_[0]->{'expt'}->{'title'} = "";
  $_[0]->{'expt'}->{'body'} = "";
}

sub tag_off {
  my $lc_abt;
  
  $lc_abt = "\n\n";
  $lc_abt .= '<p><table border = "1" cellpadding = "5"><tr><td class = "expt_h">';
  $lc_abt .= $_[0]->{'expt'}->{'title'};
  $lc_abt .= '</td></tr><tr><td class = "expt_b">';
  $lc_abt .= $_[0]->{'expt'}->{'body'};
  $lc_abt .= "</td></tr></table></p>\n\n";
  
  $_[0]->{'cont'}->{'forma'} .= $lc_abt;
  $_[0]->{'cont'}->{'formb'} .= $lc_abt;
}




1;
