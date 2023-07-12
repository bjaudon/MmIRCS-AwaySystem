;AwaySystem 3.02 by mudpuddle - September 21, 2000
;http://www.geocities.com/mmircs/
;MmIRCS@bryansdomain.virtualave.net

;WARNING: It is suggested to use Notepad or any standard text editor to modify this script. 
;The mIRC Editor is designed to only display scripts under 30,000 bytes.. You should click
;CANCEL NOW to avoid cutting off the end of this script!!!


on *:LOAD:{ 
  if ($version >= 5.71) {
if ($asdiagver) { asecho Previous AwaySystem dialog script found, unloading... | unload -rs $shortfn($isalias(asdiagver).fname) }
if ($isalias(asimportwiz)) { asecho AwaySystem Theme Import Wizard found, unloading... | unload -rs $shortfn($isalias(asimportwiz).fname) }
    asecho $asversion by mudpuddle loaded sucessfully
    doimportthing
    .timer -m 1 500 awaysys.config 
  }
  else { asincompaterror }
}
on *:START:{ 
  if ($version >= 5.71) {
    if ($ascheckini == $false) { asresetdefault }
    unset %asqaway %asawaylognum %asawaypagernum
    if ($asrini(awaysysver) < $asver) { doimportthing }
    if (%asawaymode != Back) { assetback }
  }
  else { asincompaterror }
}
on *:CONNECT:{ 
  if (Away isin %asawaymode) {
    asecho Setting to Online %asawaymode Mode: (04 $+ %asawaymsg $+ )
    away %asawaymsg
    %asconnect.status = 1
    if ($asrini(awaysystem.log) == 1) { writeaslog  $+ $colour(action) $+ *** Set to Online %asawaymode Mode (Connected to IRC) @ $astimestamp (04 $+ %asawaymsg $+  $+ $colour(action) $+ ) }
    doastimer
  }  
  elseif ($asrini(idleaway)) { beginasidlechck | asecho AwayIdle checker started } 
}
on *:DISCONNECT:{ 
  if (%asawaymode == IdleAway) { .timer -m 1 50 assetback | .timerIdleAway off }
  unset %asconnect.status 
}
on *:JOIN:#:{ 
  if (%asconnect.status) && ($nick == $me) { assetaway.disp | unset %asconnect.status }
  else { if ($asrini(joinannounce)) && ($nick != $me) && (Away isin %asawaymode) { 
.notice $nick $me is Away from IRC ( $+ %asawaymsg $+ ) at %asawayclock $+ .
if ($awaypager) { .notice $nick If my presence is urgent please type 4/ctcp $me PAGE <message> and I'll get back to you as soon as possible. } } }
}
alias backmode {
  if (%asawaymode == Back) { asecho You're already in Back Mode }
  else { assetback }
}
alias awaymode {
  if (Away isin %asawaymode) { asecho You're already in Away Mode }
  else {
    if ($1 == $null) { asecho Usage: /awaymode [-sp] <message/preset> | return }
    else {
     if (-p == $1) || (-s == $1) || (-sp == $1) || (-ps == $1) {
      if ($1 == -s) { 
        if ($2) { set %asawaymsg $left($2-,100) }
        else { set %asawaymsg Away }
        set %asawaymode StealthAway
      }
      else {
        if (p isin $1) {
          if ($2 == $null) {
            var %presets = 1
            var %totalpresets $ini(awaysys.ini,Presets,0)
            asecho $iif(%totalpresets,Listing presets...,There are no presets to list.) 
            while (%presets <= %totalpresets) {
              var %presetnick = $readini -n awaysys.ini PresetNicks $ini(awaysys.ini,Presets,%presets)
              echo -a 04 %presets $+ . $replace($ini(awaysys.ini,Presets,%presets),±,$chr(32)) $+ : $ascolorget($asprini(%presets)) $iif(%presetnick,-- 12AwayNick:) %presetnick
              inc %presets
            }
            linesep
            return
          }
          if ($asprini($2) == $null) || ($2 !isnum)  { asecho Preset does not exist or is invalid! | return }
          set %asawaymsg $ascolorget($asprini($2))
          set %asawaymode $iif(s isin $1,Stealth) $+ Away
        }
       }
       }
        else {
          set %asawaymsg $left($1-,100)
          set %asawaymode Away
        }
      }
      awaystatus.set
      writeawaymsg %asawaymsg
      if ($asrini(awaynick)) { aswini oldnick2 $asrini(awaynick) }
      var %presetnick = $readini -n awaysys.ini PresetNicks $ini(awaysys.ini,Presets,$2)
      if (%presetnick) { aswini awaynick $replace(%presetnick,@me,$me) }
      assetaway
      if ($server == $null) { asecho Setting to Offline %asawaymode mode (4 $+ %asawaymsg $+ ) - AwayPager: $awaypager $+ , AwayLog: $awaylogging $+ . You will be set to Online %asawaymode when you reconnect. }
    }
  }
alias -l awaypager { if ($asrini(awaypager)) { return on }
else { return off } }
alias -l awaylogging { if ($asrini(awaylogging)) { return on }
else { return off } }
alias -l awaynotices { if ($asrini(awaynotices)) { return on }
else { return off } }
alias -l ascheckini { 
  if ($exists(awaysys.ini)) && (%asawaymode) { return $true }
  else { return $false }
}
alias -l asecho { echo $colour(info) -ae *** AwaySystem - $1- }
alias -l asrini { return $readini -n awaysys.ini AwaySystem $1- }
alias -l aswini { writeini -n awaysys.ini AwaySystem $1- | flushini awaysys.ini }
alias -l asrmini { remini awaysys.ini AwaySystem $1- }
alias -l assite { return http://www.geocities.com/mmircs/ }
alias -l ascalc.dev { return $calc($1 / 60) }
alias -l beginasidlechck { if ($asrini(idleaway)) && ($server) { resetidle | .timerIdleAway 0 10 ascheckidle } }
alias -l ascheckidle {  if (%asawaymode == Back) { if ($idle > $asrini(idleaway)) { .timeridleaway off | asidleawaybox } } }
alias -l asidleawaybox { if ($asrini(disableidledlg)) { asdoidleaway }
else { set %astimeremaining 10 | .timerascountdown 10 1 showastime | dialog -m asidleaway asidleaway } }
alias -l showastime {
  dec %astimeremaining
  if (%astimeremaining == 0) { dialog -x asidleaway | unset %astimeremaining | asdoidleaway | return }
  did -a asidleaway 3 AwaySystem will enter IdleAway mode in %astimeremaining seconds
}
alias -l asdoidleaway { %asawaymsg = Auto IdleAway after $ascalc.dev($asrini(idleaway)) minute(s) | awaystatus.set | if ($asrini(awaynick)) { aswini oldnick2 $asrini(awaynick) } | set %asawaymode IdleAway | assetaway }
alias -l assetaway.disp { if ($chan(0) > 0) && (%asawaymode != StealthAway) && ($server) { $asgetawaymsg } }
alias -l assetback.disp { if ($chan(0) > 0) && (%asawaymode != StealthAway) && ($server) { $asgetbackmsg } }
alias -l assetaway { 
  .timerIdleAway off
  if ($asrini(awaysystem.log) == 1) { writeaslog  $+ $colour(action) $+ *** Set to %asawaymode Mode @ $astimestamp (4 $+ %asawaymsg $+  $+ $colour(action) $+ ) }
  %asawaytime = $ctime
  if ($server) { away %asawaymsg }
  %asawayclock = $time(h:nn:ss tt)
  assetaway.disp
  if (%asawaymode != StealthAway) && ($asrini(awaynick)) { %asoldnick = $me | nick $asnickini }
  doastimer
  if (%asawaymode == StealthAway) && ($server) { asecho Setting to StealthAway Mode (04 $+ %asawaymsg $+ ) AwayPager: $awaypager $+ , AwayLog: $awaylogging }
  if ($asrini(savetbar)) && ($titlebar) && ($asrini(awaytbar)) { aswini savedawaytbar $titlebar }
  if ($timer(Tbar) == $null) && ($asrini(awaytbar)) { .timerTbar -o 0 1 tbar }
  tbar
  asdodeop
  if ($dialog(asconf)) { did -a asconf 304 You have entered Away Mode, some options won't be saved | did -b asconf 9,10,14,15,16,17,18,19,36,37,38,39,52,53,46,47,11,48,49,84,54,55,50,51 }
}
alias -l assetback { 
  %asawayback = $ctime
  if ($server == $null) || (%asawaymode == StealthAway) { asecho Setting to Back Mode - Gone for $awayduration }   
  if (%asoldnick) && (%asawaymode != StealthAway) { nick %asoldnick }
  if ($timer(Away)) { .timerAway off }
  if ($server) { away | assetback.disp }
  set %asawaymode Back
  awaystatus.compare
  if ($asrini(awaysystem.log) == 1) { writeaslog  $+ $colour(action) $+ *** Set to Back Mode @ $astimestamp | writeaslog - }
  if ($asrini(asidno) == $null) || ($server == $null) { unset %asoldnick }
  if ($asrini(idleaway)) { beginasidlechck }
  tbar
  unset %asawaypager.status %asawaylogging.status %asawaynotices.status %asawaymsg %asawaytime %asawayclock %asnicks* %asawayback
  resetidle
  if ($dialog(asconf)) { did -a asconf 304 You have returned to Back Mode. Reopen this dialog to enable options }
}
alias -l astimestamp { return $time(HH:nn:ss) $date(mm/dd/yyyy) }
alias -l asreset.confirm { 
  if ($?!="Reset ALL options to their default values?") { 
    dialog -x asconf
    if (Away isin %asawaymode) { assetback } 
  asresetdefault | .timer 1 0 awaysyserror AwaySystem Preferences have be reset. } 
}
alias -l clearawaysystemlog { 
  if ($?!="Clear AwaySystem Logs?") { 
    if ($exists($shortfn($asrini(awaysystemlog.log)))) { .remove $shortfn($asrini(awaysystemlog.log)) }
    if ($window(@AwaySystem)) { window -c @AwaySystem }
    .timer 1 0 awaysyserror AwaySystem Logfile have been cleared.
    updaslogsize
  }
  showasprefs
}
alias -l awaysystemlog {
  if ($exists($shortfn($asrini(awaysystemlog.log)))) {   
    if ($window(@AwaySystem)) { window -a @AwaySystem }
    else { window -hadk0 +tnsx @AwaySystem 90 90 }  
    clear @AwaySystem
    titlebar @AwaySystem LogViewer - $asrini(awaysystemlog.log)
    loadbuf -p @AwaySystem $shortfn($asrini(awaysystemlog.log))
    sline -a @AwaySystem 31
  }
  else { .timer 1 0 awaysyserror The AwaySystem Logfile is empty. }
}
alias -l asredoawaymsg {
  if ($1) {
    if ($timer(Away)) { .timerAway off }
    %asawaymsg = $1-
    if ($server) { away %asawaymsg }
    if (%asawaymode == IdleAway) { set %asawaymode Away }
    assetaway.disp
    if (%asawaymode == StealthAway) || ($server == $null) { asecho Changed %asawaymode message (04 $+ %asawaymsg $+ ) }
    tbar
    doastimer
    if ($asrini(awaysystem.log)) { writeaslog  $+ $colour(action) $+ *** Changed %asawaymode Message (04 $+ %asawaymsg $+  $+ $colour(action) $+ ) @ $astimestamp }
    if ($dialog(asconf)) { did -a asconf 304 You have changed your away message }
  }
}
alias -l showasprefs { if ($dialog(asconf)) { dialog -v asconf } }
alias -l loadawaymsg {
  if ($asrini(disableawaymsg) != 1) {
    var %msgnum = 1
    var %totalmsg = $ini(awaysys.ini,Awaymsgs,0)
    while (%msgnum <= %totalmsg) {
      did -a $1 1 $ascolorget($asreadmsg(%msgnum))
      inc %msgnum
    }
  }
}
alias -l asgetcomment {
  if ($did(asconf,47).sel == 1) { var %asmsg = Classic AwaySystem theme by mudpuddle }
  else { if ($astrini($calc($did(asconf,47).sel - 1),comment)) { var %asmsg = $ifmatch } }
  did -a $dname 304 %asmsg
}
alias -l aslogfolder {
  var %tempsdir = $$sdir="Select Folder for the AwaySystem Log file"  $iif($asrini(awaysystemlog.log), $nofile($shortfn($asrini(awaysystemlog.log))), $logdir)
  if (%tempsdir == $did(asconf,25)) { showasprefs }
  else { did -ra asconf 25 %tempsdir | showasprefs }
}
alias -l aspagersndselect { did -a asconf 30 $dir="AwayPager Sound" *.wav
  if ($did(asconf,30) == $null) { did -a asconf 30 No Sound }
  showasprefs
}
alias -l updaslogsize { if ($dialog(asconf)) { did -a asconf 306 Logfile Size: $round($calc($file($asrini(awaysystemlog.log)).size / 1024),2) KB } }
alias -l aslogsndselect { did -a asconf 33 $dir="AwayLog Sound" *.wav
  if ($did(asconf,33) == $null) { did -a asconf 33 No Sound }
  showasprefs
}
alias -l awaystatus.set {
  %asawaypager.status = $awaypager
  %asawaylogging.status = $awaylogging
  %asawaynotices.status = $awaynotices
}
alias -l asshowdefaway { return is away (12Reason:04 @awaymsg) since @awaytime. AwayPager is @awaypager, AwayLog is @awaylog }
alias -l asshowdefback { return is back (12Back from:04 @awaymsg) Gone for @awayduration }
alias -l awaysyshlp { winhelp $shortfn($scriptdirawaysys.hlp) $asgethelptopic($1-) }
alias -l asgethelptopic { 
if ($1 == $null) { return }
if ($1 == 400) { return Preferences, Main Preferences Tab }
if ($1 == 401) { return Preferences, Sounds & AwayNick Tab }
if ($1 == 402) { return Preferences, Themes Tab }
if ($1 == 403) { return Preferences, Presets Tab }
if ($1 == 404) { return Preferences, Miscellaneous Tab }
else { return $1- }
}
alias -l asloadthemes {
  if ($exists(awaysysthemes.ini)) {
    var %themes = 1
    var %totalthemes $ini(awaysysthemes.ini,0)
    while (%themes <= %totalthemes) {
      did -a asconf 47 $replace($ini(awaysysthemes.ini,%themes),±,$chr(32))
      inc %themes
    }
  }
  did -c asconf 47 $asrini(selectedtheme) 
  if ($asrini(selectedtheme) != 1) {
    did -am asconf 55 $replace($ini(awaysysthemes.ini,$calc($asrini(selectedtheme) - 1)),±,$chr(32))
    did -a asconf 51 $astrini($calc($asrini(selectedtheme) - 1),awaymsg))
    did -a asconf 53 $astrini($calc($asrini(selectedtheme) - 1),backmsg)
    if ($astrini($calc($asrini(selectedtheme) - 1),cmd)) { did -c asconf 84 }
    if ($astrini($calc($asrini(selectedtheme) - 1),cmd) == 0) { did -u asconf 84 }
  }
}
alias -l asgetawaymsg {
  if ($themesini($calc($asrini(selectedtheme) - 1)) == $null) { aswini selectedtheme 1 }
  if ($asrini(selectedtheme) > 1) { 
    var %ascommand = $iif($astrini($calc($asrini(selectedtheme) -1),cmd),ame,amsg)
    var %asmessage = %ascommand $replace($astrini($calc($asrini(selectedtheme) - 1),awaymsg),@awaymsg,$+ $awaymsg $+,@awaytime,$+ $asawayclock $+,@awaypager,$+ $awaypager $+,@awaylog,$+ $awaylogging $+))
    return %asmessage
  }
  else { return ame is away (12Reason:04 %asawaymsg $+ ) since %asawayclock $+ . AwayPager is $awaypager $+ , AwayLog is $awaylogging }
}
alias -l asgetbackmsg {
  if $themesini($calc($asrini(selectedtheme) - 1)) == $null) { aswini selectedtheme 1 }
  if ($asrini(selectedtheme) > 1) {
    var %ascommand = $iif($astrini($calc($asrini(selectedtheme) - 1),cmd),ame,amsg)
    var %asmessage = %ascommand $replace($astrini($calc($asrini(selectedtheme) - 1),backmsg),@awaymsg,$+ $awaymsg $+,@awaytime,$+ $asawayclock $+,@awayduration,$+ $awayduration $+))
    return %asmessage
  }
  else { return ame is back (12Back from:04 %asawaymsg $+ ) Gone for $awayduration }
}
alias -l themesini { 
  if ($exists(awaysysthemes.ini)) {
    return $ini(awaysysthemes.ini,$1)
  }
}
alias -l astrini { 
  var %readini $readini -n awaysysthemes.ini $themesini($1) $2-
  return $ascolorget(%readini)
}
alias -l aschkline {
  var %readline = $read -l1 awaysysthemes.ini
  var %validline = ;#!AS3Theme
  if (%readline != %validline) { write -il1 awaysysthemes.ini %validline }
}
alias -l ascolorput { return $replace($1-,$chr(3),$chr(152),$chr(2),$chr(176),$chr(31),$chr(175),$chr(22),$chr(247)) }
alias -l ascolorget { return $replace($1-,$chr(152),$chr(3),$chr(176),$chr(2),$chr(175),$chr(31),$chr(247),$chr(22)) }
alias -l astwini { aschkline | writeini -n awaysysthemes.ini $themesini($1) $ascolorput($2-) }
alias -l astwini2 { aschkline | writeini -n awaysysthemes.ini $1 $ascolorput($2-) }
alias -l astrmini { remini awaysysthemes.ini $themesini($1-) }
alias -l awaysys.config { 
  if ($dialog(asconf) == $null) { dialog -m asconf asconf }
  else { showasprefs }
}
alias -l asgoaway { $dialog(asawaydiag,asawaydiag) }
alias -l asdoeditboxchk {
  if ($len($did(1)) < 100) { did -a $dname 4 $len($did(1)) }
  if ($len($did(1)) == 100) { did -a $dname 4 Max }
  if ($len($did(1)) > 100) { did -a $dname 4 Over | beep 1 }
}
alias -l asversion { return AwaySystem version $asver }
alias asver { return 3.02.2439 }
alias -l asrandomawaysel {
  did -a asconf 69 $file="Choose RandomAway file" *.txt | did -a asconf 70 &Open
  if ($did(asconf,69) == $null) { did -a asconf 69 Disable RandomAway | did -a asconf 70 &New }
  showasprefs
}
alias -l awaysyserror { 
  if ($asrini(disableerrordialog) != 1) { set %awaysyserror $1- | beep 1 | $dialog(awaysyserror,awaysyserror,-4) }
  else { asecho $1- }
}
alias -l clearawaysysnicks {
  if ($?!="This clears stored Away Nicks & messages. $crlf Do you wish to Continue?") { remini awaysys.ini Awaynicks | remini awaysys.ini Awaymsgs | var %awaynick = $did(asconf,37) | did -rac asconf 37 %awaynick | .timer 1 0 awaysyserror All AwayNicks && Away Messages have cleared. }
  showasprefs
}
alias -l awaysysabout { $dialog(asabout,asabout,-4) }
alias -l asreadmsg { return $readini -n awaysys.ini Awaymsgs $1- }
alias -l doasprefinit {
  if ($themesini($calc($asrini(selectedtheme) - 1)) == $null) { aswini selectedtheme 1 }
  if ($exists(awaysysthemes.ini) == $false) && ($asrini(selectedtheme) != 1) { aswini selectedtheme 1 }
  updaslogsize 
  did -am $dname 25 $nofile($asrini(awaysystemlog.log))
  if ($asrini(disableversionreply)) { did -c $dname 73 }
  if ($asrini(disableerrordialog)) { did -c $dname 74 }
  if ($asrini(disablelasttab)) { did -c $dname 75 | aswini lastviewedtab 400 }
  if ($asrini(disableawaynick)) { did -c $dname 76 }
  if ($asrini(disableidledlg)) { did -c $dname 87 }
  if ($asrini(disableawaymsg)) { did -c $dname 85 }
  if (Away !isin %asawaymode) {
    if ($asrini(awaypager)) { did -c $dname 2 }
    if ($asrini(awaylogging)) { did -c $dname 6 }
    if ($asrini(awaypager) != 1) { did -b $dname 3,4 }
    if ($asrini(awaylogging) != 1) { did -b $dname 7,8,9,10,86 }
    if ($asrini(awaynotices)) { did -c $dname 7 }
    if ($asrini(awaynick)) { did -c $dname 36 | did -ace $dname 37 $asrini(awaynick) }
  }
  if ($asrini(selectedtheme) == 1) {
    did -ra $dname 55 AwaySystem Classic
    did -ra $dname 51 $asshowdefaway
    did -ra $dname 53 $asshowdefback
    did -c asconf 84 | did -m $dname 55,51,53 | did -b $dname 48,49,84
  }
  did -a $dname 77 Current Theme: $asgetthemename
  did -a $dname 47 AwaySystem Classic
  asloadthemes
  loadasnicks $dname 37
  if ($asrini(awaydeop)) { did -c $dname 91 }
  if ($asrini(awayactions)) { did -c $dname 8 }
  if ($asrini(ctcppage)) { did -c $dname 3 }
  if ($asrini(ctcpreply)) { did -c $dname 4 }
  if ($asrini(notify)) { did -c $dname 9 }
  if ($asrini(notify) == 0) { did -b $dname 10 }
  if ($asrini(awaytbar)) { did -c $dname 16 }
  if ($asrini(awaytbar) != 1) { did -b $dname 17 }
  if ($asrini(savetbar)) { did -c $dname 17 }
  if ($asrini(asinputback)) { did -c $dname 20 }
  if ($asrini(awaysystem.log)) { did -c $dname 22 }
  if ($asrini(closemsg)) { did -c $dname 86 }
  if ($asrini(asidno)) { did -c $dname 40 | did -a $dname 41 $asrini(asidno) }
  if ($asrini(asidno) == $null) { did -b $dname 41 }
  if ($asrini(asquietid)) { did -c $dname 42 }
  if ($asrini(awaynick) == $null) { did -bac $dname 37 $asrini(oldnick1) }
  if ($lock(run)) { did -b $dname 70 }
  if ($asrini(sendnotices)) { did -c $dname 10 }
  if ($asrini(joinannounce)) { did -c $dname 93 }
  did -c $dname 15 $getdroptime($asrini(awaytimer))
  did -c $dname 19 $getdroptime($asrini(idleaway))
  if ($asrini(awaypager.snd)) { did -a $dname 30 $asrini(awaypager.snd) }
  if ($asrini(awaylog.snd)) { did -a $dname 33 $asrini(awaylog.snd) }
  var %presets = 1
  var %totalpresets $ini(awaysys.ini,Presets,0)
  while (%presets <= %totalpresets) {
    did -a $dname 59 $replace($ini(awaysys.ini,Presets,%presets),±,$chr(32))
    inc %presets
  }
  did -c $dname 59 1
  did -ra $dname 83 $replace($ini(awaysys.ini,Presets,$did(59).sel),±,$chr(32))
  did -a $dname 96 $readini -n awaysys.ini PresetNicks $replace($did(83),$chr(32),±)
  if ($did(59).sel) { did -m $dname 83 | did -ra $dname 63 $ascolorget($asprini($did(59).sel)) }
  if ($asrini(randomaway)) { did -a $dname 69 $asrini(randomaway) }
  if ($asrini(randomaway) != Disable RandomAway) && ($asrini(randomaway)) { did -a $dname 70 &Open }
  if (Away isin %asawaymode) { 
    did -a $dname 304 Away Mode status - Some options won't be saved
    did -bm $dname 9,10,14,15,16,17,18,19,37,38,39,52,53,46,47,11,48,49,84,54,55,50,51
    if (%asawaypager.status == on) { did -c $dname 2 }
    if (%asawaypager.status == off) { did -b $dname 3,4 }    
    if (%asawaylogging.status == on) { did -c $dname 6 }
    if (%asawaylogging.status = off) { did -b $dname 7,8,9,86 }
    if (%asawaynotices.status == on) { did -c $dname 7 }
    if ($asrini(oldnick2)) { did -cb $dname 36 | did -abc $dname 37 $asrini(oldnick2) }
    else { did -abc $dname 37 $asrini(oldnick1) | did -b $dname 36 }
  }
}
alias -l getdroptime {
  if ($1 == 60) { return 1 }
  if ($1 == 120) { return 2 }
  if ($1 == 180) { return 3 }
  if ($1 == 300) { return 4 }
  if ($1 == 600) { return 5 }
  if ($1 == 900) { return 6 }
  if ($1 == 1200) { return 7 }
  if ($1 == 1500) { return 8 }
  if ($1 == 1800) { return 9 }
  if ($1 == 2700) { return 10 }
  if ($1 == 3600) { return 11 }
  if ($1 == 7200) { return 12 }
  if ($1 == 10800) { return 13 }
  if ($1 == 14400) { return 14 }
  if ($1 == 18000) { return 15 }
  if ($1 == 21600) { return 16 }
  if ($1 == 0) { return 17 }
  else { return 0 }
}
alias -l asdroptime {
  if ($1 == 1) { return 60 }
  if ($1 == 2) { return 120 }
  if ($1 == 3) { return 180 }
  if ($1 == 4) { return 300 }
  if ($1 == 5) { return 600 }
  if ($1 == 6) { return 900 }
  if ($1 == 7) { return 1200 }
  if ($1 == 8) { return 1500 }
  if ($1 == 9) { return 1800 }
  if ($1 == 10) { return 2700 }
  if ($1 == 11) { return 3600 }
  if ($1 == 12) { return 7200 }
  if ($1 == 13) { return 10800 }
  if ($1 == 14) { return 14400 }
  if ($1 == 15) { return 18000 }
  if ($1 == 16) { return 21600 }
  if ($1 == 17) { return 0 }
  else { return 900 }
}
alias -l asgetthemename {
  if ($exists(awaysysthemes.ini) && $asrini(selectedtheme) > 1) { return $replace($themesini($calc($asrini(selectedtheme) - 1)),±,$chr(32)) }
  else { return AwaySystem Classic }
}
alias -l asprini { return $readini -n awaysys.ini Presets $ini(awaysys.ini,Presets,$1-) }
alias -l aspwini { writeini -n awaysys.ini Presets $ini(awaysys.ini,Presets,$1) $ascolorput($2-) }
alias -l asprmini { remini awaysys.ini Presets $ini(awaysys.ini,Presets,$1-) }
alias -l asreadnick { return $readini -n awaysys.ini Awaynicks $1- }
alias -l writenicks { 
  if ($asrini(disableawaynick) != 1) {
    var %totalnicks = $ini(awaysys.ini,Awaynicks,0)
    var %nicknum = 1
    while (%nicknum <= $calc(%totalnicks + 1)) {
      if ($asreadnick(%nicknum) == $1) { break }
      if ($asreadnick(%nicknum) == $null) { writeini -n awaysys.ini Awaynicks $calc($ini(awaysys.ini,Awaynicks,0) + 1) $1 | break }
      inc %nicknum
    }
  }
}
alias -l loadasnicks {
  if ($asrini(disableawaynick) != 1) {
    var %nicknum = 1
    var %totalnicks = $ini(awaysys.ini,Awaynicks,0)
    while (%nicknum <= %totalnicks) {
      if ($dialog(asconf)) && ($did(asconf,37) == $asreadnick(%nicknum)) { goto jump }
      if ($dialog(asawaydiag)) && ($did(asawaydiag,105) == $asreadnick(%nicknum)) { goto jump }
      did -a $1 $2 $asreadnick(%nicknum)
      :jump
      inc %nicknum
    }
  }
}
alias -l asuninstall { $dialog(asuwiz,asuwiz) }
alias -l asresetdefault { asrmini | set %asawaymode Back | aswini awaypager 1 | aswini awaylogging 1 | aswini awaynotices 1 | aswini awaysystemlog.log $logdir $+ awaysys.log | aswini closemsg 1 | aswini notify 1 | aswini awaytbar 1 | aswini ctcppage 1
  aswini ctcpreply 1 | aswini awayactions 1 | aswini savetbar 1 | aswini sendnotices 1 | aswini awaytimer 2700 | aswini idleaway 0 | aswini randomaway Disable RandomAway | aswini selectedtheme 1 | asverno | unset %asqaway %asnicks*
}
alias -l doimportthing { if ($exists(awaysys.ini)) { 
    if ($?!="Existing AwaySystem settings found. Import settings?") { asimport }
    else { asresetdefault }
  }
}
alias -l asdodeop {
  if ($asrini(awaydeop)) {
    var %channum = 1
    var %totalchans = $chan(0)
    while (%channum <= %totalchans) {
      if ($me isop $chan(%channum)) { mode $chan(%channum) -o $me }
      inc %channum
    }
  }
}
alias -l awaymsg { return %asawaymsg }
alias -l asawayclock { return %asawayclock }
alias -l awayduration { return $duration($calc(%asawayback - %asawaytime)) }
alias -l asnickini { return $replace($asrini(awaynick),@me,$me) }
alias -l asverno { aswini awaysysver $asver }
alias -l asincompaterror { asecho Error! $asversion requires mIRC 5.71 or later. You can download a new version from http://www.mirc.com/get.html | unload -rs $nopath($script) }
alias -l writeaslog {
  if ($asrini(awaysystemlog.log)) { write " $+ $asrini(awaysystemlog.log) $+ " $1- | updateaslogwindow }
  else { .timer 1 0 awaysyserror Log folder became unset and has been disabled. | aswini awaysystem.log 0 | aswini awaysystemlog.log $logdirawaysys.log }
}
alias -l playaslogsnd { 
  if ($asrini(awaylog.snd) == Default Beep) { beep }
  else { if ($isfile($asrini(awaylog.snd))) { splay $shortfn($asrini(awaylog.snd)) } }
}
alias -l playaspagesnd {
  if ($asrini(awaypager.snd) == Default Beep) { beep }
  else { if ($isfile($asrini(awaypager.snd))) { splay $shortfn($asrini(awaypager.snd)) } }
}

alias -l asprefok {
  if (Away !isin %asawaymode) {
    if ($did(36).state == 0) && ($asrini(awaynick)) { aswini oldnick1 $asrini(awaynick) | asrmini awaynick }
    if ($did(36).state) && ($did(37)) { aswini awaynick $strip($did(37)) }
    aswini awaypager $did(2).state
    aswini awaylogging $did(6).state
    aswini awaynotices $did(7).state
    aswini notify $did(9).state
    aswini sendnotices $did(10).state
    aswini awaytimer $asdroptime($did(15).sel)
    aswini idleaway $asdroptime($did(19).sel)
    writenicks $strip($did(37))
    if ($did(47).sel) { aswini selectedtheme $did(47).sel }
    if ($timer(IdleAway) == $null) && ($asrini(idleaway) > 0) { beginasidlechck }
    if ($did(19).sel == 17) { .timeridleaway off }
    if ($did(47).sel != 1) && ($did(47).sel) && ($did(55) == $did(47,$did(47).sel)) { astwini $calc($did(47).sel - 1) awaymsg $did(51) | astwini $calc($did(47).sel - 1) backmsg $did(53) | astwini $calc($did(47).sel - 1) cmd $did(84).state }
  }
  if (Away isin %asawaymode) {
    if ($did(2).state == 0) { %asawaypager.status = off }
    if ($did(2).state) { %asawaypager.status = on }
    if ($did(6).state == 0) { %asawaylogging.status = off }
    if ($did(6).state) { %asawaylogging.status = on }
    if ($did(7).state) { %asawaynotices.status = on }
    if ($did(7).state == 0) { %asawaynotices.status = off }
  }
  aswini awaydeop $did(91).state
  if ($did(59).sel) && ($did(83) == $did(59,$did(59).sel)) { aspwini $did(59).sel $did(63) }
  aswini ctcppage $did(3).state
  aswini ctcpreply $did(4).state
  aswini awayactions $did(8).state
  aswini awaytbar $did(16).state
  aswini savetbar $did(17).state
  aswini asinputback $did(20).state
  aswini awaysystem.log $did(22).state
  if ($did(30) != No Sound) { aswini awaypager.snd $did(30) }
  if ($did(30) == No Sound) { asrmini awaypager.snd }
  if ($did(33) != No Sound) { aswini awaylog.snd $did(33) }
  if ($did(33) == No Sound) { asrmini awaylog.snd }
  if ($did(40).state) && ($did(41)) { aswini asidno $strip($did(41)) }
  if ($did(40).state == 0) { asrmini asidno }
  aswini asquietid $did(42).state
  if ($did(73).state) { aswini disableversionreply 1 }
  if ($did(73).state == 0) { asrmini disableversionreply }
  if ($did(74).state) { aswini disableerrordialog 1 }
  if ($did(74).state == 0) { asrmini disableerrordialog }
  if ($did(75).state) { aswini disablelasttab 1 }
  if ($did(75).state == 0) { asrmini disablelasttab }
  if ($did(76).state) { aswini disableawaynick 1 }
  if ($did(76).state == 0) { asrmini disableawaynick }
  if ($did(85).state) { aswini disableawaymsg 1 }
  if ($did(85).state == 0) { asrmini disableawaymsg }
  aswini closemsg $did(86).state
  if ($did(87).state) { aswini disableidledlg 1 }
  if ($did(87).state == 0) { asrmini disableidledlg }
  aswini joinannounce $did(93).state
  aswini randomaway $did(69)
  aswini awaysystemlog.log $did(25) $+ awaysys.log
}
alias -l ascombo {
  did -a $dname 15,19 After 1 Minute
  did -a $dname 15,19 After 2 Minutes
  did -a $dname 15,19 After 3 Minutes
  did -a $dname 15,19 After 5 Minutes
  did -a $dname 15,19 After 10 Minutes
  did -a $dname 15,19 After 15 Minutes
  did -a $dname 15,19 After 20 Minutes
  did -a $dname 15,19 After 25 Minutes
  did -a $dname 15,19 After 30 Minutes
  did -a $dname 15,19 After 45 Minutes
  did -a $dname 15,19 After 1 Hour
  did -a $dname 15,19 After 2 Hours
  did -a $dname 15,19 After 3 Hours
  did -a $dname 15,19 After 4 Hours
  did -a $dname 15,19 After 5 Hours
  did -a $dname 15,19 After 6 Hours
  did -ac $dname 15,19 Never
}
alias -l asimport {
  set %asawaymode Back
  aswini awaysysver $asver
  if ($asrini(selectedtheme) == $null) { aswini selectedtheme 1 }
  if ($asrini(awaypager) == $null) { aswini awaypager 1 }
  if ($asrini(awaylogging) == $null) { aswini awaylogging 1 }
  if ($asrini(awaynotices) == $null) { aswini awaynotices 1 }
  if ($asrini(asinputback) == $null) { aswini asinputback 0 }
  if ($asrini(asnickpword)) { aswini asidno $asrini(asnickpword) | asrmini asnickpword }
}
alias -l writeawaymsg { 
  if ($asrini(disableawaymsg) != 1) {
    var %totalmsg = $ini(awaysys.ini,Awaymsgs,0)
    var %msgnum = 1
    while (%msgnum <= $calc(%totalmsg + 1)) {
      if ($ascolorget($asreadmsg(%msgnum)) == $1-) { break }
      if ($asreadmsg(%msgnum) == $null) { writeini -n awaysys.ini Awaymsgs $calc($ini(awaysys.ini,Awaymsgs,0) + 1) $ascolorput($1-) | break }
      inc %msgnum
    }
  }
}
alias -l asthemedel {
  if ($?!="Are you sure you want to delete this theme?") {
    astrmini $calc($did(asconf,47).sel - 1) | did -d asconf 47 $did(asconf,47).sel 
    aswini selectedtheme 1
    did -c asconf 47 1
    did -ra asconf 55 AwaySystem Classic
    did -ra asconf 51 $asshowdefaway
    did -ra asconf 53 $asshowdefback
    did -c asconf 84 | did -m asconf 55,51,53 | did -b asconf 48,49,84
    did -a asconf 77 Current Theme: $asgetthemename
    did -a asconf 304
  }
  dialog -v asconf
}
alias -l ashilite $dialog(ashilite,ashilite,-4)
alias -l aswarnchans { if ($?!="WARNING: This feature may be prohibited in some channels, as it falls into the category of Autogreets. Please check with ChanOPS in ALL the channels you're in before enabling this feature. Failure to do so may get you BANNED from the channel(s). $crlf $crlf Do you wish to enable this feature?") { did -c asconf 93 } }
alias -l doastimer { if ($asrini(awaytimer)) && (%asawaymode != StealthAway) && ($server) { .timerAway 0 $asrini(awaytimer) assetaway.disp } }
alias -l tbar { 
  if ($asrini(awaytbar)) {
    if (Away isin %asawaymode) {
      if (%asawaymode != Back) { titlebar - $iif($server,Online,Offline) %asawaymode Mode ( $+ %asawaymsg $+ ) for $duration($calc($ctime - %asawaytime)) - AwayPager $awaypager $+ , AwayLog $iif($awaynotices == on,& NoticeLog) $awaylogging }
    }
    else {
      if ($asrini(savedawaytbar)) { titlebar $asrini(savedawaytbar) | asrmini savedawaytbar }
      else { titlebar }
      .timerTbar off
    }
  }
}
alias -l updateaslogwindow {
  if ($window(@AwaySystem)) && ($asrini(awaysystemlog.log)) { 
    clear @AwaySystem
    if ($exists($shortfn($asrini(awaysystemlog.log)))) { loadbuf -p @AwaySystem " $+ $asrini(awaysystemlog.log) $+ " }
  }
  updaslogsize
} 
alias -l awaystatus.compare {
  if ($asrini(oldnick2) == $null) { asrmini awaynick }
  if ($asrini(oldnick2)) { aswini awaynick $asrini(oldnick2) | asrmini oldnick2 }
  if (%asawaypager.status == on) { aswini awaypager 1 }
  if (%asawaylogging.status == on) { aswini awaylogging 1 }
  if (%asawaynotices.status == on) { aswini awaynotices 1 }
  if (%asawaypager.status == off) { aswini awaypager 0 }
  if (%asawaylogging.status == off) { aswini awaylogging 0 }
  if (%asawaynotices.status == off) { aswini awaynotices 0 }
  unset %asawaypager.status %asawaylogging.status %asawaynotices.status
}
alias -l asawaynotice {
  if ($asrini(notify)) {
    if ($findtok(%asnicks,$nick,1,59)) { return }
    else {
      if ($asrini(sendnotices)) { %asnicks = $addtok(%asnicks,$nick,59) }
      .notice $nick I'm currently away (Reason: $+ %asawaymsg $+ ) since %asawayclock $+ , your message has been logged
      if ($awaypager == on) { .notice $nick If your message is urgent, you may page me by typing 04/ctcp $me PAGE <yourmessage> }
    }
  }
}
alias asimportwizard { dialog -m asimportwiz asimportwiz }
alias -l asimport1 { dialog -m asimportwiz1 asimportwiz1 }
alias -l asimport2 { dialog -m asimportwiz2 asimportwiz2 }
alias -l asimport3 { dialog -m asimportwiz3 asimportwiz3 }
alias -l asnamechk { if ($dialog(asnamechk)) { dialog -v asnamechk }
  else { dialog -m asnamechk asnamechk }
}
alias -l askasimport { 
  var %whichdialog = $1
  if ($?!="Preferences changes will be lost! Continue?") { dialog -x asconf | .timer 1 0 %whichdialog } 
  else { dialog -v asconf }
}
alias -l choosefile { var %filetemp = $$file="Pick a file to import..." *.ini
if ($exists($shortfn(%filetemp)) == $false) { .timer 1 0 awaysyserror File does not exist! Please choose another. | return }
  var %readline = $read -l1 $shortfn(%filetemp)
  var %validline = ;#!AS3Theme
  dialog -v asimportwiz1
  if ($right(%filetemp,4) != .ini) { .timer 1 0 awaysyserror This file is not a valid .ini file! Please choose another. | return }
  if (%filetemp == $mircdirawaysysthemes.ini) { .timer 1 0 awaysyserror You can't Import your main Theme File over itself! | return }
  if (%readline != %validline) { .timer 1 0 awaysyserror The selected file is not a valid AwaySystem Theme file. | return }
  if ($ini($shortfn(%filetemp),0) == 0) { .timer 1 0 awaysyserror The selected file has no themes to import! | return }
  %asimportchoose = %filetemp | did -a asimportwiz1 8 $iif($len(%asimportchoose) > 65,...) $+ $right(%asimportchoose,65) | did -e asimportwiz1 2,10
}
alias -l assetnames {
  if ($exists(awaysysthemes.ini)) && ($ini($shortfn(%asimportchoose),0) <= 50) {
    unset %asthemes %asimportthemes
    var %themes = 1
    var %totalthemes $ini($shortfn(%asimportchoose),0)
    while (%themes <= %totalthemes) {
      var %asimportthemes = %asimportthemes $ini($shortfn(%asimportchoose),%themes)
      inc %themes
    }
    var %themes1 = 1
    var %totalthemes1 $ini(awaysysthemes.ini,0)
    while (%themes1 <= %totalthemes1) {
      var %astheme = $ini(awaysysthemes.ini,%themes1)
      if (%astheme isin %asimportthemes) { set %asthemes %asthemes $ini(awaysysthemes.ini,%themes1) }
      inc %themes1
    }
  }
  if (%asthemes == $null) { set %asthemesnone 1 }
}
alias -l asgetreplaced {
  if (%asthemesnone) { 
    if ($ini($shortfn(%asimportchoose),0) > 50) { did -a $dname 21 AwaySystem found $ini($shortfn(%asimportchoose),0) themes in your Import file. To prevent mIRC Errors,  | did -a $dname 27 it will skip checking for duplicate themes. However, you can still remove a theme. | did -b $dname 22 | did -a $dname 22 <Skipped duplicate checking - Import contains over 50 themes> | unset %asthemesnone }
    else { did -b $dname 22 | did -a $dname 22 <AwaySystem has determined that no Themes will be replaced by this Import> | unset %asthemesnone }
  }
  else { did -a asimportwizwarn 22 $* }
}
alias -l asimportwizwarn { dialog -m asimportwizwarn asimportwizwarn }
alias -l asimportthemes {
  var %themes = 1
  var %totalthemes $ini($shortfn(%asimportchoose),0)
  while (%themes <= %totalthemes) {
    did -a asimportwiz2 23 Currently Importing the Away Theme: $replace($ini($shortfn(%asimportchoose),%themes),±,$chr(32)) $crlf $crlf %themes of %totalthemes Themes have been imported.
    writeini -n awaysysthemes.ini $ini($shortfn(%asimportchoose),%themes) awaymsg $readini $shortfn(%asimportchoose) $ini($shortfn(%asimportchoose),%themes) awaymsg
    writeini -n awaysysthemes.ini $ini($shortfn(%asimportchoose),%themes) backmsg $readini $shortfn(%asimportchoose) $ini($shortfn(%asimportchoose),%themes) backmsg
    writeini -n awaysysthemes.ini $ini($shortfn(%asimportchoose),%themes) cmd $readini $shortfn(%asimportchoose) $ini($shortfn(%asimportchoose),%themes) cmd
    writeini -n awaysysthemes.ini $ini($shortfn(%asimportchoose),%themes) comment $readini $shortfn(%asimportchoose) $ini($shortfn(%asimportchoose),%themes) comment
    inc %themes
  }
  var %readline = $read -l1 awaysysthemes.ini
  var %validline = ;#!AS3Theme
  if (%readline != %validline) { write -il1 awaysysthemes.ini %validline }
  .timer 1 0 asimport3
}
alias -l asgetnames {
           var %tokens = 1
            var %totaltokens $numtok($asrini(ashilites),59)
            while (%tokens <= %totaltokens) {
              if ($count($remove($1-,$chr(44),$chr(32)),$gettok($asrini(ashilites),%tokens,59))) { return 1 }
              inc %tokens
}
else { return $null }
}
alias -l asknamechkdel { 
  if ($?!="This removes the selected theme from the Import file and can't be undone. $crlf $crlf Continue?") { 
    var %dname = asnamechk
    remini $shortfn(%asimportchoose) $ini($shortfn(%asimportchoose),$did(%dname,5).sel)
    did -c %dname 5 $calc($did(%dname,5).sel - 1) 
  did -d %dname 5 $did(%dname,5).sel }
}
ctcp &*:VERSION:if ($asrini(disableversionreply) != 1) { .ctcpreply $nick VERSION $asversion (September 21, 2000) by mudpuddle:12 $assite }
ctcp *:PAGE:{ if ($asrini(awaypager)) {
    if (Away isin %asawaymode) || ($asrini(ctcppage)) {
      if ($nick != $me) { 
        var %temppage $time(HH:nn:ss) $date(m/d/yyyy)  $+ $colour(CTCP) $+ Page:12 $nick $+ :  $2-
        playaspagesnd
        if ($window(@AwayPager) == $null) { window -ng2 @AwayPager }
        aline -hp @AwayPager %temppage
        if ($asrini(awaysystem.log)) { writeaslog %temppage }
    inc %asawaypagernum
    titlebar @AwayPager - %asawaypagernum pages recorded

        if ($asrini(ctcpreply)) { .ctcpreply $nick PAGE Your page has been logged! }
      }
    }
  } 
}
on *:TEXT:*:?:{
  if (Away isin %asawaymode) && ($nick != $me) && ($asrini(awaylogging)) { 
    var %temppriv $time(HH:nn:ss) $date(m/d/yyyy) PrivMessage: <4 $+ $nick $+ > $1-
    if ($window(@AwayLog) == $null) { window -ng1 @AwayLog }
    if ($asrini(awaylog.snd)) { playaslogsnd }
    if ($asrini(awaysystem.log)) { writeaslog %temppriv }
    aline -hp @AwayLog %temppriv
    if ($asrini(closemsg)) { close -m $nick }
    inc %asawaylognum
    titlebar @AwayLog - %asawaylognum events recorded
    asawaynotice
  }
}
on *:TEXT:*:#:{
  if (Away isin %asawaymode) && ($asrini(awaylogging))  {
    if ($me isin $1-) || ($asgetnames($1-)) { 
      var %tempmsg $time(HH:nn:ss) $date(m/d/yyyy) 13ChanMessage: <3 $+ $chan $+ 12\4 $+ $nick $+ > $1-
      if ($window(@AwayLog) == $null) { window -ng1 @AwayLog }
      if ($asrini(awaylog.snd)) { playaslogsnd }
      if ($asrini(awaysystem.log)) { writeaslog  %tempmsg }    
      aline -hp @AwayLog %tempmsg
    inc %asawaylognum
    titlebar @AwayLog - %asawaylognum events recorded
      asawaynotice
    }
  }
}
on *:ACTION:*:?:{
  if (Away isin %asawaymode) && ($nick != $me) && ($asrini(awaylogging)) && ($asrini(awayactions)) { 
    var %tempprivaction $time(HH:nn:ss) $date(m/d/yyyy) PrivAction: $+ $colour(action) * $nick $1-
    if ($window(@AwayLog) == $null) { window -ng1 @AwayLog }
    if ($asrini(awaylog.snd)) { playaslogsnd }
    if ($asrini(awaysystem.log)) { writeaslog %tempprivaction }
    aline -hp @AwayLog %tempprivaction
    inc %asawaylognum
    titlebar @AwayLog - %asawaylognum events recorded
    if ($asrini(closemsg)) { close -m $nick }
    asawaynotice
  }
}
on *:ACTION:*:#:{
  if (Away isin %asawaymode) && ($asrini(awaylogging)) && ($asrini(awayactions)) { 
    if ($me isin $1-) || ($asgetnames($1-)) {
      var %tempaction $time(HH:nn:ss) $date(m/d/yyyy) 13ChanAction: $+ $colour(action) * $chan $+ 12\ $+ $colour(action) $+ $nick $1-
      if ($window(@AwayLog) == $null) { window -ng1 @AwayLog }
      if ($asrini(awaylog.snd)) { playaslogsnd }
    inc %asawaylognum
    titlebar @AwayLog - %asawaylognum events recorded
      if ($asrini(awaysystem.log)) { writeaslog  %tempaction }    
      aline -hp @AwayLog %tempaction
      asawaynotice
    }
  }
}
on *:NOTICE:*:*:{
  if (Away isin %asawaymode) && ($nick != $me) && ($asrini(awaylogging)) && ($asrini(awaynotices)) { 
    var %tempnotice $astimestamp Notice:  $+ $colour(notice) $+ - $+ $nick $+ - $1-
    if ($window(@AwayLog) == $null) { window -ng1 @AwayLog }
    if ($asrini(awaylog.snd)) { playaslogsnd }
    if ($asrini(awaysystem.log)) { writeaslog %tempnotice }
    inc %asawaylognum
    titlebar @AwayLog - %asawaylognum events recorded
    aline -hp @AwayLog %tempnotice
  }
}
on *:INPUT:#:{ if (Away isin %asawaymode) && ($asrini(asinputback)) { assetback } }
on *:NICK:{
  if ($nick == $me) && ($asrini(asidno)) {
    if ($newnick == %asoldnick) { 
      if ($asrini(asquietid) == 0) { asecho Identifying to NickServ }
    nickserv identify %asoldnick $asrini(asidno) | unset %asoldnick }
  }
}
on *:CLOSE:@:{
if ($target == @AwayLog) { unset %asawaylognum }
else { if ($target == @AwayPager) { unset %asawaypagernum } }
}
dialog ashilite {
  title "AwayLog Triggers"
  size -1 -1 198 210
  combo 1, 5 35 186 140, edit
  text "These entries triggers the AwayLog:", 2, 6 8 180 13, left
  button "&OK", 4, 5 178 55 23, ok
  button "&Add", 5, 65 179 45 20, default
  button "&Delete", 6, 115 179 45 20
}
on *:DIALOG:ashilite:init:0:{ if ($asrini(ashilites)) { 
           var %tokens = 1
            var %totaltokens $numtok($asrini(ashilites),59)
            while (%tokens <= %totaltokens) {
              did -a $dname 1 $gettok($asrini(ashilites),%tokens,59)
              inc %tokens
 }
 }
 }
on *:DIALOG:ashilite:sclick:5:{ if ($findtok($asrini(ashilites),$did(1),59) == $null) && ($did(1)) { aswini ashilites $addtok($asrini(ashilites),$did(1),59) | did -ac $dname 1 $did(1) } }
on *:DIALOG:ashilite:sclick:6:{ 
  if ($did(1).sel) { 
    if ($numtok($asrini(ashilites),59) > 1) { aswini ashilites $remtok($asrini(ashilites),$did(1),1,59) }
    else { asrmini ashilites }
    did -d $dname 1 $did(1).sel | did -c $dname 1 $did(1).lines
  }
}
dialog asidleaway {
  title "Entering IdleAway Mode..."
  size -1 -1 180 52 
  option dbu
  icon 4, 10 10 20 20
  text "AwaySystem will enter IdleAway mode in 10 seconds", 3, 25 15 140 7, center
  button "&Abort!", 1, 50 35 35 12, ok
  button "&Go Now!", 2, 90 35 35 12, cancel default
}
on *:DIALOG:asidleaway:init:0:{
  if ($exists($shortfn($scriptdiryield.ico))) { did -g $dname 4 $shortfn($scriptdiryield.ico) }
}
dialog asuwiz {
  title "AwaySystem Uninstall Wizard"
  size -1 -1 260 160
  option dbu
  box "", 3, -1 32 263 105
  icon 4, 0 1 30 30
  text "AwaySystem Uninstall Wizard - Select Options", 5, 38 13 200 7
  text "Select the Type of uninstall. If custom is selected, choose options below then click Next.", 22, 9 40 240 7
  text "", 6, 9 50 240 25, hide
  check "Unload AwaySystem script file", 10, 15 60 82 7, disable
  check "Remove awaysys.ini file", 11, 15 70 110 7
  check "Remove awaysysthemes.ini file", 12, 15 80 120 7
  check "Remove awaysys.log file", 13, 140 60 100 7
  check "Remove Icon && Help files", 14, 140 70 90 7
  check "Remove AwaySystem script file", 15, 140 80 90 7
  text "Type of Uninstall:", 7, 75 110 45 7
  radio "Automatic", 20, 120 110 33 7, group
  radio "Custom", 21, 160 110 28 7
  button "&Finish", 9, 175 142 35 12, ok hide
  button "&Cancel", 1, 175 142 35 12, default
  button "&Next >>", 2, 215 142 35 12
}
on *:DIALOG:asuwiz:init:0:{ did -bc $dname 10,11,12,13,14,15 | did -c $dname 20 | if ($exists($shortfn($scriptdirmmircs.bmp))) { did -g $dname 4 $shortfn($scriptdirmmircs.bmp) } }
on *:DIALOG:asuwiz:sclick:1:{ dialog -x $dname | .timer 1 0 awaysys.config }
on *:DIALOG:asuwiz:sclick:2:{
  did -h $dname 7,10,11,12,13,14,15,20,21,22
  did -b $dname 1
  did -v $dname 6
  if ($did(13).state) { .remove $shortfn($asrini(awaysystemlog.log)) | did -a $dname 6 Deleting Log File }
  if ($did(12).state) { .remove awaysysthemes.ini | did -a $dname 6 Removing themes file }
  if ($did(11).state) { .remove awaysys.ini | did -a $dname 6 Removing awaysys.ini Configuration file }
  if ($timer(IdleAway)) { .timerIdleAway off }
  if ($did(14).state) { .remove $shortfn($scriptdirmmircs.bmp) | .remove $shortfn($scriptdiryield.ico) | .remove $shortfn($scriptdirawaysys.hlp) | did -a $dname 6 Removing Icon && Help files.. }
  did -a $dname 6 Unsetting varibles | unset %asoldnick %asaway* %asqaway %asnicks* 
  if ($did(15).state) { did -a $dname 6 Removing Script files | .remove $shortfn($script)  }
  did -a $dname 6 Unloading AwaySystem Script from mIRC | did -a $dname 5 AwaySystem Uninstall Wizard - Success! | did -a $dname 6 AwaySystem Uninstall was successful. Please click Finish to close this dialog and return to mIRC. $+ $crlf $crlf $+ Thank you for using AwaySystem $asver by mudpuddle. http://www.geocities.com/mmircs/  | did -v $dname 9 | did -h $dname 1 | did -b $dname 2 | .unload -rs $nopath($script)
}
on *:DIALOG:asuwiz:sclick:20:did -bc $dname 11,12,13,14,15
on *:DIALOG:asuwiz:sclick:21:did -eu $dname 11,12,13,14,15
dialog asconf {
  title "AwaySystem Preferences"
  size -1 -1 273 171
  option dbu
  menu "&File", 200
  item "E&xit", 201
  menu "&Tools", 206
  item "Show &Status bar", 208
  item break, 300
  menu "&EventLog Utilities" 219, 206
  item "&LogViewer", 207
  item "&Clear EventLog...", 24
  item break, 304, 206
  item "&Clear AwayNicks && Away Messages...", 218
  item "&AwaySystem Theme Import Wizard...", 220
  item "&Reset Preferences...", 209
  item "&Uninstall AwaySystem...", 210
  menu "&Help", 211
  item "&Contents", 212
  item "Help about this &Tab", 221
  item break, 301
  item "&Visit MmIRCS Website...", 213
  item "&Email MmIRCS...", 214
  item "&Submit a bug...", 215
  item break, 302
  item "&About AwaySystem...", 216
  tab "Main Preferences", 400, 3 0 266 126
  tab "Sounds && AwayNick", 401
  tab "Message Themes", 402
  tab "Presets", 403
  tab "Miscellaneous", 404
  box "AwayPager Options", 1, 10 20 125 103, tab 400
  check "Enable Away&Pager", 2, 15 30 55 7, tab 400
  check "&Allow Pages in Back Mode", 3, 15 40 74 7, tab 400
  check "Send &Reply on message reception", 4, 15 50 90 7, tab 400
  box "AwayLog Options", 5, 10 60 125 63, tab 400
  check "Enable &AwayLog", 6, 15 70 50 7, tab 400
  button "Triggers...", 92, 70 70 35 10, tab 400
  check "Include &Notices", 7, 15 80 48 7, tab 400
  check "Close /ms&g Windows", 86, 68 85 59 7, tab 400
  check "Include Actio&ns", 8, 15 90 50 7, tab 400
  check "&Let user know you're in Away Mode", 9, 15 100 110 7, tab 400
  check "Send Notice to User only &One Time", 10, 15 111 93 7, tab 400
  box "General Options", 13, 134 20 130 103, tab 400
  text "Repeat Away &message:", 14, 139 30 58 7, tab 400
  combo 15, 198 29 63 100, drop tab 400
  check "Enable Active&Titlebar Updating" 16, 139 43 83 7, tab 400
  check "&Save old Titlebar and replace on Back Mode", 17, 139 53 115 7, tab 400
  text "Activate Auto &IdleAway:", 18, 139 65 58 7, tab 400
  combo 19, 198 64 63 100, drop tab 400
  check "Set to Back Mode on &Channel Input", 20, 139 77 118 7, tab 400
  box "EventLog Options", 21, 134 87 130 36, tab 400
  check "Enable &Logging", 22, 139 97 48 7, tab 400
  text "(See Tools menu for utilities)", 90, 190 97 68 7, tab 400
  edit "", 25, 139 109 74 11, autohs tab 400
  button "Choose &Folder...", 26, 216 109 45 11, tab 400
  box "Sound Events", 27, 10 20 254 103, tab 401
  text "Choose sound to play for the event:", 28, 15 30 100 7, tab 401
  text "AwayPager >>", 29, 15 43 35 7, tab 401
  button "No Sound", 30, 53 41 160 11, tab 401
  button "Preview", 31, 220 41 35 11, tab 401
  text "AwayLog >>", 32, 15 63 35 7, tab 401
  button "No Sound", 33, 53 61 160 11, tab 401
  button "Preview", 34, 220 61 35 11, tab 401
  box "AwayNick Options", 35, 10 80 254 43, tab 401
  check "I want to change my &nickname to", 36, 15 90 90 7, tab 401
  combo 37, 105 89 73 40, limit 20 drop edit tab 401
  text "when I set to Away Mode", 38, 180 90 70 7, tab 401
  text "Tip: You can use @me to indicate your nickname.", 39, 15 101 240 7, tab 401
  check "I&dentify to NickServ with this password on return:", 40, 15 112 125 7, tab 401
  edit "", 41, 140 111 43 10, pass tab 401
  check "Enable Quiet Identifying", 42, 190 112 70 7, tab 401
  box "Message Themes", 43, 10 20 254 103, tab 402
  text "AwaySystem lets you change how the message looks to the channel", 44, 15 30 190 7, tab 402
  text "", 77, 15 40 140 7, tab 402
  text "Available &Themes:", 46, 15 50 45 7, tab 402
  list 47, 15 58 70 70, vsbar tab 402
  button "Ne&w", 11, 90 63 35 10, tab 402
  button "<< A&dd", 48, 90 75 35 12, tab 402
  button "&Remove >>", 49, 90 90 35 12, tab 402
  check "Use /am&e", 84, 90 110 35 7, tab 402
  text "Theme &Name:", 54, 135 50 35 7, tab 402
  edit "", 55, 171 48 90 12, limit 25 tab 402
  text "&Away Mode message:", 50, 135 65 100 7, tab 402
  edit "", 51, 135 75 127 12, autohs tab 402
  text "&Back Mode message:", 52, 135 95 100 7, tab 402
  edit "", 53, 135 105 127 12, autohs tab 402
  box "Preset Away Messages", 56, 10 20 254 103, tab 403
  text "AwaySystem lets you configure preset Away messages", 57, 15 30 245 7, tab 403
  text "Current &Presets:", 58, 15 45 45 7, tab 403
  list 59, 15 55 70 74, vsbar tab 403
  button "Ne&w", 78, 90 63 35 10, tab 403
  button "<< A&dd", 60, 90 75 35 12, tab 403
  button "&Remove >>", 61, 90 90 35 12, tab 403
  text "Preset &Name:", 82, 135 45 35 7, tab 403
  edit "", 83, 171 43 90 12, autohs limit 25 tab 403
  text "&Away message:", 62, 135 60 100 7, tab 403
  edit "", 63, 135 70 127 25, multi limit 100 tab 403

  text "AwayNic&k (opt):", 95, 135 103 40 7, tab 403
  edit "", 96, 175 100 85 12, tab 403

  box "RandomAway Configuration", 64, 10 20 254 103, tab 404
  text "File configuration for RandomAway messages", 65, 15 30 155 7, tab 404
  text "Click the button below to choose a text file, or click New to create one", 66, 15 42 245 7, tab 404
  text "Use this file for random messages:", 68, 15 56 80 7, tab 404
  button "Disable RandomAway", 69, 100 54 130 12, tab 404
  button "&New", 70, 232 54 28 12, tab 404
  box "Miscellaneous Options", 71, 10 70 254 53, tab 404
  check "Turn off AwaySystem CTCP &VERSION Reply", 73, 15 80 115 7, tab 404
  check "&Use /echo instead of Dialog Error Messages", 74, 15 90 123 7, tab 404
  check "Disable Away &Message Remembering", 85, 15 110 123 7, tab 404
  check "Don't Show Last Viewed &Preferences Tab", 75, 15 100 115 7, tab 404
  check "Disable Away&Nick Remembering", 76, 160 80 87 7, tab 404
  check "Disable Idle&Away Warning Dialog", 87, 160 90 90 7, tab 404
  check "&Deop in channels on Away Mode", 91, 160 100 90 7, tab 404
  check "&Tell user you're away when they join", 93, 160 110 95 7, tab 404
  icon 503, 5 134 12 12
  text "AwaySystem by mudpuddle", 504, 19 136 99 7
  button "OK", 500, 155 134 35 12, OK Default
  button "Cancel", 501, 195 134 35 12, Cancel
  button "Apply", 502, 233 134 35 12
  box "", 302, 0 148 273 14
  box "", 303, 1 149 202 12
  text "Welcome to AwaySystem", 304, 2 153 200 7
  box "", 305, 204 149 68 12
  text "", 306, 205 153 66 7
}
on *:Dialog:asconf:init:0:{
  if ($asrini(lastviewedtab)) && ($asrini(disablelasttab) != 1) { .timer 1 0 did -c $dname $asrini(lastviewedtab) }
  ascombo
  if ($exists($shortfn($scriptdirmmircs.bmp))) { did -g $dname 503 $shortfn($scriptdirmmircs.bmp) }
  if ($asrini(prefhidestatus))  { did -h $dname 302,303,304,305,306 | did -u $dname 208 | dialog -sb $dname -1 -1 270 150 }
  if ($asrini(prefhidestatus) != 1) { did -v $dname 302,303,304,305,306 | did -c $dname 208 | dialog -sb $dname -1 -1 270 159 }
  doasprefinit
}
on *:Dialog:asconf:sclick:2:{
  if ($did(2).state) { did -e $dname 3,4 }
  else { did -b $dname 3,4 }
}
on *:Dialog:asconf:sclick:6:{
  if ($did(6).state) { did -e $dname 7,8,86 }
  if ($did(6).state) && (Away !isin %asawaymode) { did -e $dname 9 }
  if ($did(6).state) && ($did(9).state) && (Away !isin %asawaymode) { did -e $dname 10 }
  if ($did(6).state == 0) { did -b $dname 7,8,9,10,86 }
}
on *:Dialog:asconf:sclick:9:{
  if ($did(9).state) { did -e $dname 10 }
  else { did -b $dname 10 }
}
on *:DIALOG:asconf:sclick:11:{ did -rn $dname 55,51,53,304 | did -u $dname 47 | did -c $dname 84 | did -e $dname 48,49,84  | did -f $dname 55 }
on *:Dialog:asconf:sclick:16:{
  if ($did(16).state) { did -e $dname 17 }
  else { did -b $dname 17 }
}
on *:Dialog:asconf:menu:24:.timer 1 0 clearawaysystemlog
on *:Dialog:asconf:sclick:26:.timer 1 0 aslogfolder
on *:DIALOG:asconf:sclick:30:{
  if ($did(30) == Default Beep) { .timer 1 0 aspagersndselect }
  else {
    if ($did(30) == No Sound) { did -a $dname 30 Default Beep }
    if ($did(30) != Default Beep) { did -a $dname 30 No Sound }
  }
}
on *:DIALOG:asconf:sclick:31:{ 
  if ($isfile($did(30))) { splay $shortfn($did(30)) }
  else { if ($did(30) == Default Beep) { beep 1 } }
}
on *:DIALOG:asconf:sclick:34:{ 
  if ($isfile($did(33))) { splay $shortfn($did(33)) }
  else { if ($did(33) == Default Beep) { beep 1 } }
}
on *:DIALOG:asconf:sclick:33:{
  if ($did(33) == Default Beep) { .timer 1 0 aslogsndselect }
  else {
    if ($did(33) == No Sound) { did -a $dname 33 Default Beep }
    if ($did(33) != Default Beep) { did -a $dname 33 No Sound }
  }
}
on *:Dialog:asconf:sclick:36:{
  if ($did(36).state) { did -e $dname 37 }
  if ($did(36).state == 0) { did -b $dname 37 }
}
on *:Dialog:asconf:sclick:40:{
  if ($did(40).state) { did -e $dname 41 }
  else { did -b $dname 41 }
}
on *:DIALOG:asconf:dclick:47:{ aswini selectedtheme $did(47).sel | did -a $dname 77 Current Theme: $asgetthemename }
on *:DIALOG:asconf:sclick:47:{
  if ($did(47).sel == 1) {
    did -ram $dname 55 AwaySystem Classic
    did -ram $dname 51 $asshowdefaway
    did -ram $dname 53 $asshowdefback
    did -c $dname 84 | did -b $dname 48,49,84
  }
  else {
    did -ram $dname 55 $replace($themesini($calc($did(47).sel - 1)),±,$chr(32))
    did -ra $dname 51 $astrini($calc($did(47).sel - 1),awaymsg)
    did -ra $dname 53 $astrini($calc($did(47).sel - 1),backmsg)
    if ($astrini($calc($did(47).sel -1),cmd)) { did -c $dname 84 }
    if ($astrini($calc($did(47).sel -1),cmd) == 0) { did -u $dname 84 }
    did -n $dname 51,53 | did -e $dname 48,49,84
  }
  asgetcomment
}
on *:DIALOG:asconf:sclick:48:{
  if ($did(55) == $null) { .timer 1 0 awaysyserror 'Theme Name' field must be filled. | did -f $dname 55 | return }
  if ($did(51) == $null) { .timer 1 0 awaysyserror 'Away mode Message' field must be filled. | did -f $dname 51 | return }
  if ($did(53) == $null) { .timer 1 0 awaysyserror 'Back mode Message' field must be filled. | did -f $dname 53 | return }
  if ([ isin $did(55)) || (] isin $did(55)) { .timer 1 0 awaysyserror $chr(93) or $chr(91) are not allowed in 'Theme Name' | did -rf $dname 55 | return }
  if ($strip($did(55)) == AwaySystem Classic) { .timer 1 0 awaysyserror Can't replace theme 'AwaySystem Classic' | did -rf $dname 55 | return }
  else {
    if ($exists(awaysysthemes.ini) === $false) { write -c awaysysthemes.ini }
    var %ifmatch = $ini(awaysysthemes.ini,$replace($strip($did(55)),$chr(32),±))
    if (%ifmatch) { astwini %ifmatch awaymsg $did(51) | astwini %ifmatch backmsg $did(53) | astwini %ifmatch cmd $did(84).state }
    else {
    if ($did(55) == $did(47,$did(47).sel)) { astwini $calc($did(47).sel - 1) awaymsg $did(51) | astwini $calc($did(47).sel - 1) backmsg $did(53) | astwini $calc($did(47).sel -1) cmd $did(84).state }
    else { astwini2 $replace($strip($did(55)),$chr(32),±) awaymsg $did(51) | astwini2 $replace($strip($did(55)),$chr(32),±) backmsg $did(53) | astwini2 $replace($strip($did(55)),$chr(32),±) cmd $did(84).state | did -a $dname 47 $strip($did(55)) | did -c $dname 47 $did(47).lines | did -m $dname 55 }
}
  }
  asgetcomment
}
on *:DIALOG:asconf:sclick:49:{ if ($did(47,$did(47).sel) != $null) { .timer 1 0 asthemedel } }
on *:DIALOG:asconf:sclick:59:{
  did -ram $dname 83 $replace($ini(awaysys.ini,Presets,$did(59).sel),±,$chr(32))
  did -ra $dname 63 $ascolorget($asprini($did(59).sel))
  did -ra $dname 96 $readini -n awaysys.ini PresetNicks $replace($did(83),$chr(32),±)
}
on *:DIALOG:asconf:sclick:60:{
  if ($did(83) == $null) { .timer 1 0 awaysyserror 'Preset name' field must be filled. | did -f $dname 83 | return }
  if ($did(63) == $null) { .timer 1 0 awaysyserror 'Away Message' field must be filled. | did -f $dname 63 | return }
  if ([ isin $did(83)) || (] isin $did(83)) { .timer 1 0 awaysyserror $chr(93) or $chr(91) are not allowed in 'Preset Name' | did -rf $dname 83 | return }
  else {
var %ifmatch = $readini -n awaysys.ini Presets $did(83)
if (%ifmatch) { writeini -n awaysys.ini Presets $replace($strip($did(83)),$chr(32),±) $ascolorput($did(63)) }
else {
    did -m $dname 83
    if ($did(83) == $did(59,$did(59).sel)) { aspwini $did(59).sel $did(63) }
    else { writeini -n awaysys.ini Presets $replace($strip($did(83)),$chr(32),±) $ascolorput($did(63)) | did -a $dname 59 $strip($did(83)) | did -c $dname 59 $did(59).lines }
}
if ($did(96)) { writeini -n awaysys.ini PresetNicks $replace($did(83),$chr(32),±) $did(96) }
if ($did(96) == $null) { remini awaysys.ini PresetNicks $replace($did(83),$chr(32),±) }
}
}
on *:DIALOG:asconf:sclick:61:{ if ($did(59,$did(59).sel) != $null) { asprmini $did(59).sel | remini awaysys.ini PresetNicks $replace($did(83),$chr(32),±) | did -rn $dname 83,63 | did -d $dname 59 $did(59).sel } }
on *:DIALOG:asconf:sclick:69:{
  if ($did(69) == Disable RandomAway) { .timer 1 0 asrandomawaysel }
  else { did -a $dname 69 Disable RandomAway | did -a $dname 70 &New }
}
on *:DIALOG:asconf:sclick:70:{ 
  if ($exists(randomaway.txt) != $true) && ($did(69) == Disable RandomAway) { did -a $dname 69 $mircdir $+ randomaway.txt | write randomaway.txt RandomAway file. Each new line is a new message. See the AwaySystem Help documentation. | run notepad " $+ $mircdirrandomaway.txt $+ " }
  else {
    if ($exists(randomaway.txt) == $true) && ($did(69) == Disable RandomAway) { did -a $dname 69 $mircdir $+ randomaway.txt | run notepad " $+ $mircdir $+ randomaway.txt $+ " }
    else { run notepad " $+ $did(69) $+ " }
  }
  did -a $dname 70 &Open
}
on *:DIALOG:asconf:sclick:78:{ did -r $dname 83,63,96 | did -u $dname 59 | did -f $dname 83 | did -n $dname 83 }
on *:DIALOG:asconf:sclick:92:{ .timer 1 0 ashilite }
on *:DIALOG:asconf:sclick:93:{
  if ($did(93).state) { did -u $dname 93 | .timer 1 0 aswarnchans }
}
on *:Dialog:asconf:menu:207:awaysystemlog
on *:Dialog:asconf:menu:208:{
  if ($asrini(prefhidestatus)) { did -v $dname 302,303,304,305,306 | did -c $dname 208 | dialog -sb $dname -1 -1 270 159 | aswini prefhidestatus 0 }
  else { did -h $dname 302,303,304,305,306 | did -u $dname 208 | dialog -sb $dname -1 -1 270 150 | aswini prefhidestatus 1 }
}
on *:Dialog:asconf:menu:201:dialog -x $dname
on *:Dialog:asconf:menu:209:.timer 1 0 asreset.confirm
on *:Dialog:asconf:menu:210:.timer 1 0 askasimport asuninstall
on *:DIALOG:asconf:menu:212:awaysyshlp
on *:DIALOG:asconf:menu:213:run $assite
on *:DIALOG:asconf:menu:214:run mailto:MmIRCS@bryansdomain.virtualave.net?subject= $+ $asversion
on *:DIALOG:asconf:menu:215:run $assite $+ bugsubmit.html
on *:DIALOG:asconf:menu:216:.timer 1 0 awaysysabout
on *:DIALOG:asconf:menu:218:.timer 1 0 clearawaysysnicks
on *:DIALOG:asconf:menu:221:awaysyshlp $asrini(lastviewedtab)
on *:Dialog:asconf:sclick:400:aswini lastviewedtab 400 | did -a $dname 304 Main script configuration tab
on *:Dialog:asconf:sclick:401:aswini lastviewedtab 401 | did -a $dname 304 Sound events and AwayNick Configuration
on *:Dialog:asconf:sclick:402:aswini lastviewedtab 402 | did -a $dname 304 Themes for public away and back messages
on *:Dialog:asconf:sclick:403:aswini lastviewedtab 403 | did -a $dname 304 Preset away messages for 'no typing' aways
on *:Dialog:asconf:sclick:404:aswini lastviewedtab 404 | did -a $dname 304 RandomAway message configuration and Miscellaneous Options
on *:DIALOG:asconf:sclick:500:asprefok
on *:DIALOG:asconf:sclick:502:asprefok | did -a $dname 304 Options saved | did -a $dname 77 Current Theme: $asgetthemename | updaslogsize 
dialog awaysyserror {
  title "AwaySystem Alert"
  size -1 -1 180 52 
  option dbu
  icon 2, 10 10 20 20
  text "", 3, 25 15 140 7, center
  button "&OK", 1, 75 35 35 12, ok default
}
on *:DIALOG:awaysyserror:init:0:{
  if ($exists($shortfn($scriptdiryield.ico))) { did -g $dname 2 $shortfn($scriptdiryield.ico) }
  did -a $dname 3 %awaysyserror | unset %awaysyserror
}
dialog asawaydiag { 
  title "Go into Away Mode" 
  size -1 -1 175 52 
  option dbu
  text "&Away message:", 202, 5 7 37 7
  combo 1, 43 5 118 80, drop edit
  text "0", 4, 163 7 13 7
  check "Away&Pager on", 2, 5 21 44 7 
  check "Away&Log on", 3, 58 21 39 7, 3state
  button "OK", 101, 5 35 27 12, OK default
  button "Cancel", 102, 38 35 27 12, cancel
  check "&Nick:", 103, 75 38 22 7
  combo 105, 98 36 73 40, drop edit
  text "(", 106, 105 21 7 7
  check "= No Notice Logging)", 104, 107 21 60 7, 3state
} 
on *:DIALOG:asawaydiag:init:0:{ 
  if (%asqaway) { dialog -t $dname Go into StealthAway Mode | did -h $dname 103,105 }
  if ($awaypager == on) { did -c $dname 2 } 
  if ($awaylogging == on) { did -c $dname 3 }
  if ($awaynotices == off) && ($awaylogging == on) { did -cu $dname 3 }
  if ($asrini(awaynick)) { did -ac $dname 105 $asrini(awaynick) | did -c $dname 103 }
  if ($asrini(awaynick) == $null) { did -b $dname 105 }
  if ($asrini(awaynick) == $null) && ($asrini(oldnick1)) { did -bac $dname 105 $asrini(oldnick1) }
  loadasnicks $dname 105
  did -cu $dname 104
  var %presets = 1
  var %totalpresets $ini(awaysys.ini,Presets,0)
  while (%presets <= %totalpresets) {
    did -a $dname 1 Preset: $replace($ini(awaysys.ini,Presets,%presets),±,$chr(32))
    inc %presets
  }
  if ($asrini(randomaway) != Disable RandomAway) { did -a $dname 1 Use RandomAway Message }
  did -a $dname 1 
  loadawaymsg $dname
}
on *:DIALOG:asawaydiag:sclick:1:{
var %aspresetnick = $readini -n awaysys.ini PresetNicks $ini(awaysys.ini,Presets,$did(1).sel)
if (%aspresetnick) && (Preset: isin $did(1)) { did -ac $dname 105 %aspresetnick }
else { did -c $dname 105 1 }
  if ($did(1) != Use RandomAway Mesasge) && (Preset: isin $did(1)) { did -ac $dname 1 $ascolorget($asprini($did(1).sel)) }
  else { if ($exists($shortfn($asrini(randomaway)))) && ($did(1) == Use RandomAway Message) { did -ac $dname 1 $read $shortfn($asrini(randomaway)) } }
  asdoeditboxchk 
}
on *:DIALOG:asawaydiag:edit:1:{ asdoeditboxchk }
on *:DIALOG:asawaydiag:sclick:101:{ 
  awaystatus.set
  if ($did(2).state) { aswini awaypager 1 }
  if ($did(2).state == 0) { aswini awaypager 0 }
  if ($did(3).state) { aswini awaylogging 1 | aswini awaynotices 1 }
  if ($did(3).state == 0) { aswini awaylogging 0 | aswini awaynotices 0 }
  if ($did(3).state == 2) { aswini awaylogging 1 | aswini awaynotices 0 }
  if ($did(103).state) && ($did(105)) && ($asrini(awaynick)) { aswini oldnick2 $asrini(awaynick) | aswini awaynick $strip($did(105)) }
  if ($did(103).state == 0) || ($did(105) == $null) && ($asrini(awaynick)) { aswini oldnick2 $asrini(awaynick) | asrmini awaynick }
  if ($did(103).state) && ($did(105)) { aswini awaynick $strip($did(105)) }
  if ($did(1)) { %asawaymsg = $left($did(1),100) }
  if ($did(1) == $null) { %asawaymsg = Away }
  if (%asqaway) { set %asawaymode StealthAway }
  if (%asqaway == $null) { set %asawaymode Away }
  if ($server == $null) { asecho Setting to Offline %asawaymode mode (4 $+ %asawaymsg $+ ) - AwayPager: $awaypager $+ , AwayLog: $awaylogging $+ . You will be set to Online %asawaymode when you connect to IRC. }
  assetaway
  writenicks $strip($did(105))
  writeawaymsg $did(1)
  unset %asqaway
}
on *:DIALOG:asawaydiag:sclick:102:{ unset %asqaway }
on *:DIALOG:asawaydiag:sclick:104:{ did -cu $dname 104 }
on *:DIALOG:asawaydiag:sclick:103:{
  if ($did(103).state == 0) { did -b $dname 105 }
  else { did -e $dname 105 }
}
dialog asmsgchng { 
  title "Change Away Message" 
  size -1 -1 175 42 
  option dbu
  text "&New message:", 200, 5 7 35 7
  combo 1, 43 5 118 80, edit drop
  text "0", 4, 163 7 13 7
  button "OK", 101, 5 25 27 12, OK default disable
  button "Cancel", 102, 38 25 27 12, cancel
}
On *:DIALOG:asmsgchng:init:0:{
  var %presets = 1
  var %totalpresets $ini(awaysys.ini,Presets,0)
  while (%presets <= %totalpresets) {
    did -a $dname 1 Preset: $replace($ini(awaysys.ini,Presets,%presets),±,$chr(32))
    inc %presets
  }
  if ($asrini(randomaway) != Disable RandomAway) { did -a $dname 1 Use RandomAway Message }
  did -a $dname 1 
  loadawaymsg $dname
}
on *:DIALOG:asmsgchng:sclick:1:{
  if ($did(1) != Use RandomAway Mesasge) && (Preset: isin $did(1)) { did -ac $dname 1 $ascolorget($asprini($did(1).sel)) }
  else { if ($exists($shortfn($asrini(randomaway)))) && ($did(1) == Use RandomAway Message) { did -ac $dname 1 $read $shortfn($asrini(randomaway)) } }
  asdoeditboxchk | did -e $dname 101
}
On *:DIALOG:asmsgchng:edit:1:{
  if ($did(1)) { did -e $dname 101 }
  else { did -b $dname 101 }
  asdoeditboxchk
}
On *:DIALOG:asmsgchng:sclick:101:{ writeawaymsg $did(1) | asredoawaymsg $left($did(1),100) }
dialog asimportwiz {
  title "AwaySystem Theme Import Wizard"
  size -1 -1 260 160
  option dbu
  box "", 11, -1 32 263 105
  icon 4, 0 1 30 30
  text "AwaySystem Theme Import Wizard - Welcome", 5, 38 13 200 7
  text "", 22, 9 40 240 40
  button "&Help", 100, 9 142 35 12
  button "<< &Back", 23, 178 142 35 12, disable
  button "&Cancel", 1, 135 142 35 12, cancel
  button "&Next >>", 2, 215 142 35 12, ok default
}
dialog asimportwiz1 {
  title "AwaySystem Theme Import Wizard"
  size -1 -1 260 160
  option dbu
  box "", 11, -1 32 263 105
  icon 4, 0 1 30 30
  text "AwaySystem Theme Import Wizard - Select files", 5, 38 13 200 7
  text "The first step in this wizard is to find the file you wish to Import themes from.", 22, 9 40 240 7
  text "Notice: This file must be in .ini format to be imported to AwaySystem.", 23, 9 50 240 7
  box "File to be Imported:",7, 10 80 240 23
  text "Click 'Choose file' to pick a file to import >>", 8, 15 90 185 7
  button "Choose &File...", 9, 205 88 40 12,  default
  text "Now click Next to continue...", 10, 180 120 70 7, hide
  button "&Help", 100, 9 142 35 12
  button "<< &Back", 3, 178 142 35 12
  button "&Cancel", 1, 135 142 35 12, cancel
  button "&Next >>", 2, 215 142 35 12, ok disable
}
dialog asimportwizwarn {
  title "AwaySystem Theme Import Wizard"
  size -1 -1 260 160
  option dbu
  box "", 11, -1 32 263 105
  icon 4, 0 1 30 30
  text "AwaySystem Theme Import Wizard - Theme Replace Warning", 5, 38 13 200 7
  text "The following Themes will be replaced with new ones included in the Import File you chose.", 21, 29 41 220 7
  text "If you do not remove these from the Theme file, your existing theme will get replaced by it.", 27, 29 49 220 7
  icon 26, 9 40 20 20
  list 22, 29 65 201 50, sort vsbar
  text "Click Back to choose another file, or click 'Check Names' to remove a theme.", 23, 9 120 200 7
  button "Check Na&mes...", 24, 195 118 45 12
  button "&Help", 100, 9 142 35 12
  button "<< &Back", 3, 178 142 35 12
  button "&Cancel", 1, 135 142 35 12, cancel
  button "&Next >>", 2, 215 142 35 12, ok default
}
dialog asimportwiz2 {
  title "AwaySystem Theme Import Wizard"
  size -1 -1 260 160
  option dbu
  box "", 11, -1 32 263 105
  icon 4, 0 1 30 30
  text "AwaySystem Theme Import Wizard - Confirm actions", 5, 38 13 200 7
  text "The next step in this wizard is to confirm importing... Click Next to begin the Import process.", 22, 9 40 240 7
  text "", 23, 9 60 240 40
  text "", 27, 30 80 150 7
  button "&Help", 100, 9 142 35 12
  button "<< &Back", 3, 178 142 35 12
  button "&Cancel", 1, 135 142 35 12, cancel
  button "&Next >>", 2, 215 142 35 12, default ok
}
dialog asimportwiz3 {
  title "AwaySystem Theme Import Wizard"
  size -1 -1 260 160
  option dbu
  box "", 11, -1 32 263 105
  icon 4, 0 1 30 30
  text "AwaySystem Theme Import Wizard - Finished", 5, 38 13 200 7
  text "AwaySystem has finished importing your themes.. Click Finish to exit the wizard return to mIRC.", 21, 9 40 240 7
  text "If you wish to restart this wizard to import another file, click the Restart button.", 22, 9 50 240 7
  check "Check here to open the AwaySystem &Preferences on Finish", 48, 30 80 170 7
  check "Delete the Import file from your hard drive on Finish or Restart", 49, 30 90 170 7
  button "&Help", 100, 9 142 35 12
  button "&Restart", 3, 175 142 35 12
  button "&Finish", 1, 215 142 35 12, cancel default
}
dialog asnamechk {
  title "AwaySystem Theme Import Wizard"
  size -1 -1 240 115
  option dbu
  text "", 2, 5 5 230 7
  text "Click the 'Remove From Import' button to delete the theme from the Import file.", 3, 5 13 230 7
  text "Warning: Changes are immediate and permanent!", 10, 5 21 230 7
  text "Import file &themes:", 4, 5 32 80 7
  list 5, 5 40 80 60, vsbar
  button "<<&Remove from Import", 6, 90 60 60 12
  text "Installed themes:", 7, 155 32 80 7
  list 8, 155 40 80 60, read autovs vsbar
  text "The 'Remove from Import' button doesn't modify your already installed themes.", 9, 5 102 190 7
  button "&OK", 1, 200 100 35 12, ok default
}
on *:DIALOG:asimportwiz*:init:0:{
  if ($exists($shortfn($scriptdirmmircs.bmp))) { did -g $dname 4 $shortfn($scriptdirmmircs.bmp) }
  if ($dname != asimportwiz3) { did -f $dname 2 }
  if ($dname == asimportwiz3) { did -f $dname 1 }
  if ($dname == asimportwiz) { did -a $dname 22 Welcome to the AwaySystem Theme Import Wizard! $crlf $crlf This wizard will guide you through the process of importing new themes into AwaySystem. $crlf $crlf When you're ready to begin, click the Next button, or click Cancel to return to mIRC. }
  if ($dname == asimportwiz1) && (%asimportchoose) { did -a $dname 8 $iif($len(%asimportchoose) > 65,...) $+ $right(%asimportchoose,65) | did -ve $dname 2,10 }
  if ($dname == asimportwiz2) { did -a $dname 23 The AwaySystem Theme Import Wizard will import $ini($shortfn(%asimportchoose),0) Away Themes from: $crlf $crlf $iif($len(%asimportchoose) > 85,...) $+ $right(%asimportchoose,85) $crlf $crlf To your $mircdir $+ awaysysthemes.ini file for you to use in AwaySystem. }
  if ($dname == asimportwizwarn) {
    assetnames
    if ($exists($shortfn($scriptdiryield.ico))) { did -g $dname 26 $shortfn($scriptdiryield.ico) } 
    asgetreplaced $replace(%asthemes,±,$chr(160))
  }
}
on *:DIALOG:asimportwiz*:sclick:1:{
  if ($dname == asimportwiz3) && ($did(48).state) { .timer 1 0 awaysys.config }
  if ($dname == asimportwiz3) && ($did(49).state) { .remove $shortfn(%asimportchoose) }
  unset %asimportchoose %asthemes %asimportthemes %asthemesnone
}
on *:DIALOG:asimportwiz*:sclick:100:{ awaysyshlp Additional Features, Theme Import Wizard }
on *:DIALOG:asimportwiz3:sclick:3:{
  if ($did(49).state) { .remove $shortfn(%asimportchoose) }
dialog -x $dname | unset %asimportchoose | .timer 1 0 asimportwizard }
on *:DIALOG:asconf:menu:220:{ .timer 1 0 askasimport asimportwizard }
on *:DIALOG:asimportwiz:sclick:2:{ .timer 1 0 asimport1 }
on *:DIALOG:asimportwiz1:sclick:2:{
  assetnames
  .timer 1 0 asimportwizwarn
}
on *:DIALOG:asimportwiz1:sclick:3:{ dialog -x $dname | .timer 1 0 asimportwizard }
on *:DIALOG:asimportwiz1:sclick:9:{ .timer 1 0 choosefile }
on *:DIALOG:asimportwiz2:sclick:2:{ did -a $dname 5 AwaySystem Theme Import Wizard - Importing themes... | did -a $dname 22 Please wait while AwaySystem Imports your Themes.... | did -v $dname 23 | did -b $dname 1,2,3 | asimportthemes }
on *:DIALOG:asimportwiz2:sclick:3:{ dialog -x $dname
  .timer 1 0 asimportwizwarn
}
on *:DIALOG:asnamechk:sclick:8:{ did -u $dname 8 }
on *:DIALOG:asnamechk:sclick:6:{ if ($did(5).sel) { .timer 1 0 asknamechkdel } }
on *:DIALOG:asnamechk:sclick:1:{ if ($ini($shortfn(%asimportchoose),0) == 0) { dialog -x asimportwizwarn | .timer 1 0 asimport3 }
}
on *:DIALOG:asnamechk:init:0:{
  did -a $dname 2 This dialog allows you to remove themes from ' $+ $nopath(%asimportchoose) $+ '.
  if ($exists(awaysysthemes.ini)) && ($ini(awaysysthemes.ini,0)) {
    var %themes1 = 1
    var %totalthemes1 $ini(awaysysthemes.ini,0)
    while (%themes1 <= %totalthemes1) {
      did -a $dname 8 $replace($ini(awaysysthemes.ini,%themes1),±,$chr(32))
      inc %themes1
    }
  }
  else { did -b $dname 8 | did -a $dname 8 <No Themes Installed> } 
  var %themes = 1
  var %totalthemes $ini($shortfn(%asimportchoose),0)
  while (%themes <= %totalthemes) {
    did -a $dname 5 $replace($ini($shortfn(%asimportchoose),%themes),±,$chr(32))
    inc %themes
  }
}
on *:DIALOG:asimportwizwarn:sclick:22:{ did -u $dname 22 }
on *:DIALOG:asimportwizwarn:sclick:2:{ .timer 1 0 asimport2 }
on *:DIALOG:asimportwizwarn:sclick:3:{ dialog -x $dname | unset %asimportnone %asthemes | .timer 1 0 asimport1 }
on *:DIALOG:asimportwizwarn:sclick:24:{ .timer 1 0 asnamechk }
dialog asabout {
  title "About AwaySystem"
  size -1 -1 180 135
  option dbu
  button "OK", 1, 140 116 35 12, ok default
  icon 11, 5 10 40 40
  text "", 2, 50 10 120 7
  text "Script date: September 21, 2000 ", 3, 50 20 120 7
  text "Scripter: mudpuddle", 4, 50 30 120 7
  box "System Information && Acknowledgements", 5, -1 55 182 55
  edit "", 6, 5 65 170 40, multi read vsbar
  link "", 10, 50 40 170 15
}
on *:DIALOG:asabout:sclick:10:{ run $assite }
on *:DIALOG:asabout:init:0:{
  if ($exists($shortfn($scriptdirmmircs.bmp))) { did -g $dname 11 $shortfn($scriptdirmmircs.bmp) }
  did -a $dname 2 $asversion
  did -a $dname 6 System Information as of $fulldate $crlf $crlf $+ AwayNicks saved: $ini(awaysys.ini,AwayNicks,0) $crlf $+ Away messages saved: $ini(awaysys.ini,Awaymsgs,0) $crlf $+ mIRC $+ $bits $version running under Windows $os $crlf $+ Computer uptime: $duration($calc($ticks / 1000)) $crlf $+ You're currently in %asawaymode mode $crlf $+ Script installed in $scriptdir
  did -a $dname 6 $crlf $crlf $+ ---Acknowledgements--------------------------------------------------------------- $crlf $crlf $+ Special thanks to ALGORYTHM for his beta testing, suggestions and themes for the AwaySystem Theme Pack. I would also like to thank AzBat, Joeman, Leute, weijie21 and all the people who have sent me E-Mails requesting a feature being added into AwaySystem. So if you have a feature you wish to be added in a new version, please email me! $crlf $crlf $+ $&
  MmIRCS Beta Testers: ALGORYTHM, AzBat, Joeman, Leute, mudpuddle, weijie21 $crlf $crlf $+ Enjoy, mudpuddle <MmIRCS@bryansdomain.virtualave.net>
  did -a $dname 10 $assite
}
on *:DIALOG:asidleaway:sclick:1:{ unset %astimeremaining | .timerascountdown off | resetidle | .timerIdleAway 0 10 ascheckidle }
on *:DIALOG:asidleaway:sclick:2:{ unset %astimeremaining | .timerascountdown off | asdoidleaway }
menu @AwayLog,@AwayPager,@AwaySystem {
  $iif($exists(awaysys.ini) == $false || %asawaymode == $null,Repair config file):asresetdefault
  $iif($active != @AwaySystem && $ascheckini,Clear Window &Buffer):clear | titlebar $active | unset $iif($active == @AwayLog,%asawaylognum,%asawaypagernum):
  $iif($active != @AwaySystem && $ascheckini,AwaySystem Log&Viewer):awaysystemlog
  $iif($active == @AwaySystem && $ascheckini,&Clear AwaySystem Logs...):clearawaysystemlog
  -
  $iif($ascheckini,AwaySystem &Preferences...):awaysys.config
  &Help!:awaysyshlp
}
menu channel,menubar,status {
  &AwaySystem ( $+ $iif(%asawaymode == $null,Unknown,%asawaymode): Mode)
  .$iif($exists(awaysys.ini) == $false || %asawaymode == $null,Repair config file):asresetdefault
  .$iif($ascheckini && %asawaymode == Back,Set to &Away Mode...):asgoaway
  .$iif($ascheckini && %asawaymode == Back,Set to &StealthAway Mode...):%asqaway = 1 | asgoaway
  .$iif($ascheckini && Away isin %asawaymode,Set to &Back Mode):assetback
  .$iif($ascheckini && Away isin %asawaymode,Change Away &Message...):$dialog(asmsgchng,asmsgchng)
  .-
  .$iif($ascheckini,AwaySystem &Preferences...):awaysys.config
  .$iif($ascheckini,AwaySystem Log&Viewer):awaysystemlog
  .-
.&Help!:awaysyshlp
}