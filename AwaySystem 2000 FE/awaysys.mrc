;AwaySystem 2000 Final Edition by mudpuddle - March 14, 2000
;http://www.geocities.com/mmircs/
;MmIRCS@bryansdomain.virtualave.net

on *:LOAD:{ 
  if ($version < 5.61) { asincompaterror }
  else {
    asecho $asversion by mudpuddle loaded sucessfully
    if ($exists(awaysys.ini) == $false) { asresetdefault }
    else { asimport }
    awaysys.config 
  }
}
on *:START:{ 
  if ($version < 5.61) { asincompaterror }
  else {
    if ($asrini(awaysysver) < $asver) { asimport }
    if ($asinichk == $false) { asresetdefault }
    unset %asqaway
    if ($asrini(awaymode) != Back) { setback }
  }
}
on *:CONNECT:{ 
  if (Away isin $asrini(awaymode)) {
    asecho Setting to Online $asrini(awaymode) Mode: (04 $+ %awaymsg $+ )
    away %awaymsg
    %asconnect.status = 1
    if ($asrini(awaysystem.log) == 1) { writeaslog  $+ $colour(action) $+ *** Set to Online $asrini(awaymode) Mode (Connected to IRC server) @ $time(HH:nn:ss) $date(mm/dd/yyyy) (04 $+ %awaymsg $+  $+ $colour(action) $+ ) }
    if ($me != $asrini(awaynick)) && ($asrini(awaymode) != StealthAway) && ($asrini(awaynick)) { nick $asrini(awaynick) }
    doastimer
  }
  elseif ($asrini(idleaway)) { beginasidlechck | asecho AwayIdle checker started } 
}
on *:DISCONNECT:{ 
  if ($asrini(awaymode) == IdleAway) { .timer -m 1 50 setback | .timerIdleAway off }
  unset %asconnect.status 
}
on *:JOIN:#:{ if (%asconnect.status) && ($nick == $me) { setaway.disp | unset %asconnect.status } }
alias -l asversion { return AwaySystem 2000 Final Edition ( $+ $asver $+ ) }
alias -l asver { return 2.12 }
alias -l asverno { aswini awaysysver $asver }
alias -l awaypager { if ($asrini(awaypager)) { return on }
else { return off } }
alias -l awaylogging { if ($asrini(awaylogging)) { return on }
else { return off } }
alias -l awaynotices { if ($asrini(awaynotices)) { return on }
else { return off } }
alias -l asimport { asecho Importing AwaySystem settings
  if ($asrini(awaysysver) < $asver) { 
    if ($asrini(tbarupdate) == $null) { aswini tbarupdate 1 }
    if ($asrini(notify1) == $null) { aswini notify1 1 }
    if ($asrini(awaypager) == $null) { aswini awaypager 1 }
    if ($asrini(awaylogging) == $null) { aswini awaylogging 1 }
    if ($asrini(awaynotices) == $null) { aswini awaynotices 1 }
    if ($asrini(asinputback) == $null) { aswini asinputback 0 }
    if ($asrini(asnickpword)) { aswini asidno $asrini(asnickpword) | asrmini asnickpword }
  }
  asverno
}
alias -l asincompaterror { asecho Error! $asversion will not work on mIRC $version $+ . mIRC 5.61 or later is required. | unload -rs $nopath($script) }
alias -l writeaslog {
  if ($asrini(awaysystemlog.log)) { write $shortfn($asrini(awaysystemlog.log)) $1- | updateaslogwindow }
  else { asecho Logging folder not set and has been disabled. | aswini awaysystem.log 0 | aswini awaysystemlog.log $logdir }
}
alias -l ascheckini { 
  if ($exists(awaysys.ini)) && ($asrini(awaymode)) { return $true }
  else { return $false }
}
alias -l asecho { echo $colour(info) -ae *** AwaySystem - $1- }
alias -l playaslogsnd { splay $shortfn($asrini(awaylog.snd)) }
alias -l asrini { return $readini -n awaysys.ini AwaySystem $1- }
alias -l aswini { writeini -n awaysys.ini AwaySystem $1- }
alias -l asrmini { remini awaysys.ini AwaySystem $1- }
alias -l assite { return http://www.geocities.com/mmircs/ }
alias -l ascalc.mult { return $calc($1 * 60) }
alias -l ascalc.dev { return $calc($1 / 60) }
alias -l beginasidlechck { if ($server) { resetidle | .timerIdleAway 0 10 ascheckidle } }
alias -l ascheckidle {  if ($asrini(awaymode) == Back) { if ($idle > $asrini(idleaway)) { %awaymsg = Auto IdleAway after $ascalc.dev($asrini(idleaway)) minute(s) | awaystatus.set | if ($asrini(awaynick)) { aswini oldnick2 $asrini(awaynick) } | aswini awaymode IdleAway | setaway } } }
alias -l setaway.disp { if ($chan(0) > 0) && ($asrini(awaymode) != StealthAway) && ($server) { ame is away (12Reason:04 %awaymsg $+ ) since %awayclock $+ . AwayPager is $awaypager $+ , AwayLog is $awaylogging } }
alias -l setback.disp { if ($chan(0) > 0) && ($asrini(awaymode) != StealthAway) && ($server) { ame is back (12Back from:04 %awaymsg $+ ) Gone for $duration($calc(%awayback - %awaytime)) } }
alias -l doastimer { if ($asrini(awaytimer)) && ($asrini(awaymode) != StealthAway) && ($server) { .timerAway 0 $asrini(awaytimer) setaway.disp } }
alias -l setaway { 
  if ($timer(IdleAway)) { .timerIdleAway off }
  if ($asrini(awaysystem.log) == 1) { writeaslog  $+ $colour(action) $+ *** Set to $asrini(awaymode) Mode @ $time(HH:nn:ss) $date(mm/dd/yyyy) (4 $+ %awaymsg $+  $+ $colour(action) $+ ) }
  %awaytime = $ctime
  if ($server) { away %awaymsg }
  %awayclock = $time(h:nn:ss tt)
  setaway.disp
  if ($asrini(awaymode) != StealthAway) && ($asrini(awaynick)) { %oldnick = $me | nick $asrini(awaynick) }
  doastimer
  if ($asrini(awaymode) == StealthAway) && ($server) { asecho Setting to StealthAway Mode (04 $+ %awaymsg $+ ) AwayPager: $awaypager $+ , AwayLog: $awaylogging }
  if ($asrini(tbarupdate)) && ($timer(Tbar) == $null) && ($asrini(awaytbar)) { .timerTbar -o 0 1 tbar }
  tbar
}
alias -l setback { 
  %awayback = $ctime
  if ($server == $null) || ($asrini(awaymode) == StealthAway) { asecho Setting to Back Mode - Gone for $duration($calc(%awayback - %awaytime)) }   
  if (%oldnick) && ($asrini(awaymode) != StealthAway) { nick %oldnick }
  if ($server) { away | setback.disp }
  if ($timer(Away)) { .timerAway off }
  aswini awaymode Back
  awaystatus.compare
  if ($asrini(awaysystem.log) == 1) { writeaslog  $+ $colour(action) $+ *** Set to Back Mode @ $time(HH:nn:ss) $date(mm/dd/yyyy) | writeaslog - }
  if ($asrini(asidno) == $null) || ($server == $null) { unset %oldnick }
  if ($asrini(idleaway)) { beginasidlechck }
  tbar
  unset %away* %asnicks
  resetidle
}
alias -l tbar { 
  if ($asrini(awaytbar)) {
    if ($asrini(tbarupdate)) && ($asrini(awaymode) != Back) { titlebar - $iif($server,Online,Offline) $asrini(awaymode) Mode ( $+ %awaymsg $+ ) for $duration($calc($ctime - %awaytime)) - AwayPager $awaypager $+ , AwayLog $iif($awaynotices == on,& NoticeLog) $awaylogging }
    if ($asrini(tbarupdate) == 0) && ($asrini(awaymode) != Back) { titlebar - $asrini(awaymode) Mode ( $+ %awaymsg $+ ) since %awayclock - AwayPager $awaypager $+ , AwayLog $iif($awaynotices == on,& NoticeLog) $awaylogging }
    elseif (Away !isin $asrini(awaymode)) { titlebar | .timerTbar off }
  }
}
alias -l asreset.confirm { 
  if ($?!="Reset ALL options to their default values?") { 
    dialog -x awaysysconf
    if (Away isin $asrini(awaymode)) { asecho Setting to Back Mode for options reset... | setback } 
  asresetdefault | asecho All options have been reset to their default values } 
}
alias -l asresetdefault { asrmini | aswini awaymode Back | aswini awaypager 1 | aswini awaylogging 1 | aswini awaynotices 1 | aswini asinputback 0 | aswini awaysystem.log 0 | aswini awaysystemlog.log $logdir $+ awaysys.log | aswini closemsg 1 | aswini notify 1 | aswini asquietid 0 | aswini awaytimer 2700 | aswini awaytbar 1 | aswini ctcppage 1 | aswini oldidletimer 900 | aswini tbarupdate 1 | aswini notify1 1 | asverno | unset %asqaway %asnicks }
alias -l clearawaysystemlog { 
  if ($$?!="Clear AwaySystem Logs?") { 
    if ($exists($shortfn($asrini(awaysystemlog.log)))) { .remove $shortfn($asrini(awaysystemlog.log)) }
    clear @AwaySystem 
    asecho All Logs have been cleared
    updaslogsize
  }
}
alias -l updateaslogwindow {
  if ($window(@AwaySystem)) && ($asrini(awaysystemlog.log)) { 
    clear @AwaySystem
    if ($exists($shortfn($asrini(awaysystemlog.log)))) { loadbuf -p @AwaySystem $shortfn($asrini(awaysystemlog.log)) }
  }
  updaslogsize
} 
alias -l awaysystemlog {
  clear @AwaySystem
  window -adk0 @AwaySystem 90 90
  titlebar @AwaySystem LogViewer - $asrini(awaysystemlog.log)
  if ($exists($shortfn($asrini(awaysystemlog.log)))) { loadbuf -p @AwaySystem $shortfn($asrini(awaysystemlog.log)) }
  else { 
    clear @AwaySystem
    aline -p @AwaySystem  $+ $colour(info) $+ *** AwaySystem Logs are empty
  }
}
alias -l asredoawaymsg {
  if ($1) {
    if ($timer(Away)) { .timerAway off }
    %awaymsg = $1-
    if ($server) { away %awaymsg }
    if ($asrini(awaymode) == IdleAway) { aswini awaymode Away }
    setaway.disp
    if ($asrini(awaymode) == StealthAway) || ($server == $null) { asecho Changed $asrini(awaymode) message (04 $+ %awaymsg $+ ) }
    tbar
    doastimer
    if ($asrini(awaysystem.log)) { writeaslog  $+ $colour(action) $+ *** Changed $asrini(awaymode) Message (04 $+ %awaymsg $+  $+ $colour(action) $+ ) @ $time(HH:nn:ss) $date(mm/dd/yyyy) }
  }
}
alias -l logfolder {
  did -ra awaysysconf 39 $$sdir="Select Folder for the AwaySystem Log file"  $iif($asrini(awaysystemlog.log), $nofile($shortfn($asrini(awaysystemlog.log))), $logdir)
}
alias -l pagersndselect { did -ran awaysysconf 21 $$dir="Select AwayPager Sound" *.wav | did -c awaysysconf 19 | did -e awaysysconf 70 }
alias -l updaslogsize { if ($dialog(awaysysconf)) { 
    if ($file($asrini(awaysystemlog.log)).size > 0) { did -a awaysysconf 73 $round($calc($file($asrini(awaysystemlog.log)).size / 1024),2) KB } 
    else { did -a awaysysconf 73 Empty }
  } 
}
alias -l logsndselect { did -ran awaysysconf 26 $$dir="Select AwayLog Sound" *.wav | did -c awaysysconf 24 | did -e awaysysconf 71 }
alias -l asuninstall { if ($$?!="This operation unloads AwaySystem from mIRC. Do you wish to continue?") { 
    if (Away isin $asrini(awaymode)) { asecho Removing Away status from IRC for AwaySystem uninstall... | setback }
    clearawaysystemlog
    if ($$?!="Keep ini file for future importing?" == $false) { .remove awaysys.ini }
    if ($timer(IdleAway)) { .timerIdleAway off }
    unset %oldnick %away* %asqaway %asnicks | dialog -x awaysysconf | asecho $asversion by mudpuddle unloaded | .unload -rs $nopath($script) 
  }
}
alias -l awaystatus.set {
  %awaypager.status = $awaypager
  %awaylogging.status = $awaylogging
  %awaynotices.status = $awaynotices
}
alias -l awaysystemhelp {
  if ($window(@AwaySystemHelp)) { window -a @AwaySystemHelp }
  else {
    if ($exists($scriptdirashelp.msg)) {
      clear @AwaySystemHelp
      window -adlk0 +tne @AwaySystemHelp -1 -1 600 400 MS Sans Serif,413
      loadbuf -p @AwaySystemHelp $shortfn($scriptdirashelp.msg)
    }
  }
}
alias -l awaysys.config {
  if ($dialog(awaysysconf)) { dialog -v awaysysconf }
  else { $dialog(awaysysconf,awaysysconf,-2) }
}
alias -l goaway { $dialog(asawaydiag,asawaydiag) }
alias -l awaystatus.compare {
  if ($asrini(oldnick2) == $null) { asrmini awaynick }
  if ($asrini(oldnick2)) { aswini awaynick $asrini(oldnick2) | asrmini oldnick2 }
  if (%awaypager.status == on) { aswini awaypager 1 }
  if (%awaylogging.status == on) { aswini awaylogging 1 }
  if (%awaynotices.status == on) { aswini awaynotices 1 }
  if (%awaypager.status == off) { aswini awaypager 0 }
  if (%awaylogging.status == off) { aswini awaylogging 0 }
  if (%awaynotices.status == off) { aswini awaynotices 0 }
  unset %awaypager.status %awaylogging.status %awaynotices.status
}
alias -l doeditboxchk {
  if ($len($did(1)) < 100) { did -a $dname 4 $len($did(1)) }
  if ($len($did(1)) == 100) { %did1text = $did(1) | did -a $dname 4 Max }
  if ($len($did(1)) == 101) { did -ar $dname 1 %did1text | beep 1 | %did1text = $did(1) }
}
alias -l asawaynotice {
  if ($asrini(notify)) {
    if ($nick isin %asnicks) { return }
    else {
      if ($asrini(notify1)) { %asnicks = %asnicks $nick }
      .notice $nick I'm currently away ( $+ %awaymsg $+ ), your message has been logged
      if ($awaypager == on) { .notice $nick If your message is urgent, you may page me by typing 04/ctcp $me PAGE <yourmessage> }
    }
  }
}
ctcp &*:VERSION:.ctcpreply $nick VERSION $asversion by mudpuddle:12 $assite
ctcp *:PAGE:{ if ($asrini(awaypager)) {
    if (Away isin $asrini(awaymode)) || ($asrini(ctcppage)) {
      if ($nick != $me) { 
        var %temppage $time(HH:nn:ss) $date(m/d/yyyy)  $+ $colour(CTCP) $+ Page:12 $nick $+ :  $2-
        if ($asrini(awaypager.snd)) { splay $shortfn($asrini(awaypager.snd)) }
        if ($window(@AwayPager) == $null) { window -ng2 @AwayPager }
        aline -hp @AwayPager %temppage
        if ($asrini(awaysystem.log)) { writeaslog %temppage }
        .ctcpreply $nick PAGE Your page has been logged!
      }
    }
} 
}
on *:TEXT:*:?:{
  if (Away isin $asrini(awaymode)) && ($nick != $me) && ($asrini(awaylogging)) { 
    var %temppriv $time(HH:nn:ss) $date(m/d/yyyy) PrivMessage: <4 $+ $nick $+ > $1-
    if ($window(@AwayLog) == $null) { window -ng1 @AwayLog }
    if ($asrini(awaylog.snd)) { playaslogsnd }
    if ($asrini(awaysystem.log)) { writeaslog %temppriv }
    aline -hp @AwayLog %temppriv
    if ($asrini(closemsg)) { close -m $nick }
    asawaynotice
  }
}
on *:TEXT:*:#:{
  if (Away isin $asrini(awaymode)) && ($me isin $1-) && ($asrini(awaylogging)) { 
    var %tempmsg $time(HH:nn:ss) $date(m/d/yyyy) 13ChanMessage: <3 $+ $chan $+ 12\4 $+ $nick $+ > $1-
    if ($window(@AwayLog) == $null) { window -ng1 @AwayLog }
    if ($asrini(awaylog.snd)) { playaslogsnd }
    if ($asrini(awaysystem.log)) { writeaslog  %tempmsg }    
    aline -hp @AwayLog %tempmsg
    if ($asrini(closemsg)) { close -m $nick }
    asawaynotice
  }
}
on *:NOTICE:*:*:{
  if (Away isin $asrini(awaymode)) && ($nick != $me) && ($asrini(awaylogging)) && ($asrini(awaynotices)) { 
    var %tempnotice $time(HH:nn:ss) $date(mm/dd/yyyy) Notice:  $+ $colour(notice) $+ - $+ $nick $+ - $1-
    if ($window(@AwayLog) == $null) { window -ng1 @AwayLog }
    if ($asrini(awaylog.snd)) { playaslogsnd }
    if ($asrini(awaysystem.log)) { writeaslog %tempnotice }
    aline -hp @AwayLog %tempnotice
  }
}
on *:INPUT:#:{ if (Away isin $asrini(awaymode)) && ($asrini(asinputback)) { setback } }
on *:NICK:{
  if ($nick == $me) && ($asrini(asidno)) {
    if ($newnick == %oldnick) { 
      if ($asrini(asquietid) == 0) { asecho Identifying to NickServ... }
    nickserv identify %oldnick $asrini(asidno) | unset %oldnick }
  }
}
dialog awaysysconf {
  title "AwaySystem 2000 FE - Configuration"
  size -1 -1 163 135
  option dbu
  button "OK", 1, 69 117 27 12, ok default
  button "Cancel", 2, 99 117 27 12, cancel
  button "&Help!", 3, 131 117 27 12
  button "&Unload...", 34, 6 117 27 12
  button "&Reset...", 72, 34 117 27 12
  tab "Pager/Log", 100, 3 3 156 106
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
  box "AwayLog Options", 37, 21 65 120 41, tab 100
  check "&Notify user that you are in Away Mode", 36, 25 75 99 7, tab 100
  check "&Capture Notices", 33, 25 85 47 7, tab 100
  check "Close &Query Windows", 38, 77 85 62 7, tab 100
  check "&Send Away Mode notify once per session", 74, 25 95 109 7, tab 100
  box "AwaySystem &Logging", 11, 20 35 120 50, tab 101
  check "&Enable Logging", 12, 25 47 50 7, tab 101
  button "&View...", 14, 80 47 25 12, tab 101
  button "&Clear...", 15, 109 47 25 12, tab 101
  button "Change &Folder...", 16, 90 69 45 12, tab 101
  edit "",39, 25 69 63 11, autohs tab 101
  text "AwaySystem log file (awaysys.log) is:", 40, 25 95 87 7, tab 101
  text "", 73, 112 95 32 7, tab 101
  text "Log folder:", 41, 25 60 40 7, tab 101
  box "AwaySystem Sounds", 17, 10 35 143 65, tab 102
  text "Away&Pager Sound:", 18, 15 45 50 7, tab 102
  button "Preview", 70, 124 42 27 10, tab 102
  check "Enable:", 19, 15 55 27 7, tab 102
  edit "",21, 43 53 80 11, autohs tab 102
  button "Change...", 22, 124 55 27 11, tab 102
  box "" 20, 10 66 143 34, tab 102
  text "Away&Log Sound:", 23, 15 75 50 7, tab 102
  check "Enable:", 24, 15 86  27 7, tab 102
  edit "",26, 43 84 80 11, autohs tab 102
  button "Preview", 71, 124 73 27 10, tab 102
  button "Change...", 27, 124 86 27 11, tab 102
  box "AwayNick", 28, 10 30 143 73, tab 103
  check "&Enable ->", 30, 15 45 31 7, center tab 103
  text "&Nickname:", 32, 48 45 26 7, tab 103
  edit "", 31, 75 43 73 11, tab 103
  box "", 25, 10 57 143 46, tab 103
  Text "On return to Back Mode:", 62, 15 65 101 7, tab 103
  check "&Identify to NickServ ->", 63, 15 78 61 7, tab 103
  text "&Password:", 64, 79 78 25 7, tab 103
  edit "", 65, 105 77 43 10, pass tab 103
  check "Enable ''&Quiet Identifying''", 66, 15 90 70 7, tab 103
  box "Other AwaySystem Options", 42, 10 30 142 75, tab 99
  check "Repeat Away &message every", 45, 15 40 78 7, tab 99
  edit "", 46, 95 39 13 10, center tab 99
  text "Minutes", 47, 110 40 19 7, tab 99
  check "&Show Away Mode status in mIRC Titlebar", 55, 15 52 107 7, tab 99
  check "Enable Active Titlebar &Updating", 13, 25 62 85 7, tab 99
  check "&Allow CTCP PAGE requests in Back Mode", 57, 15 94 109 7, tab 99
  check "&Go into Away mode after", 58, 15 73 68 7, tab 99
  edit "", 59, 85 72 13 10, center tab 99
  text "Minutes Idle", 60, 100 73 29 7, tab 99
  check "S&et to Back Mode on input", 61, 15 84 73 7, tab 99
}
on *:DIALOG:awaysysconf:sclick:70:{ if ($isfile($did(21))) { splay $shortfn($did(21)) } }
on *:DIALOG:awaysysconf:sclick:71:{ if ($isfile($did(26))) { splay $shortfn($did(26)) } }
on *:DIALOG:awaysysconf:init:0:{
  did -ft $dname 1
  did -ma $dname 39 $nofile($asrini(awaysystemlog.log))
  if ($asrini(notify1)) { did -c $dname 74 }
  if ($asrini(awaytimer)) { did -c $dname 45 | did -a $dname 46 $ascalc.dev($asrini(awaytimer)) }
  if ($asrini(awaytimer) == $null) { did -ma $dname 46 $ascalc.dev($asrini(oldtimer)) }
  if ($exists($scriptdirashelp.msg) == $false) { did -b $dname 3 }
  if (Away !isin $asrini(awaymode)) {
    if ($awaypager == on) { did -c $dname 7 }
    if ($awaypager == off) { did -c $dname 6 }
    if ($awaylogging == on) { did -c $dname 10 }
    if ($awaylogging == off) { did -c $dname 9 }
    if ($awaynotices == on) { did -c $dname 33 }
    if ($asrini(awaynick)) { did -c $dname 30 | did -nra $dname 31 $asrini(awaynick) }
    did -h $dname 35
  }
  if ($asrini(asinputback)) { did -c $dname 61 }
  if ($asrini(awaysystem.log)) { did -c $dname 12 }
  if ($asrini(awaysystem.log) != 1) { did -b $dname 16,39,41 }
  if ($asrini(awaypager.snd)) { did -c $dname 19 | did -nra $dname 21 $asrini(awaypager.snd) }
  if ($asrini(awaypager.snd) == $null) { did -ma $dname 21 $asrini(oldpager.snd) | did -b $dname 70 }
  if ($asrini(awaylog.snd)) { did -c $dname 24 | did -nra $dname 26 $asrini(awaylog.snd) }
  if ($asrini(awaylog.snd) == $null) { did -ma $dname 26 $asrini(oldlog.snd) | did -b $dname 71 }
  if ($asrini(awaynick) == $null) { did -ba $dname 31 $asrini(oldnick1) | did -b $dname 32 }
  if ($asrini(notify)) { did -c $dname 36 }
  if ($asrini(closemsg)) { did -c $dname 38 }
  if ($asrini(ctcppage)) { did -c $dname 57 }
  if ($asrini(idleaway)) { did -c $dname 58 | did -a $dname 59 $ascalc.dev($asrini(idleaway)) }
  if ($asrini(idleaway) == $null) { did -ma $dname 59 $ascalc.dev($asrini(oldidletimer)) }
  if ($asrini(asidno)) { did -c $dname 63 | did -a $dname 65 $asrini(asidno) }
  if ($asrini(asidno) == $null) { did -b $dname 64,65 }
  if ($asrini(asquietid)) { did -c $dname 66 }
  if ($asrini(awaytbar)) { did -c $dname 55 }
  if ($did(55).state == 0) { did -b $dname 13 }
  if ($asrini(tbarupdate)) { did -c $dname 13 }
  if (Away isin $asrini(awaymode)) { 
    did -bm $dname 13,30,31,32,45,46,47,55,58,59,60,74
    if (%awaypager.status == off) { did -c $dname 6 }
    if (%awaypager.status == on) { did -c $dname 7 }
    if (%awaylogging.status == off) { did -c $dname 9 }
    if (%awaylogging.status == on) { did -c $dname 10 }
    if (%awaynotices.status == on) { did -c $dname 33 }
    if ($asrini(oldnick2)) { did -c $dname 30 | did -nra $dname 31 $asrini(oldnick2) }
    else { did -nra $dname 31 $asrini(oldnick1) }
  }
  updaslogsize 
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
  if (Away !isin $asrini(awaymode)) {
    if ($did(6).state) { aswini awaypager 0 }
    if ($did(7).state) { aswini awaypager 1 }
    if ($did(9).state) { aswini awaylogging 0 }
    if ($did(10).state) { aswini awaylogging 1 }
    if ($did(33).state) { aswini awaynotices 1 }
    if ($did(33).state == 0) { aswini awaynotices 0 }
    if ($did(30).state == 0) && ($asrini(awaynick)) { aswini oldnick1 $asrini(awaynick) | asrmini awaynick }
    if ($did(30).state)  && ($did(31)) { aswini awaynick $strip($did(31)) }
  }
  if (Away isin $asrini(awaymode)) {
    if ($did(6).state) { %awaypager.status = off }
    if ($did(7).state) { %awaypager.status = on }
    if ($did(9).state) { %awaylogging.status = off }
    if ($did(10).state) { %awaylogging.status = on }
    if ($did(33).state) { %awaynotices.status = on }
    if ($did(33).state == 0) { %awaynotices.status = off }
  }
  if ($did(12).state == 0) { aswini awaysystem.log 0 }
  if ($did(12).state) { aswini awaysystem.log 1 }
  if ($did(19).state == 0) && ($asrini(awaypager.snd)) { aswini oldpager.snd $asrini(awaypager.snd) | asrmini awaypager.snd }
  if ($did(19).state) && ($did(21)) { if ($isfile($did(21))) { aswini awaypager.snd $did(21) } }
  if ($did(24).state == 0) && ($asrini(awaylog.snd)) { aswini oldlog.snd $asrini(awaylog.snd) | asrmini awaylog.snd }
  if ($did(24).state) && ($did(26)) { if ($isfile($did(26))) { aswini awaylog.snd $did(26) } }
  if ($did(61).state) { aswini asinputback 1 }
  if ($did(61).state == 0) { aswini asinputback 0 }
  if ($did(36).state) { aswini notify 1 }
  if ($did(36).state == 0) { aswini notify 0 }
  if ($did(38).state) { aswini closemsg 1 }
  if ($did(38).state == 0) { aswini closemsg 0 }
  if ($did(39)) { aswini awaysystemlog.log $did(39) $+ awaysys.log }
  if ($did(45).state == 0) { asrmini awaytimer }
  if ($did(45).state) && ($did(46) isnum) && ($did(46)) { aswini awaytimer $ascalc.mult($did(46)) | aswini oldtimer $asrini(awaytimer) }
  if ($did(46) == 0) { asrmini awaytimer }
  if ($did(55).state) { aswini awaytbar 1 }
  if ($did(55).state == 0) { aswini awaytbar 0 }
  if ($did(57).state) { aswini ctcppage 1 }
  if ($did(57).state == 0) { aswini ctcppage 0 }
  if ($did(58).state == 0) { asrmini idleaway | if ($timer(IdleAway)) { .timerIdleAway off } }
  if ($did(58).state) && ($did(59) isnum) && ($did(59)) { aswini idleaway $ascalc.mult($did(59)) | aswini oldidletimer $asrini(idleaway) | if ($timer(IdleAway) == $null) { beginasidlechck } }
  if ($did(59) == 0) { asrmini idleaway | if ($timer(IdleAway)) { .timerIdleAway off } }
  if ($did(63).state) && ($did(65)) { aswini asidno $strip($did(65)) }
  if ($did(63).state == 0) { asrmini asidno }
  if ($did(66).state) { aswini asquietid 1 }
  if ($did(66).state == 0) { aswini asquietid 0 }
  if ($did(13).state) { aswini tbarupdate 1 }
  if ($did(13).state == 0) { aswini tbarupdate 0 }
  if ($did(74).state) { aswini notify1 1 }
  if ($did(74).state == 0) { aswini notify1 0 }
}
On *:DIALOG:awaysysconf:sclick:12:{ 
  if ($did(12).state == 0) { did -b $dname 16,39,41 }
  if ($did(12).state) { did -e $dname 16,39,41 }
}
On *:DIALOG:awaysysconf:sclick:19:{
  if ($did(19).state == 0) { did -m $dname 21 | did -b $dname 70 }
  if ($did(19).state) { did -n $dname 21 | did -e $dname 70 }
}
On *:DIALOG:awaysysconf:sclick:24:{
  if ($did(24).state == 0) { did -m $dname 26 | did -b $dname 71 }
  if ($did(24).state) { did -n $dname 26 | did -e $dname 71 }
}
On *:DIALOG:awaysysconf:sclick:30:{ 
  if ($did(30).state) { did -en $dname 31,32 }
  elseif ($did(30).state == 0) { did -bm $dname 31,32 }
}
On *:DIALOG:awaysysconf:sclick:14:{ awaysystemlog }
On *:DIALOG:awaysysconf:sclick:15:{ .timer 1 0 clearawaysystemlog }
On *:DIALOG:awaysysconf:sclick:16:{ .timer 1 0 logfolder }
On *:DIALOG:awaysysconf:sclick:22:{ .timer 1 0 pagersndselect }
On *:DIALOG:awaysysconf:sclick:27:{ .timer 1 0 logsndselect }
On *:DIALOG:awaysysconf:sclick:72:{ .timer 1 0 asreset.confirm }
On *:DIALOG:awaysysconf:sclick:55:{ 
  if ($did(55).state) { did -e $dname 13 }
  if ($did(55).state == 0) { did -b $dname 13 }
}
dialog asawaydiag { 
  title "AwaySystem - Enter Away Mode" 
  size -1 -1 175 52 
  option dbu
  text "&Away message:", 202, 5 7 37 7
  edit "", 1, 43 5 118 11, autohs
  text "0", 4, 163 7 13 7
  check "Away&Pager on", 2, 5 21 44 7 
  check "Away&Log on", 3, 58 21 39 7, 3state
  button "OK", 101, 5 35 27 12, OK default
  button "Cancel", 102, 38 35 27 12, cancel
  check "&Nick:", 103, 75 38 22 7
  edit "", 105, 98 36 73 11
  text "(", 106, 105 21 7 7
  check "= No Notice Logging)", 104, 107 21 60 7, 3state
} 
on *:DIALOG:asawaydiag:sclick:102:{ unset %asqaway %did1text }
on *:DIALOG:asawaydiag:init:0:{ 
  if (%asqaway) { dialog -t $dname AwaySystem - Enter StealthAway Mode | did -h $dname 103,105 }
  if ($awaypager == on) { did -c $dname 2 } 
  if ($awaylogging == on) { did -c $dname 3 }
  if ($awaynotices == off) && ($awaylogging == on) { did -cu $dname 3 }
  if ($asrini(awaynick)) { did -a $dname 105 $asrini(awaynick) | did -c $dname 103 }
  if ($asrini(awaynick) == $null) { did -b $dname 105 }
  if ($asrini(awaynick) == $null) && ($asrini(oldnick1)) { did -ba $dname 105 $asrini(oldnick1) }
  did -cu $dname 104
}
on *:DIALOG:asawaydiag:edit:1:{ doeditboxchk }
on *:DIALOG:asawaydiag:sclick:104:{ did -cu $dname 104 }
on *:DIALOG:asawaydiag:sclick:103:{
  if ($did(103).state == 0) { did -b $dname 105 }
  else { did -e $dname 105 }
}
on *:DIALOG:asawaydiag:sclick:101:{ 
  awaystatus.set | unset %did1text
  if ($did(2).state) { aswini awaypager 1 }
  if ($did(2).state == 0) { aswini awaypager 0 }
  if ($did(3).state) { aswini awaylogging 1 | aswini awaynotices 1 }
  if ($did(3).state == 0) { aswini awaylogging 0 | aswini awaynotices 0 }
  if ($did(3).state == 2) { aswini awaylogging 1 | aswini awaynotices 0 }
  if ($did(103).state) && ($did(105)) && ($asrini(awaynick)) { aswini oldnick2 $asrini(awaynick) | aswini awaynick $strip($did(105)) }
  if ($did(103).state == 0) || ($did(105) == $null) && ($asrini(awaynick)) { aswini oldnick2 $asrini(awaynick) | asrmini awaynick }
  if ($did(103).state) && ($did(105)) { aswini awaynick $strip($did(105)) }
  if ($did(1)) { %awaymsg = $did(1) }
  if ($did(1) == $null) { %awaymsg = Away }
  if (%asqaway) { aswini awaymode StealthAway }
  if (%asqaway == $null) { aswini awaymode Away }
  if ($server == $null) { asecho Setting to Offline $asrini(awaymode) mode (4 $+ %awaymsg $+ ) - AwayPager: $awaypager $+ , AwayLog: $awaylogging $+ . You will be set to Online $asrini(awaymode) when you connect to IRC. }
  setaway
  unset %asqaway
}
dialog asmsgchng { 
  title "AwaySystem - Change Away Message" 
  size -1 -1 175 42 
  option dbu
  text "&New message:", 200, 5 7 35 7
  edit "", 1, 43 5 118 11, autohs
  text "0", 4, 163 7 13 7
  button "OK", 101, 5 25 27 12, OK default disable
  button "Cancel", 102, 38 25 27 12, cancel
}
On *:DIALOG:asmsgchng:sclick:101:{
  asredoawaymsg $did(1) | unset %did1text
}
on *:DIALOG:asmsgchng:sclick:102:{ unset %did1text }
On *:DIALOG:asmsgchng:edit:1:{
  if ($did(1)) { did -e $dname 101 }
  else { did -b $dname 101 }
  doeditboxchk
}
menu @AwayLog,@AwayPager,@AwaySystem {
  $iif($exists(awaysys.ini) == $false || $asrini(awaymode) == $null,Click to rebuild config file):asresetdefault
  $iif($active != @AwaySystem && $ascheckini,Clear Window &Buffer):clear
  $iif($active != @AwaySystem && $ascheckini,AwaySystem Log&Viewer):awaysystemlog
  $iif($active == @AwaySystem && $ascheckini,&Clear AwaySystem Logs...):clearawaysystemlog
  -
  $iif($ascheckini,&Configure &AwaySystem...):awaysys.config
  $iif($exists($scriptdirashelp.msg),Help &Window, [Help not available]):awaysystemhelp
  -
  &Hide Window:window -h $active
}
menu channel,menubar,status {
  &AwaySystem ( $+ $iif($asrini(awaymode) == $null,Unknown,$asrini(awaymode)): Mode)
  .$iif($exists(awaysys.ini) == $false || $asrini(awaymode) == $null,Click to rebuild config file):asresetdefault
  .$iif($asrini(awaymode) == Back,Set to &Away Mode...):goaway
  .$iif($asrini(awaymode) == Back,Set to &StealthAway Mode...):%asqaway = 1 | goaway
  .$iif(Away isin $asrini(awaymode),Set to &Back Mode):setback
  .$iif(Away isin $asrini(awaymode),Change Away &Message...):$dialog(asmsgchng,asmsgchng)
  .-
  .$iif($ascheckini,&Configure AwaySystem...):awaysys.config
  .$iif($ascheckini,AwaySystem Log&Viewer):awaysystemlog
  .-
  .&Help!
  ..$iif($exists($scriptdirashelp.msg),Help &Window, [Help not available]):awaysystemhelp
  ..-
  ..MmIRCS Web&site...:run $assite
  ..&Email MmIRCS...:run mailto:MmIRCS@bryansdomain.virtualave.net?subject= $+ $asversion
  ..S&ubmit a Bug...:run $assite $+ bugsubmit.html
  ..-
..About AwaySyste&m:asecho $asversion by mudpuddle: March 14, 2000 -12 $assite }
