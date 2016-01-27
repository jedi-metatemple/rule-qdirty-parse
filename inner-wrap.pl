use strict;
use argola;
use wraprg;
use chobdate;
use chobxml::toolk;
use chobxml::toolk::extra;
use me::titletag;
use me::tag_lcn;
use me::tag_sub;
use me::fin;
use me::tag_notice;
use me::tag_include;



my $homeone;
my $homeyes = 0;
my $contena;
my $atsecs;
my $atdate;
my $filan;
my $maxfuture = 10;
#my $maxfuture = 5;
#my $maxfuture = 600;
my $parceon;
my $showdate = 10;
my $exptext = 5; # Do we show expanded text?

my $rvstagval;

my $file_err_on = 0;
my $file_err_fl;


END {
  my $lc_msg;
  if ( $file_err_on > 5 )
  {
    $lc_msg = "\n";
    $lc_msg .= "File responsible for fatal error:\n";
    $lc_msg .= '    ' . $file_err_fl;
    $lc_msg .= ":\n";
    $lc_msg .= "\n";
    print STDERR $lc_msg;
  }
}
sub filerr_on {
  $file_err_on = 10;
  $file_err_fl = $_[0];
}
sub filerr_off {
  $file_err_on = 0;
}





sub opto__indx_do {
  $homeone = &argola::getrg();
  $homeyes = 10;
} &argola::setopt("-indx",\&opto__indx_do);

sub opto__gnr_do {
  $showdate = 0;
} &argola::setopt("-gnr",\&opto__gnr_do);

sub opto__far_do {
  $maxfuture = &argola::getrg();
} &argola::setopt("-far",\&opto__far_do);

sub opto__expt_do {
  $exptext = 10;
} &argola::setopt("-expt",\&opto__expt_do);

sub opto__expt_no {
  $exptext = 0;
} &argola::setopt("+expt",\&opto__expt_no);


&argola::runopts();

&me::fin::set_show($showdate);

# Finally resolve whether or not expanded text
# is shown. By default, it is shown on generic
# date-unrelated editions -- but this, obviously,
# can be over-ridden with the appropriate
# command-line options.
if ( ( $exptext > 3 ) && ( $exptext < 7 ) )
{
  $exptext = 10;
  if ( $showdate > 5 ) { $exptext = 0; }
}
&me::tag_lcn::set_exptext($exptext);


if ( $homeyes < 5 )
{
  die "\nFailed to use -indx option to specify index file.\n\n";
}
&filerr_on($homeone);

# Here we start retrieving the Head ID:
{
  my $lc_cm;
  my $lc_ret;
  $lc_cm = 'cd "$(dirname ' . &wraprg::bsc($homeone) . ')"';
  $lc_cm .= " && git rev-parse HEAD";
  $lc_cm = '( ' . $lc_cm . ' )';
  $lc_ret = `$lc_cm`; chomp($lc_ret);
  
  $rvstagval = $lc_ret;
}
sub git_v_tag {
  return $rvstagval;
}




$parceon = chobxml::toolk->new;
$parceon->define_tag('sect',\&open_sect_t,\&close_sect_t);
$parceon->define_tag('include',\&me::tag_include::tag_on,\&me::tag_include::tag_off);
$parceon->define_tag('title',\&me::titletag::open_title_t,\&me::titletag::close_title_t);
$parceon->define_tag('lcn',\&me::tag_lcn::tag_on,\&me::tag_lcn::tag_off);
$parceon->define_tag('sub',\&me::tag_sub::tag_on,\&me::tag_sub::tag_off);
$parceon->define_tag('notice',\&me::tag_notice::tag_on,\&me::tag_notice::tag_off);
$parceon->define_init(\&parc_init);
$parceon->define_flush(\&me::fin::mainfnc);

$atsecs = &chobdate::nowo();
$atdate = &chobdate::atto($atsecs);

# We now make sure that the future is not too far.
{
  my $lc_a;
  $lc_a = 0;
  if ( -f &filset() )
  {
    $lc_a = 1;
    while ( -f &nfilset() )
    {
      $lc_a = int($lc_a + 1.2);
    }
  }
  if ( $lc_a > ( $maxfuture - 0.2 ) )
  {
    print "\nWe are ahead by a good " . $lc_a . " days.\n\n";
    exit(0);
  }
}
#system("touch",$filan);


