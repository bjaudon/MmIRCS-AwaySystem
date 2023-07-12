;AwaySystem v2.0 by mudpuddle (November 9, 1999)
;Email bug reports and suggestions to: MmIRCS@bryansdomain.virtualave.net

on *:LOAD:{ 
  if ($version < 5.61) { echo $colour(info) -se *** Error! AwaySystem will not work on mIRC $version $+ . Please upgrade to mIRC 5.61 or later and try to reload the script again. | unload -rs $nopath($script) }
  asresetdefault
  echo $colour(info) -se *** AwaySystem v2.0 by mudpuddle Loaded!
  awaysys.config 
}
on *:START:{ 
  if ($version < 5.61) { echo $colour(info) -se *** Error! AwaySystem will not work on mIRC $version $+ . Please upgrade to mIRC 5.61 or later and try to reload the script again. | unload -rs $nopath($script) }
  else {
    if ($exists(awaysys.ini) == $false) { asresetdefault | echo $colour(info) -se *** AwaySystem Configuration file is missing! Resetting to default options... }
    if ($asrini(awaymode) != Back) { setback }
  }
}
on *:CONNECT:{ if ($asrini(awaymode) == Away) { echo $colour(info) -se *** Online Away detected. Setting back to Away Mode | away %awaymsg | .timerAwayTemp 1 5 setaway.disp }
  if ($asrini(idleaway)) { beginasidlechck | echo $colour(info) -se *** AwaySystem Idle checker started. } 
}
on *:DISCONNECT:{ if ($asrini(awaymode) == IdleAway) { .timer -m 1 50 setback | .timerIdleAway off } }
alias -l asrini { return $readini -n awaysys.ini AwaySystem $1- }
alias -l aswini { writeini -n awaysys.ini AwaySystem $1- }
alias -l asrmini { remini awaysys.ini AwaySystem $1- }
alias -l ascalc.mult { return $calc($1 * 60) }
alias -l ascalc.dev { return $calc($1 / 60) }
alias -l beginasidlechck { if ($server) { resetidle | .timerIdleAway 0 10 ascheckidle } }
alias -l ascheckidle {  if ($asrini(awaymode) == Back) { if ($idle > $asrini(idleaway)) { .set %awaymsg IdleAway after $ascalc.dev($asrini(idleaway)) minute(s) | aswini awaymode IdleAway | setaway } } }
alias -l setaway.disp { if ($chan(0) > 0) { ame is away (12Reason:4 %awaymsg $+ ) since %awayclock $+ . AwayPager is $group(#awaypager).status $+ , AwayLog is $group(#awaylogging).status } }
alias -l setback.disp { if ($chan(0) > 0) { ame is back (12Back from:4 %awaymsg $+ ) Gone for $duration($calc(%awayback - %awaytime)) } }
alias -l setaway { 
  if ($timer(IdleAway)) { .timerIdleAway off }
  if ($asrini(awaysystem.log) == 1) { write $asrini(awaysystemlog.log)  $+ $colour(action) $+ *** Set to Away Mode @ $time(HH:nn:ss) $date(mm/dd/yyyy) (4 $+ %awaymsg $+  $+ $colour(action) $+ ) }
  if ($asrini(awaynick)) { .set %oldnick $me | .set %awaytime $ctime | away %awaymsg | nick $asrini(awaynick) | .set %awayclock $time(h:nn:ss tt) | setaway.disp }
  else { .set %awaytime $ctime | away %awaymsg | .set %awayclock $time(h:nn:ss tt) | setaway.disp }
  tbar
  if ($asrini(awaytimer)) { .timerAway 0 $asrini(awaytimer) setaway.disp }
}
alias setback { 
  if ($asrini(awaymode) == Back) { echo $colour(info) -a *** You are already in Back mode! }
  else {
    if ($server == $null) || ($asrini(awaymode) == $null) { echo $colour(info) -ae *** Setting to Back Mode }   
    if (%oldnick) && ($server) { nick %oldnick }
    if ($server) { .timerAway off | .set %awayback $ctime | away | setback.disp }
    aswini awaymode Back
    .unset %awaymsg %awaytime %awayback %awaytime %awayclock
    awaystatus.compare
    if ($asrini(awaysystem.log) == 1) { write $asrini(awaysystemlog.log)  $+ $colour(action) $+ *** Set to Back Mode @ $time(HH:nn:ss) $date(mm/dd/yyyy) }
    tbar
    if ($asrini(asnickpword) == $null) { unset %oldnick }
    if ($asrini(idleaway)) { beginasidlechck }
  }
}
alias -l tbar { 
  if ($asrini(awaytbar)) {
    if ($asrini(awaymode) != Back) { titlebar - $asrini(awaymode) Mode since %awayclock }
    else { titlebar }
  }
}
alias asresetdefault { 
  asrmini | aswini awaymode Back | .enable #awaypager #awaylogging #awaynotices | .disable #asinputback #asnickpword | aswini awaysystem.log 0 | aswini awaysystemlog.log $shortfn($logdir) $+ awaysys.log | aswini closemsg 1 | aswini notify 1 | aswini asquietid 0 | aswini awaytimer 2700 | aswini awaytbar 1 | aswini ctcppage 1 | aswini oldidletimer 900 
}
alias -l clearawaysystemlog { 
  if ($$?!="Are you sure you wish to clear AwaySystem Logs?") { 
    if ($exists($asrini(awaysystemlog.log))) { .remove $asrini(awaysystemlog.log) }
    clear @AwaySystemLogs 
    echo $colour(info) -ae *** AwaySystem Logs Cleared.
  }
}
alias -l awaysystemlog {
  clear @AwaySystemLogs
  window -ad @AwaySystemLogs 90 90
  if ($exists($asrini(awaysystemlog.log))) { loadbuf -p @AwaySystemLogs $asrini(awaysystemlog.log) }
  else { 
    clear @AwaySystemLogs
    aline -p @AwaySystemLogs  $+ $colour(info) $+ *** AwaySystem Logs are empty
  }
}
alias -l logfolder {
  did -ra awaysysconf 39 $$sdir="Select Folder to store AwaySystem Logs in" $nofile($asrini(awaysystemlog.log))
}
alias -l pagersndselect { did -ra awaysysconf 21 $$dir="Select AwayPager Sound" *.wav }
alias -l logsndselect { did -ra awaysysconf 26 $$dir="Select AwayLog Sound" *.wav }
alias -l asuninstall { if ($$?!="Are you sure you want to unload the AwaySystem script?") { 
    if ($exists(awaysys.ini)) { .remove awaysys.ini }
    if ($timer(IdleAway)) { .timerIdleAway off }
  .unset %oldnick %away* | dialog -x awaysysconf | echo $colour(info) -se *** AwaySystem v2.0 by mudpuddle unloaded. | .unload -rs $nopath($script) }
}
alias -l awaysystemhelp {
  clear @AwaySystemHelp
  window -adlk0 +tnse @AwaySystemHelp 240 30 555 400 MS Sans Serif,413
  loadbuf -p @AwaySystemHelp $shortfn($scriptdirashelp.msg)
}
alias awaysys.config {
  if ($dialog(awaysysconf)) { dialog -v awaysysconf }
  else { $dialog(awaysysconf,awaysysconf,-2) }
}
alias goaway { 
  if ($server == $null) { echo $colour(info) -ae *** You are not connected to an IRC Server }
  elseif ($asrini(awaymode) == Away) { echo $colour(info) -a *** You're already away! }
  else { $dialog(awayd,awayd) } 
}
alias -l awaystatus.compare {
  if ($asrini(oldnick2) == $null) { asrmini awaynick }
  if ($asrini(oldnick2)) { aswini awaynick $asrini(oldnick2) | asrmini oldnick2 }
  if (%awaypager.status == on) { .enable #awaypager }
  if (%awaylogging.status == on) { .enable #awaylogging }
  if (%awaynotices.status == on) { .enable #awaynotices }
  if (%awaypager.status == off) { .disable #awaypager }
  if (%awaypager.status == off) { .disable #awaylogging }
  if (%awaynotices.status == off) { .disable #awaynotices }
  .unset %awaypager.status %awaylogging.status %awaynotices.status
}
#awaypager on
ctcp *:PAGE:{ 
  if ($asrini(awaymode) == Away) || ($asrini(ctcppage)) {
    if ($nick != $me) { 
      .ctcpreply $nick PAGE Your page has been logged!
      if ($asrini(awaypager.snd)) { .splay $asrini(awaypager.snd) }
      if ($window(@AwayPager) == $null) { window -ng2 @AwayPager }
      aline -hp @AwayPager $time(HH:nn:ss) $date(mm/dd/yyyy)  $+ $colour(CTCP) $+ Page:12 $nick $+ :  $2-
      if ($asrini(awaysystem.log)) { write $asrini(awaysystemlog.log) $time(HH:nn:ss) $date(mm/dd/yyyy) 4Page:12 $nick $+ :  $2- }
    }
  }
}
#awaypager end
#awaylogging on
on *:TEXT:*:?:{
  if ($asrini(awaymode) == Away) && ($nick != $me) { 
    if ($window(@AwayLog) == $null) { window -ng1 @AwayLog }
    if ($asrini(awaylog.snd)) { .splay $asrini(awaylog.snd) }
    if ($asrini(awaysystem.log)) { write $asrini(awaysystemlog.log)  $time(HH:nn:ss) $date(mm/dd/yyyy) Message: <4 $+ $nick $+ > $1- }
    aline -hp @AwayLog $time(HH:nn:ss) $date(mm/dd/yyyy) Message: <4 $+ $nick $+ > $1-
    if ($asrini(closemsg)) { close -m $nick }
    if ($asrini(notify)) { .msg $nick I'm currently away, your message has been logged. 
      if ($group(#awaypager).status == on) { .msg $nick If your message is urgent, please type 4/ctcp $me PAGE <yourmessage> }
    }
  }
}
on *:TEXT:*:#:{
  if ($asrini(awaymode) == Away) && ($me isin $1-) { 
    if ($window(@AwayLog) == $null) { window -ng1 @AwayLog }
    if ($asrini(awaylog.snd)) { .splay $asrini(awaylog.snd) }
    if ($asrini(awaysystem.log)) { write $asrini(awaysystemlog.log)  $time(HH:nn:ss) $date(mm/dd/yyyy) 13Message: <3 $+ $chan $+ 12\4 $+ $nick $+ > $1- }    
    aline -hp @AwayLog $time(HH:nn:ss) $date(mm/dd/yyyy) 13Message: <3 $+ $chan $+ 12\4 $+ $nick $+ > $1-
    if ($asrini(closemsg)) { close -m $nick }
    if ($asrini(notify)) { .msg $nick I'm currently away, your message has been logged. 
      if ($group(#awaypager).status == on) { .msg $nick If your message is urgent, please type 4/ctcp $me PAGE <yourmessage> }
    }
  }
}
#awaylogging end
#awaynotices on
on *:NOTICE:*:*:{
  if ($asrini(awaymode) == Away) && ($nick != $me) && ($group(#awaylogging).status == on) { 
    if ($window(@AwayLog) == $null) { window -ng1 @AwayLog }
    if ($asrini(awaylog.snd)) { .splay $asrini(awaylog.snd) }
    if ($asrini(awaysystem.log)) { write $asrini(awaysystemlog.log)  $time(HH:nn:ss) $date(mm/dd/yyyy) Notice: 5- $+ $nick $+ - $1- }
    aline -hp @AwayLog $time(HH:nn:ss) $date(mm/dd/yyyy) Notice:  $+ $colour(notice) $+ - $+ $nick $+ - $1-
  }
}
#awaynotices end
#asinputback off
on *:INPUT:#:{ if (Away isin $asrini(awaymode)) { setback } }
#asinputback end
#asnickpword off
on *:NICK:{ if ($nick == $me) {
    if (($newnick == %oldnick) && ($network == DALnet) && ($asrini(asnickpword)) && ($asrini(awaynick))) { 
      if ($asrini(asquietid) == 0) { .echo $colour(info) -a *** AwaySystem is Identifying to NickServ... }
    nickserv identify %oldnick $asrini(asnickpword) | unset %oldnick }
  }
}
#asnickpword end
dialog awaysysconf {
  title "AwaySystem 2.0 - Configuration"
  size -1 -1 160 120
  option dbu
  button "OK", 1, 69 117 27 12, ok default
  button "Cancel", 2, 99 117 27 12, cancel
  button "&Help!", 3, 131 117 27 12
  button "&Unload...", 34, 6 117 27 12
  tab "Pager/Log", 100, 3 3 156 100
  tab "Logging", 101
  tab "Sounds", 102
  tab "Nick", 103
  tab "Other", 99
  text "AwaySystem Control Center", 4, 45 20 70 20, center
  text "[Away Mode]", 35, 115 20 37 20, center
  box "Away&Pager", 5, 20 30 50 30, tab 100
  radio "Off", 6, 24 45 17 7, group center tab 100
  radio "On", 7, 48 45 17 7, center tab 100
  box "Away&Log", 8, 90 30 50 30, tab 100
  radio "Off", 9, 95 45  17 7, group center tab 100
  radio "On", 10, 118 45  17 7, center tab 100
  box "AwayLog Options", 37, 21 65 120 30, tab 100
  check "&Notify user that you are in Away Mode", 36, 30 75 99 7, tab 100
  check "&Capture Notices", 33, 25 85 47 7, tab 100
  check "Close &Query Window", 38, 77 85 60 7, tab 100
  box "AwaySystem &Logging", 11, 20 35 120 50, tab 101
  radio "Off", 12, 25 47 17 7, group center tab 101
  radio "On", 13, 45 47  17 7, center tab 101
  button "&View...", 14, 75 47 27 12, tab 101
  button "&Clear...", 15, 107 47 27 12, tab 101
  button "Change &Folder...", 16, 90 69 45 12, tab 101
  edit "",39, 25 69 63 11, autohs tab 101
  text "AwaySystem logs are stored in the file awaysys.log", 40, 20 95 120 7, tab 101
  text "Logging folder:", 41, 25 60 40 7, tab 101
  box "AwaySystem Sound Events", 17, 10 35 143 65, tab 102
  text "Away&Pager Sound:", 18, 15 45 50 7, tab 102
  check "Enable:", 19, 15 55 27 7, tab 102
  edit "",21, 43 53 80 11, autohs tab 102
  button "Change...", 22, 124 53 27 11, tab 102
  box "" 20, 10 66 143 34, tab 102
  text "Away&Log Sound:", 23, 15 75 50 7, tab 102
  check "Enable:", 24, 15 86  27 7, tab 102
  edit "",26, 43 84 80 11, autohs tab 102
  button "Change...", 27, 124 84 27 11, tab 102
  box "AwayNick Options", 28, 10 30 143 73, tab 103
  radio "&Disable", 29, 15 45  27 7, group center tab 103
  radio "&Enable", 30, 45 45 27 7, center tab 103
  text "&Nick:", 32, 75 45 12 7, tab 103
  edit "",31, 88 43 60 11, tab 103
  box "", 25, 10 57 143 46, tab 103
  Text "DALnet Options - On return to Back Mode:", 62, 15 65 101 7, tab 103
  check "&Identify to NickServ ->", 63, 15 78 61 7, tab 103
  text "&Password:", 64, 79 78 24 7, tab 103
  edit "", 65, 105 77 43 10, pass tab 103
  check "Enable ''&Quiet Identifying''", 66, 15 90 70 7, tab 103
  box "Other AwaySystem Options", 42, 10 30 142 68, tab 99
  check "&Repeat Away message every", 45, 15 40 78 7, tab 99
  edit "", 46, 95 39 13 10, center tab 99
  text "Minutes", 47, 110 40 19 7, tab 99
  check "&Show Away Mode status in mIRC Titlebar", 55,  15 52 107 7, tab 99
  check "&Allow CTCP PAGE requests in Back Mode", 57, 15 64 109 7, tab 99
  check "&Go into Away Mode after", 58, 15 75 68 7, tab 99
  edit "", 59, 85 74 13 10, center tab 99
  text "Minutes Idle", 60, 100 75 29 7, tab 99
  check "S&et to Back Mode on input", 61, 15 86 73 7, tab 99
}
on *:DIALOG:awaysysconf:init:0: {
  did -ft $dname 1
  did -ma $dname 39 $nofile($asrini(awaysystemlog.log))
  if ($asrini(awaytbar)) { did -c $dname 55 }
  if ($asrini(awaytimer)) { did -c $dname 45 | did -a $dname 46 $ascalc.dev($asrini(awaytimer)) }
  if ($asrini(awaytimer) == $null) { did -ma $dname 46 $ascalc.dev($asrini(oldtimer)) }
  if ($exists($scriptdirashelp.msg) == $false) { did -b $dname 3 }
  if ($group(#awaypager).status == on) { did -c $dname 7 }
  if ($group(#awaypager).status == off) { did -c $dname 6 }
  if ($group(#awaylogging).status == on) { did -c $dname 10 }
  if ($group(#awaylogging).status == off) { did -c $dname 9 | did -b $dname 33,36,38 }
  if ($group(#awaynotices).status == on) { did -c $dname 33 }
  if ($group(#asinputback).status == on) { did -c $dname 61 }
  if ($asrini(awaysystem.log)) { did -c $dname 13 }
  if ($asrini(awaysystem.log) != 1) { did -c $dname 12 | did -b $dname 16,39,41 }
  if ($asrini(awaypager.snd)) { did -c $dname 19 | did -nra $dname 21 $asrini(awaypager.snd) }
  if ($asrini(awaypager.snd) == $null) { did -ma $dname 21 $asrini(oldpager.snd) | did -b $dname 22 }
  if ($asrini(awaylog.snd)) { did -c $dname 24 | did -nra $dname 26 $asrini(awaylog.snd) }
  if ($asrini(awaylog.snd) == $null) { did -ma $dname 26 $asrini(oldlog.snd) | did -b $dname 27 }
  if ($asrini(awaynick)) { did -c $dname 30 | did -nra $dname 31 $asrini(awaynick) }
  if ($asrini(awaynick) == $null) { did -c $dname 29 | did -ba $dname 31 $asrini(oldnick1) | did -b $dname 32 }
  if ($asrini(notify)) { did -c $dname 36 }
  if ($asrini(closemsg)) { did -c $dname 38 }
  if ($asrini(ctcppage)) { did -c $dname 57 }
  if ($asrini(idleaway)) { did -c $dname 58 | did -a $dname 59 $ascalc.dev($asrini(idleaway)) }
  if ($asrini(idleaway) == $null) { did -ma $dname 59 $ascalc.dev($asrini(oldidletimer)) }
  if ($asrini(asnickpword)) { did -c $dname 63 | did -a $dname 65 $asrini(asnickpword) }
  if ($asrini(asnickpword) == $null) { did -b $dname 64,65 }
  if ($asrini(asquietid)) { did -c $dname 66 }
  if (Away isin $asrini(awaymode)) { did -bm $dname 12,13,16,39,41,28,29,30,31,32,34,42,45,46,47,55,57,58,59,60,61,62,63,64,65,66 }
  else { did -h $dname 35 }
}
On *:DIALOG:awaysysconf:sclick:45:{
  if ($did(45).state) { did -n $dname 46 }
  if ($did(45).state == 0) { did -m $dname 46 }
}
On *:DIALOG:awaysysconf:sclick:58:{
  if ($did(58).state) { did -n $dname 59 }
  if ($did(58).state == 0) { did -m $dname 59 }
}
On *:DIALOG:awaysysconf:sclick:63:{
  if ($did(63).state) { did -e $dname 64,65 }
  if ($did(63).state == 0) { did -b $dname 64,65 }
}
On *:DIALOG:awaysysconf:sclick:34:{ .timer 1 0 asuninstall }
On *:DIALOG:awaysysconf:sclick:3:{ awaysystemhelp }
On *:DIALOG:awaysysconf:sclick:1:{
  if ($did(6).state) { .disable #awaypager }
  if ($did(7).state) { .enable #awaypager }
  if ($did(9).state) { .disable #awaylogging }
  if ($did(10).state) { .enable #awaylogging }
  if ($did(12).state) { aswini awaysystem.log 0 }
  if ($did(13).state) { aswini awaysystem.log 1 }
  if ($did(19).state == 0) && ($asrini(awaypager.snd)) { aswini oldpager.snd $asrini(awaypager.snd) | asrmini awaypager.snd }
  if ($did(19).state) && ($did(21).text) { if ($isfile($did(21).text)) { aswini awaypager.snd $shortfn($did(21).text) } }
  if ($did(24).state == 0) && ($asrini(awaylog.snd)) { aswini oldlog.snd $asrini(awaylog.snd) | asrmini awaylog.snd }
  if ($did(24).state) && ($did(26).text) { if ($isfile($did(26).text)) { aswini awaylog.snd $shortfn($did(26).text) } }
  if ($did(29).state) && ($asrini(awaynick)) { aswini oldnick1 $asrini(awaynick) | asrmini awaynick }
  if ($did(30).state)  && ($did(31).text) { aswini awaynick $strip($did(31).text) }
  if ($did(33).state) { .enable #awaynotices }
  if ($did(33).state == 0) { .disable #awaynotices }
  if ($did(61).state) { .enable #asinputback }
  if ($did(61).state == 0) { .disable #asinputback }
  if ($did(36).state) { aswini notify 1 }
  if ($did(36).state == 0) { aswini notify 0 }
  if ($did(38).state) { aswini closemsg 1 }
  if ($did(38).state == 0) { aswini closemsg 0 }
  if ($did(39).text) { aswini awaysystemlog.log $shortfn($did(39).text) $+ awaysys.log }
  if ($did(45).state == 0) { asrmini awaytimer }
  if ($did(45).state) && ($did(46).text isnum) && ($did(46).text) { aswini awaytimer $ascalc.mult($did(46).text) | aswini oldtimer $asrini(awaytimer) }
  if ($did(46).text == 0) { asrmini awaytimer }
  if ($did(55).state) { aswini awaytbar 1 }
  if ($did(55).state == 0) { aswini awaytbar 0 }
  if ($did(57).state) { aswini ctcppage 1 }
  if ($did(57).state == 0) { aswini ctcppage 0 }
  if ($did(58).state == 0) { asrmini idleaway | if ($timer(IdleAway)) { .timerIdleAway off } }
  if ($did(58).state) && ($did(59).text isnum) && ($did(59).text) { aswini idleaway $ascalc.mult($did(59).text) | aswini oldidletimer $asrini(idleaway) | if ($timer(IdleAway) == $null) { beginasidlechck } }
  if ($did(59).text == 0) { asrmini idleaway | if ($timer(IdleAway)) { .timerIdleAway off } }
  if ($did(63).state) && ($did(65).text) { aswini asnickpword $strip($did(65).text) | .enable #asnickpword }
  if ($did(63).state == 0) { asrmini asnickpword | .disable #asnickpword }
  if ($did(66).state) { aswini asquietid 1 }
  if ($did(66).state == 0) { aswini asquietid 0 }
}
On *:DIALOG:awaysysconf:sclick:10:{ did -e $dname 33,36,38 }
On *:DIALOG:awaysysconf:sclick:9:{ did -b $dname 33,36,38 }
On *:DIALOG:awaysysconf:sclick:12:{ did -b $dname 16,39,41 }
On *:DIALOG:awaysysconf:sclick:13:{ did -e $dname 16,39,41 }
On *:DIALOG:awaysysconf:sclick:19:{
  if ($did(19).state == 0) { did -m $dname 21 | did -b $dname 22 }
  if ($did(19).state) { did -n $dname 21 | did -e $dname 22 }
}
On *:DIALOG:awaysysconf:sclick:24:{
  if ($did(24).state == 0) { did -m $dname 26 | did -b $dname 27 }
  if ($did(24).state) { did -n $dname 26 | did -e $dname 27 }
}
On *:DIALOG:awaysysconf:sclick:29:{ did -bm $dname 31,32 }
On *:DIALOG:awaysysconf:sclick:30:{ did -en $dname 31,32 }
On *:DIALOG:awaysysconf:sclick:14:{ awaysystemlog }
On *:DIALOG:awaysysconf:sclick:15:{ .timer 1 0 clearawaysystemlog }
On *:DIALOG:awaysysconf:sclick:16:{ .timer 1 0 logfolder }
On *:DIALOG:awaysysconf:sclick:22:{ .timer 1 0 pagersndselect }
On *:DIALOG:awaysysconf:sclick:27:{ .timer 1 0 logsndselect }
dialog awayd { 
  title "AwaySystem 2.0 - Enter Away Mode" 
  size -1 -1 160 40 
  option dbu
  text "&Away message:", 202, 5 7 37 7 
  edit "", 1, 43 5 115 11
  check "Away&Pager ", 2, 5 21 37 7 
  check "Away&Log ", 3, 55 21 32 7, 3state
  button "OK", 101, 5 35 27 12, OK default 
  button "Cancel", 102, 38 35 27 12, cancel
  check "&Nick:", 103, 75 38 22 7
  edit "",105, 98 36 60 11
  text "(", 106, 95 21 7 7
  check "= No Notice Logging)", 104, 97 21 60 7, 3state
} 
on *:DIALOG:awayd:init:0:{ 
  if ($group(#awaypager).status == on) { did -c awayd 2 } 
  if ($group(#awaylogging).status == on) { did -c awayd 3 }
  if ($group(#awaynotices).status == off) && ($group(#awaylogging).status == on) { did -cu awayd 3 }
  if ($asrini(awaynick)) { did -a awayd 105 $asrini(awaynick) | did -c awayd 103 }
  if ($asrini(awaynick) == $null) { did -m awayd 105 }
  if ($asrini(awaynick) == $null) && ($asrini(oldnick1)) { did -ma awayd 105 $asrini(oldnick1) }
  did -cu awayd 104
}
on *:DIALOG:awayd:sclick:104:{ did -cu awayd 104 }
on *:DIALOG:awayd:sclick:103:{
  if ($did(103).state == 0) { did -m awayd 105 }
  else { did -n awayd 105 }
}
on *:DIALOG:awayd:sclick:101:{ 
  %awaypager.status = $group(#awaypager).status
  %awaylogging.status = $group(#awaylogging).status
  %awaynotices.status = $group(#awaynotices).status
  if ($did(2).state) { .enable #awaypager }
  if ($did(2).state == 0) { .disable #awaypager }
  if ($did(3).state) { .enable #awaylogging #awaynotices }
  if ($did(3).state == 0) { .disable #awaylogging #awaynotices }
  if ($did(3).state == 2) { .enable #awaylogging | .disable #awaynotices }
  if ($did(103).state) && ($did(105).text) && ($asrini(awaynick)) { aswini oldnick2 $asrini(awaynick) | aswini awaynick $strip($did(105).text) }
  if ($did(103).state == 0) || ($did(105).text == $null) && ($asrini(awaynick)) { aswini oldnick2 $asrini(awaynick) | asrmini awaynick }
  if ($did(103).state) && ($did(105).text) { aswini awaynick $strip($did(105).text) }
  if ($did(1).text) { .set %awaymsg $did(1).text }
  else { .set %awaymsg Away }
  aswini awaymode Away
  setaway
} 
menu @AwayLog,@AwayPager,@AwaySystemLogs {
  $iif($active != @AwaySystemLogs,Clear Window &Buffer):clear
  $iif($active != @AwaySystemLogs,&View AwaySystem Logs):awaysystemlog
  $iif($active == @AwaySystemLogs,&Clear AwaySystem Logs...):clearawaysystemlog
  -
  &Configure &AwaySystem...:awaysys.config
  $iif($exists($scriptdirashelp.msg),&Help!):awaysystemhelp
  -
  Hide Window:window -h $active
  Close Window:window -c $active
}
menu channel,menubar,query,status {
  &AwaySystem ( $+ $asrini(awaymode) mode)
  .$iif($asrini(awaymode) == Back,Set to &Away Mode...):goaway
  .$iif($asrini(awaymode) != Back,Set to &Back Mode):setback
  .-
  .&Configure AwaySystem...:awaysys.config
  .&View AwaySystem Logs:awaysystemlog
  .-
  .$iif($exists($scriptdirashelp.msg),&Help!):awaysystemhelp
}
