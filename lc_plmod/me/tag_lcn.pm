package me::tag_lcn;
use strict;
use chobxml::toolk;
use me::tag_stnz;
use me::tag_p;
use me::tag_expt;
use me::ignore_tag;
use me::tag_include;
use me::tag_sub;

my $intag;

$intag = chobxml::toolk->new;
$intag->define_tag('include',\&me::tag_include::tag_on,\&me::tag_include::tag_off);
$intag->define_tag('sub',\&me::tag_sub::tag_on,\&me::tag_sub::tag_off);
$intag->define_tag('stnz',\&me::tag_stnz::tag_on,\&me::tag_stnz::tag_off);
$intag->define_tag('p',\&me::tag_p::tag_on,\&me::tag_p::tag_off);

# While the rest of the 'initag' concept is already defined,
# this module waits for a signal from the main script to
# define the handler for the <expt> tag.
sub set_exptext {
  if ( $_[0] > 5 )
  {
    $intag->define_tag('expt',\&me::tag_expt::tag_on,\&me::tag_expt::tag_off);
  } else {
    $intag->define_tag('expt',\&me::ignore_tag::tag_on,\&me::ignore_tag::tag_off);
  }
}

sub tag_on {
  my $lc_parr;
  #my %lc_parv;
  my @lc_park;
  my $lc_keyn;
  my $lc_keyv;
  $_[1]->{'tagdata'}->{'ochar'} = $_[0]->{'fnc'}->{'char'};
  $_[0]->{'fnc'}->{'char'} = \&tagchar;
  
  $_[0]->{'cont'} = {};
  $_[0]->{'cont'}->{'forma'} = "";
  $_[0]->{'cont'}->{'formb'} = "";
  
  $_[1]->{'tagdata'}->{'exita'} = "";
  $_[1]->{'tagdata'}->{'exitb'} = "";
  
  
  $lc_parr = $_[1]->{'param'};
  #%lc_parv = %$lc_parr;
  @lc_park = keys %$lc_parr;
  
  foreach $lc_keyn (@lc_park)
  {
    my $lc2_hou;
    $lc_keyv = $lc_parr->{$lc_keyn};
    
    if ( $lc_keyn eq "stat" )
    {
      $lc2_hou = ( 2 > 1 );
      
      if ( $lc_keyv eq "notyet" )
      {
        $_[0]->{'cont'}->{'formb'} .= '<table border = "1" cellpadding = "5"><tr><td>';
        $_[0]->{'cont'}->{'formb'} .= "<i>The text of today's lesson is not yet ready - but in it's stead, the following description of what will be there is provided.</i></td></tr>\n<tr><td>\n";
        
        
        $_[1]->{'tagdata'}->{'exitb'} = "\n</td></tr></table>\n" . $_[1]->{'tagdata'}->{'exitb'};
      }
      
    }
    
  }
  
  
  $intag->claim($_[1]);
}

sub tag_off {
  my $lc_ray;
  $_[0]->{'fnc'}->{'char'} = $_[1]->{'tagdata'}->{'ochar'};
  
  $_[0]->{'cont'}->{'forma'} .= $_[1]->{'tagdata'}->{'exita'};
  $_[0]->{'cont'}->{'formb'} .= $_[1]->{'tagdata'}->{'exitb'};
  
  $lc_ray = $_[0]->{'outparts'};
  @$lc_ray = (@$lc_ray,$_[0]->{'cont'});
}

sub tagchar {
  my $lc_tex;
  $lc_tex = &chobxml::toolk::escap($_[1]->{'text'});
  $_[0]->{'cont'}->{'forma'} .= $lc_tex;
  $_[0]->{'cont'}->{'formb'} .= $lc_tex;
}

1;
