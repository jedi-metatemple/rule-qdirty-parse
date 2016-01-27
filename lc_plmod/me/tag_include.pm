package me::tag_include;
use strict;
use File::Basename;



sub tag_on {
  my $lc_o_filoc;
  my $lc_i_filoc;
  my $lc_cm;
  my $lc_cont;
  
  $lc_o_filoc = $_[0]->{'filoc'};
  $_[1]->{'tagdata'}->{'filoc'} = $lc_o_filoc;
  
  $lc_i_filoc = dirname($lc_o_filoc);
  $lc_i_filoc .= "/" . $_[1]->{'param'}->{'ref'};
  
  $_[0]->{'filoc'} = $lc_i_filoc;
  
  $lc_cm = "cat";
  &argola::wraprg_lst($lc_cm,$lc_i_filoc);
  $lc_cont = `$lc_cm`;
  
  
  &main::filerr_on($_[0]->{'filoc'});
  &chobxml::toolk::extra::subparse($_[1],$lc_cont);
  $_[0]->{'filoc'} = $_[1]->{'tagdata'}->{'filoc'};
  &main::filerr_on($_[0]->{'filoc'});
}

sub tag_off {
}



1;
