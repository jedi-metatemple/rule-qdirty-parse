package me::fin;
use strict;
use chobxml::toolk::extra;
use chobdate;
use wraprg;

my $showdate = 10;

sub set_show {
  $showdate = $_[0];
}

my @allmont = ('x'
  ,'January','February','March'
  ,'April','May','June'
  ,'July','August','September'
  ,'October','November','December'
);
my @allweek = (
  'Sunday','Monday','Tuesday',
  'Wednesday','Thursday','Friday',
'Saturday');


sub mainfnc {
  my $lc_counter;
  my $lc_each;
  my $lc_targdata;
  my $lc_ray;
  my $lc_now;
  my $lc_datecode;
  my @lc_dateseg;
  my $lc_destfile;
  my $lc_chapcount;
  
  my $lc_outform;
  
  system("echo","SHOW THAT WE GOT HERE");
  
  $lc_targdata = $_[0]->{'chobak_inf'}->{'data'};
  #&chobxml::toolk::extra::dumping("What we have at the end", $lc_targdata);
  
  $lc_ray = $lc_targdata->{'fullset'};
  
  $lc_counter = 0;
  foreach $lc_each (@$lc_ray)
  {
    $lc_counter = int($lc_counter + 1.2);
    $lc_each->{'grand_cnt'} = $lc_counter;
    
    system("echo","Lesson Total: " . $lc_counter);
  }
  $lc_targdata->{'grand_tot'} = $lc_counter;
  foreach $lc_each (@$lc_ray)
  {
    $lc_each->{'grand_tot'} = $lc_counter;
  }
  
  $lc_now = $lc_ray->[0]->{'when'};
  
  $lc_datecode = &chobdate::atto($lc_now);
  @lc_dateseg = split(quotemeta('-'),$lc_datecode);
  $lc_destfile = "cycle-" . $lc_datecode . "-mn.html";
  {
    my $lc2_cm;
    $lc2_cm = "| cat >";
    &argola::wraprg_lst($lc2_cm,$lc_destfile);
    open TAK, $lc2_cm;
  }
  print TAK "<html><head>\n";
  &tbl_on();
  print TAK "<title>Introductory Rule for Jedi</title>\n";
  print TAK '<style type="text/css">' . "\n";
  print TAK $lc_targdata->{'css'};
  print TAK "</style>\n";
  
  print TAK '</head><body><h1>Introductory Rule for Jedi</h1>' . "\n";
  print TAK "\n&nbsp &nbsp; &nbsp; ";
  print TAK 'Visit the Home-Page of the Rule:<br/>';
  print TAK "\n&nbsp &nbsp; &nbsp; ";
  print TAK '<a href = "http://metatemple.org/jedi-rule">';
  print TAK 'http://metatemple.org/jedi-rule</a>' . "\n";
  print TAK '<a name = "toc"><h3>Contents</h3>' . "\n";
  $lc_chapcount = 0;
  
  foreach $lc_each (@$lc_ray)
  {
    if ( $lc_each->{'lcn_cnt'} < 1.5 )
    {
      $lc_chapcount = int($lc_chapcount + 1.2);
      $lc_each->{'chapter_no'} = $lc_chapcount;
      print TAK "<br/>\n<b>";
      &outy('Chapter #', $lc_each->{'chapter_no'}, ": ");
      print TAK '<a href = "#ch' . $lc_each->{'chapter_no'} . 'p">';
      &outy($lc_each->{'chtitle'});
      print TAK '</a>';
      print TAK "</b><br/>\n";
    }
  }
  &tbl_off();
  
  &tbl_on();
  foreach $lc_each (@$lc_ray)
  {
    if ( $lc_each->{'lcn_cnt'} < 1.5 )
    {
      print TAK "<hr/>\n";
      print TAK "<br/>\n";
      print TAK '<a name = "ch' . $lc_each->{'chapter_no'} . 'p" />';
      print TAK "<b>";
      &outy('Chapter #', $lc_each->{'chapter_no'}, ": ");
      &outy($lc_each->{'chtitle'});
      print TAK "</b>";
      print TAK '<div class = "mnlink"> - [<a href = "#toc">main table of contents</a>]</div>' . "\n";
      print TAK "<br/>\n";
    }
    
    print TAK '<a href = "#lc' . $lc_each->{'grand_cnt'} . 'n">';
    if ( $showdate > 5 ) { &outdate($lc_each->{'when'}); }
    if ( $showdate < 5 ) { &outy('Day ', $lc_each->{'grand_cnt'}); }
    print TAK '</a>';
    #&outy(' (' . $lc_each->{'grand_cnt'}, ')');
    print TAK '<br/>' . "\n";
    
  }
  &tbl_off();
  
  print TAK "<hr/>\n";
  
  foreach $lc_each (@$lc_ray)
  {
    if ( $lc_each->{'lcn_cnt'} < 1.5 )
    {
      &tbl_on();
      print TAK "<hr/><h2>";
      &outy($lc_each->{'chtitle'});
      print TAK "</h2>\n";
      &tbl_off();
    }
    
    &tbl_on();
    print TAK '<a name = "lc' . $lc_each->{'grand_cnt'} . 'n" /><h3>';
    if ( $showdate > 5 ) { &outdate($lc_each->{'when'}); }
    if ( $showdate < 5 ) { &outy('Day ', $lc_each->{'grand_cnt'}); }
    print TAK "</h3>\n";
    
    print TAK $lc_each->{'formb'};
    
    print TAK '<div class = "mnlink">[<a href = "#toc">contents</a>]</div>' . "\n";
    &tbl_off();
    
  }
  
  
  print TAK "<hr/>\n";
  
  
  print TAK "</body>\n</html>\n";
  close TAK;
  
  &main::filerr_off();
  
  
  $lc_outform = '"cycle","';
  $lc_outform .= $lc_datecode;
  $lc_outform .= '","' . &main::git_v_tag() . '"';
  {
    my $lc2_frm;
    my $lc2_cm;
    
    $lc2_cm = "echo";
    &wraprg::lst($lc2_cm,$lc_outform);
    $lc2_cm .= " >> cycles.vcsv";
    system($lc2_cm);
    
    $lc2_frm = '"type","date","gitcommit"';
    
    $lc2_cm = "echo";
    &wraprg::lst($lc2_cm,$lc2_frm);
    $lc2_cm .= " > cycles.csv";
    system($lc2_cm);
    system("cat cycles.vcsv >> cycles.csv");
  }
  
  #system("cat",$lc_destfile);
}
# Elements to each entry:
#   chtitle
#   forma
#   formb
#   grand_cnt
#   grand_tot
#   lcn_tot
#   lcn_cnt
#   when

sub tbl_on {
  print TAK '<table border = 0 width = "70%"><tr><td>';
  print TAK '<table border = 0 width = "90%" align = "right"><tr><td>';
}

sub tbl_off {
  print TAK "</td></tr></table>\n";
  print TAK "</td></tr></table>\n";
}

sub outdate {
  my $lc_atty;
  my $lc_weekd;
  my @lc_segs;
  
  $lc_atty = &chobdate::atto($_[0]);
  $lc_weekd = &chobdate::at_weekd($_[0]);
  @lc_segs = split(quotemeta('-'),$lc_atty);
  
  &outy($allweek[$lc_weekd], ", ");
  &outy($allmont[$lc_segs[1]], ' ', int($lc_segs[2] + 0.2), ', ');
  &outy($lc_segs[0]);
}


sub outy {
  my $lc_a;
  foreach $lc_a (@_)
  {
    print TAK &chobxml::toolk::escap($lc_a);
  }
}


1;