# Get content from the file:
{
  my $lc_cm;
  $lc_cm = "cat";
  &argola::wraprg_lst($lc_cm,$homeone);
  $contena = `$lc_cm`;
}


# Launch the parser:
{
  my $lc_pinput;
  
  $lc_pinput = {};
  $lc_pinput->{'filoc'} = $homeone;
  $lc_pinput->{'css'} = `cat mainit.css`;
  
  $parceon->parse($lc_pinput,$contena);
}





# ###################################

sub open_sect_t
{
  $_[1]->{'tagdata'}->{'title'} = $_[0]->{'title'};
}


sub close_sect_t
{
  my $lc_ray;
  my $lc_rsz;
  my $lc_sectitle;
  my $lc_cnt;
  
  $lc_ray = $_[0]->{'outparts'};
  $lc_rsz = @$lc_ray;
  
  #system("echo",$lc_sectitle . ": Done in " . $lc_rsz . " parts.");
  $_[0]->{'lcn_tot'} = $lc_rsz;
  $lc_cnt = 0;
  while ( $lc_rsz > 0.5 )
  {
    $lc_cnt = int($lc_cnt + 1.2);
    $_[0]->{'lcn_cnt'} = $lc_cnt;
    my $lc2_each;
    $_[0]->{'cur_part'} = shift(@$lc_ray);
    $lc_rsz = @$lc_ray;
    &saveit(@_);
  }
  
  $lc_sectitle = $_[0]->{'title'};
  $_[0]->{'title'} = $_[1]->{'tagdata'}->{'title'};
}


# ###################################

sub saveit {
  my $lc_cm;
  my $lc_title;
  my $lc_rawtitle;
  my $lc_filb;
  my $lc_fullray;
  
  $lc_rawtitle = $_[0]->{'title'};
  $lc_title = &chobxml::toolk::escap($lc_rawtitle);
  
  $lc_cm = "| cat >";
  &argola::wraprg_lst($lc_cm,&filnow());
  open TAK, $lc_cm;
  
  print TAK "<html><head>\n";
  print TAK "<title>" . $lc_title . "</title>\n";
  print TAK '<style type="text/css">' . "\n";
  print TAK $_[0]->{'css'};
  print TAK '</style>' . "\n";
  print TAK "</head><body>\n";
  print TAK "<h2>Lesson for " . $atdate . ":</h2>\n";
  print TAK "<h1>" . $lc_title . "</h1>\n";
  print TAK "<h3>Part " . $_[0]->{'lcn_cnt'} . " of " . $_[0]->{'lcn_tot'} . "</h3>\n";
  print TAK $_[0]->{'cur_part'}->{'formb'};
  print TAK "</body></html>\n";
  
  close TAK;
  #system("cat",$filan);
  #system("echo");
  
  
  
  $_[0]->{'cur_part'}->{'when'} = &main::lastnow();
  $_[0]->{'cur_part'}->{'chtitle'} = $lc_rawtitle;
  $_[0]->{'cur_part'}->{'lcn_cnt'} = $_[0]->{'lcn_cnt'};
  $_[0]->{'cur_part'}->{'lcn_tot'} = $_[0]->{'lcn_tot'};
  $lc_fullray = $_[0]->{'fullset'};
  @$lc_fullray = (@$lc_fullray,$_[0]->{'cur_part'});
}


sub nfilset {
  &chobdate::nexta($atsecs);
  $atdate = &chobdate::atto($atsecs);
  return &filset();
}

sub filset {
  $filan = "day-" . $atdate . "-reg.html";
  return $filan;
}

sub lastnow {
  return $atsecs;
}

sub filnow {
  if ( -f &filset() )
  {
    while ( -f &nfilset() ) { }
  }
  return $filan;
}

sub parc_init {
  my $lc_inf;
  
  if ( ref($_[1]) ne "HASH" )
  {
    die "\nThis init function requires a hash.\n\n";
  }
  
  $lc_inf = {};
  $lc_inf->{'fnc'} = {};
  $lc_inf->{'fnc'}->{'char'} = $_[0]->{'char'}->{'dflt'};
  
  $lc_inf->{'filoc'} = $_[1]->{'filoc'};
  $lc_inf->{'css'} = $_[1]->{'css'};
  
  $lc_inf->{'title'} = "";
  $lc_inf->{'outparts'} = [];
  
  $lc_inf->{'fullset'} = [];
  
  return $lc_inf;
}


