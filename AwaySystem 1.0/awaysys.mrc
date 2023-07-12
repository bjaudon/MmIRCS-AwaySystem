;AwaySystem version 1.0 by mudpuddle (October 16, 1999)
;Email: MmIRCS@bryansdomain.virtualave.net

on 1:LOAD:{ 
  if ($version < 5.6) { echo 4 -se >> Error! AwaySystem will not work on mIRC $version $+ . Please upgrade to mIRC 5.6 or later and try to reload the script again. | unload -rs $nopath($script) }
  else { .set %awaymode Back | .enable #awaypager | .enable #awaylogging | .enable #awaynotices | .set %awaysystem.log Off
    if (%awaysystemlog.log == $null) { .set %awaysystemlog.log $shortfn($logdir) $+ awaysys.log }
    awaysys.config
  }
}
on 1:START:{ 
  if (%awaymode != Back) { echo 4 -se >> Offline Away detected. Setting to Back mode. | .set %awaymode Back | .unset %oldnick | awaystatus.compare | if (%awaysystem.log == On) { write %awaysystemlog.log 6>> Set to Back Mode(Offline) @ $time(HH:nn:ss) $date(mm/dd/yyyy) | write %awaysystemlog.log - } }
  if (%awaysystemlog.log == $null) { echo 4 -se >> AwaySystem Log folder has become unset. Setting Log folder to $logdir | .set %awaysystemlog.log $shortfn($logdir) $+ awaysys.log }
}
on 1:CONNECT:{ if (%awaymode == Away) { echo 4 -se >> Online Away detected. Setting back to Away Mode | away %awaymsg | .timerTemp 1 5 setaway.disp } }
alias -l setaway.disp { if ($chan(0) > 0) { ame is away (12Reason:4 %awaymsg $+ ) since %awayclock $+ . AwayPager is $group(#awaypager).status $+ , AwayLog is $group(#awaylogging).status | .set %awaymode Away | .timerAway 0 2700 ame is still away (12Reason:4 %awaymsg $+ ) since %awayclock $+ . AwayPager is $group(#awaypager).status $+ , AwayLog is $group(#awaylogging).status } }
alias -l setback.disp { if ($chan(0) > 0) { ame is back (12Back from:4 %awaymsg $+ ) Gone for $duration($calc(%awayback - %awaytime)) } }
alias -l setaway { 
  .set %awaymode Away
  if (%awaysystem.log == On) { write %awaysystemlog.log - | write %awaysystemlog.log 6>> Set to Away Mode @ $time(HH:nn:ss) $date(mm/dd/yyyy) }
  if (%awaynick != $null) { set %oldnick $me | .set %awaytime $ctime | away %awaymsg | nick %awaynick | .set %awayclock $time(h:nn:ss tt) | setaway.disp }
  else { .set %awaytime $ctime | away %awaymsg | .set %awayclock $time(h:nn:ss tt) | setaway.disp }
  tbar
}
alias -l setback {
  if (%awaymode == Back) { echo 4 -ae >> You're already back! }
  else {
    if (%awaysystem.log == On) && (%awaymode == Away) { write %awaysystemlog.log 6>> Set to Back Mode @ $time(HH:nn:ss) $date(mm/dd/yyyy) | write %awaysystemlog.log - }
    if ($server == $null) && (%awaymode == Away) { .set %awaymode Back | echo 4 -ae >> Setting to Offline Back mode }   
    if (%awaymode == Away) && (%oldnick != $null) && ($server != $null) { .timerAway off | .set %awayback $ctime | nick %oldnick | .set %awaymode Back | away | setback.disp | .unset %oldnick }
    if (%awaymode == Away) && ($server != $null) { .timerAway off | .set %awayback $ctime | .set %awaymode Back | away | setback.disp }
    .unset %awaymsg
    .unset %awaytime
    .unset %awayback
    .unset %awaytime
    .unset %awayclock
    awaystatus.compare
    tbar
  }
}
alias -l tbar { 
  if (%awaymode == Away) { titlebar - Away Mode since %awayclock }
  else { titlebar }
}
#awaypager on
ctcp *:PAGE:{ 
  if ($nick != $me) { 
    .ctcpreply $nick PAGE Your page has been logged!
    if (%awaypager.snd != $null) { .splay %awaypager.snd }
    window -g2 @AwayPager
    aline -p @AwayPager $time(HH:nn:ss) $date(mm/dd/yyyy) 4Page:12 $nick $+ :  $2-
    if (%awaysystem.log == On) { write %awaysystemlog.log $time(HH:nn:ss) $date(mm/dd/yyyy) 4Page:12 $nick $+ :  $2- }
  }
}
#awaypager end
#awaylogging on
on *:TEXT:*:?:{
  if (%awaymode == Away) && ($nick != $me) { 
    window -g1 @AwayLog
    if (%awaylog.snd != $null) { .splay %awaylog.snd }
    if (%awaysystem.log == On) { write %awaysystemlog.log  $time(HH:nn:ss) $date(mm/dd/yyyy) Message: <4 $+ $nick $+ > $1- }
    aline -p @AwayLog $time(HH:nn:ss) $date(mm/dd/yyyy) Message: <4 $+ $nick $+ > $1-
    close -m $nick
    .msg $nick I'm currently away, your message has been logged. 
    if ($group(#awaypager).status == on) { .msg $nick If your message is urgent, please type 4/ctcp $me PAGE <yourmessage> }
  }
}
on *:TEXT:*:#:{
  if (%awaymode == Away) && ($me isin $parms) { 
    window -g1 @AwayLog
    if (%awaylog.snd != $null) { .splay %awaylog.snd }
    if (%awaysystem.log == On) { write %awaysystemlog.log  $time(HH:nn:ss) $date(mm/dd/yyyy) 13Message: <3 $+ $chan $+ 12\4 $+ $nick $+ > $1- }    
    aline -p @AwayLog $time(HH:nn:ss) $date(mm/dd/yyyy) 13Message: <3 $+ $chan $+ 12\4 $+ $nick $+ > $1-
    close -m $nick
    .msg $nick I'm currently away, your message has been logged. 
    if ($group(#awaypager).status == on) { .msg $nick If your message is urgent, please type 4/ctcp $me PAGE <yourmessage> }
  }
}
#awaylogging end
#awaynotices on
on *:NOTICE:*:*:{
  if (%awaymode == Away) && ($nick != $me) && ($group(#awaylogging).status == on) { 
    window -g1 @AwayLog
    if (%awaylog.snd != $null) { .splay %awaylog.snd }
    if (%awaysystem.log == On) { write %awaysystemlog.log  $time(HH:nn:ss) $date(mm/dd/yyyy) Notice: 5- $+ $nick $+ - $1- }
    aline -p @AwayLog $time(HH:nn:ss) $date(mm/dd/yyyy) Notice: 5- $+ $nick $+ - $1-
  }
}
#awaynotices end
menu @AwayLog,@AwayPager {
  Clear Window &Buffer:clear
  &View AwaySystem Logs:awaysystemlog
  -
  &Configure &AwaySystem...:awaysys.config
}
menu channel,menubar,query,status {
  &AwaySystem ( $+ %awaymode mode)
  .Set to &Away Mode...:goaway
  .Set to &Back Mode:setback
  .-
  .&Configure AwaySystem...:awaysys.config
  .-
  .&Help!:awaysystemhelp
}
menu @AwaySystemLogs {
  &Clear AwaySystem Logs:clearawaysystemlog
  -
  Configure &AwaySystem...:awaysys.config
}
alias -l clearawaysystemlog { if ($$?!="Are you sure you wish to clear AwaySystem Logs?" === $true ) { if ($exists(%awaysystemlog.log)) { .remove %awaysystemlog.log | clear @AwaySystemLogs | echo 4 -a >> AwaySystem Logs Cleared. } } }
alias -l awaysystemlog {
  clear @AwaySystemLogs
  window -ad @AwaySystemLogs 100 100 650 400
  if ($exists(%awaysystemlog.log)) { loadbuf -p @AwaySystemLogs %awaysystemlog.log }
  else { 
    clear @AwaySystemLogs
    aline -p @AwaySystemLogs 4>> AwaySystem Logs are empty
  }
}
alias -l logfolder {
  .set %oldawaysystemlog.log %awaysystemlog.log
  %awaysystemlog.log = $$sdir="Select Folder to store AwaySystem Logs in. Current folder is" $nofile(%oldawaysystemlog.log)
  %awaysystemlog.log = $shortfn(%awaysystemlog.log) $+ awaysys.log
  echo 4 -ae >> AwaySystem logs are now kept in ' $+ $colour(normal) $+ $nofile(%awaysystemlog.log) $+ 4'
  if ($exists(%oldawaysystemlog.log)) { .timer 1 0 deloldlog }
  else { .unset %oldawaysystemlog.log }
}
alias -l deloldlog {  if ($$?!="Delete old awaysys.log?" === $true) { .remove %oldawaysystemlog.log | echo 4 -ae >> AwaySystem Logs deleted sucessfully! | .unset %oldawaysystemlog.log } else { .unset %olsawaysystemlog.log } }
alias -l pagersndselect { did -ra awaysysconf 21 $$dir="Select AwayPager Sound" *.wav }
alias -l logsndselect { did -ra awaysysconf 26 $$dir="Select AwayLog Sound" *.wav }
alias -l asuninstall { if ($$?!="Are you sure you want to unload the AwaySystem script?" === $true) { .unset %away* | .unset %oldnick* | .unset %oldpager.snd | .unset %oldlog.snd | echo 4 -se >> AwaySystem v1.0 by mudpuddle unloaded. | did -bm awaysysconf 2,3,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34 | .unload -rs $nopath($script) } }
alias -l awaysystemhelp {
  clear @AwaySystemHelp
  window -adl @AwaySystemHelp 250 30 550 400 MS Sans Serif,413
  aline -pl @AwaySystemHelp 10AwaySystem version 1.0 by mudpuddle 6Help Window
  aline -pl @AwaySystemHelp Email bug reports to: 12MmIRCS@bryansdomain.virtualave.net
  aline -pl @AwaySystemHelp -
  aline -pl @AwaySystemHelp 3Help!
  aline -pl @AwaySystemHelp ---------------------------
  aline -pl @AwaySystemHelp 7Set to Away Mode will bring up a dialog box for you to enter your away reason, and
  aline -pl @AwaySystemHelp to temporarily enable or disable AwayPager or AwayLog. The AwayLog checkbox
  aline -pl @AwaySystemHelp toggles 3 ways.. Full check is AwayLog with notice logging enabled, shaded is
  aline -pl @AwaySystemHelp AwayLog with No notice logging, and cleared is no AwayLog. When you come
  aline -pl @AwaySystemHelp back to back mode, your previous settings are reset. You will also announce to the
  aline -pl @AwaySystemHelp channels your AwayPager/Log status, reason and time you went away. Also every
  aline -pl @AwaySystemHelp 45 minutes you re-post this information.
  aline -pl @AwaySystemHelp -
  aline -pl @AwaySystemHelp 7Set to Back Mode will bring you out of Away Mode, and reset your AwayPager/Log
  aline -pl @AwaySystemHelp settings.
  aline -pl @AwaySystemHelp -
  aline -pl @AwaySystemHelp 4» AwaySystem Configuration 
  aline -pl @AwaySystemHelp 5Note: when in Away Mode, and if you've set your AwayLog and AwayPager to other
  aline -pl @AwaySystemHelp 5settings using the Away Mode dialog, the settings here will show them instead of the
  aline -pl @AwaySystemHelp 5real ones, and if you change them, it will only change the Away Mode settings.
  aline -pl @AwaySystemHelp -
  aline -pl @AwaySystemHelp 7AwayPager is a feature that when set, will allow someone to send you a CTCP Page 
  aline -pl @AwaySystemHelp request. AwayPager shows those requests in a window named @AwayPager. You do
  aline -pl @AwaySystemHelp not have to be away for this feature to work! The command for someone to send you
  aline -pl @AwaySystemHelp a Page is 4/ctcp 2nickname4 PAGE 5message. You can set the AwayPager
  aline -pl @AwaySystemHelp status to On or Off. Default mode is On
  aline -pl @AwaySystemHelp -
  aline -pl @AwaySystemHelp 7AwayLog is a feature, that when set, and when you're in away mode, will log all 
  aline -pl @AwaySystemHelp incoming Messages (/msg), messages with your nick in them in a channel, and 
  aline -pl @AwaySystemHelp notice messages (if enabled), into a window named @AwayLog. The date/time,
  aline -pl @AwaySystemHelp nickname, type of message (Notice or Message), and channel (if it's a channel 
  aline -pl @AwaySystemHelp message with your nick) are also posted. You can set AwayLog status to On or Off.
  aline -pl @AwaySystemHelp Default mode is On
  aline -pl @AwaySystemHelp -
  aline -pl @AwaySystemHelp 7AwayNick is a feature that will set your away nickname when you go into away
  aline -pl @AwaySystemHelp mode.. Click Enable to turn on and enter a Nick in the 'Nick' edit box. Disabled will not
  aline -pl @AwaySystemHelp change your current nickname when you go into Away Mode. Default mode is Off
  aline -pl @AwaySystemHelp 5Note: this option is unavailable in Away Mode.
  aline -pl @AwaySystemHelp -
  aline -pl @AwaySystemHelp 7AwaySystem Sound Events... sets a sound event to the reception of an AwayPager
  aline -pl @AwaySystemHelp or AwayLog message. You can set individual sounds to the  AwayPager or AwayLog
  aline -pl @AwaySystemHelp event. Click Enable on either AwayPager and AwayLog menus. To enable, then click
  aline -pl @AwaySystemHelp the Change... button to surf to a wave, or type the path and filename in the edit box.
  aline -pl @AwaySystemHelp Default is Off (No sounds)
  aline -pl @AwaySystemHelp -
  aline -pl @AwaySystemHelp 7Unload button will remove the AwaySystem script from mIRC and unset it's varibles.
  aline -pl @AwaySystemHelp 5Note: this option is unavailable in Away Mode.
  aline -pl @AwaySystemHelp -
  aline -pl @AwaySystemHelp 4»AwaySystem Logging
  aline -pl @AwaySystemHelp 7Change log folder changes the AwaySystem logging folder to the specified folder.
  aline -pl @AwaySystemHelp By Default, the logging folder is: $logdir
  aline -pl @AwaySystemHelp Using this, you change this folder to any folder you wish.. AwaySystem Logging must
  aline -pl @AwaySystemHelp enabled so you can use this. 5Note:Your folder choice is set when you click OK on
  aline -pl @AwaySystemHelp the "Choose a folder" dialog box. If you click Cancel on the AwaySystem Configurator
  aline -pl @AwaySystemHelp window, the choice is still set!
  aline -pl @AwaySystemHelp -
  aline -pl @AwaySystemHelp 7AwaySystem Logging sets the logging of the AwayLog, and AwayPager windows
  aline -pl @AwaySystemHelp (described above) to On or Off.. This option will log ALL incoming AwayLog messages
  aline -pl @AwaySystemHelp to a file named awaysys.log. Use View to open a window to see all messages that
  aline -pl @AwaySystemHelp are logged. Use Clear to delete all messages in the awaysys.log file.
  aline -pl @AwaySystemHelp Default mode is Off (No logging)
  aline -pl @AwaySystemHelp -
  aline -pl @AwaySystemHelp 5-End of Help-
}
alias -l awaysys.config { $dialog(awaysysconf,awaysysconf) }
dialog awaysysconf {
  title "AwaySystem v1.0 Configurator"
  size -1 -1 320 390
  button "&OK", 1, 110 360 60 23, ok
  button "&Cancel", 2, 175 360 60 23, cancel default
  button "&Help!", 3, 250 360 60 23
  button "&Unload...", 34, 10 360 60 23
  text "Notice: AwayPager/Log changes won't apply in Back mode!", 35, 18 340 389 15
  text "[Away Mode]", 36, 240 10 100 20
  text "AwaySystem v1.0 by mudpuddle", 4, 75 10 160 20, center
  box "AwayPager", 5, 40 30 110 50
  radio "Off", 6, 55 50  35 20, group center
  radio "On", 7, 100 50  35 20, center
  box "AwayLog", 8, 170 30 110 60
  radio "Off", 9, 180 50  35 20, group center
  radio "On", 10, 225 50  35 20, center
  check "Log Notices", 33, 200 70 75 16 
  box "AwaySystem Logging", 11, 20 90 280 50
  radio "Off", 12, 25 110  35 20, group center
  radio "On", 13, 65 110  35 20, center
  button "&View...", 14, 110 110 40 23, default
  button "C&lear...", 15, 155 110 40 23, default
  button "Change &Folder...", 16, 200 110 90 23, default
  box "AwaySystem Sound Events", 17, 20 150 280 120
  text "AwayPager Sound:", 18, 30 170 280 50
  radio "Disable", 19, 25 185  54 20, group center
  radio "Enable", 20, 85 185  54 20, center
  edit "",21, 140 185 90 22, autohs
  button "Change...", 22, 235 185 60 23, default
  text "AwayLog Sound:", 23, 30 220 280 50
  radio "Disable", 24, 25 237  54 20, group center
  radio "Enable", 25, 85 237  54 20, center
  edit "",26, 140 237 90 22, autohs
  button "Change...", 27, 235 237 60 23, default
  box "AwayNick", 28, 20 280 280 50
  radio "Disable", 29, 25 300  54 20, group center
  radio "Enable", 30, 85 300  54 20, center
  text "Nick:", 32, 145 303 30 20
  edit "",31, 170 300 127 22
}
on *:DIALOG:awaysysconf:init:0: {
  did -ft awaysysconf 1
  if (%awaymode != Away) { did -h awaysysconf 35,36 }
  if ($group(#awaypager).status == on) { did -c awaysysconf 7 }
  if ($group(#awaypager).status == off) { did -c awaysysconf 6 }
  if ($group(#awaylogging).status == on) { did -c awaysysconf 10 }
  if ($group(#awaylogging).status == off) { did -c awaysysconf 9 | did -b awaysysconf 33 }
  if ($group(#awaynotices).status == on) { did -c awaysysconf 33 }
  if (%awaysystem.log == On) { did -c awaysysconf 13 }
  if (%awaysystem.log != On) { did -c awaysysconf 12 | did -b awaysysconf 16 }
  if (%awaypager.snd != $null) { did -c awaysysconf 20 | did -nra awaysysconf 21 %awaypager.snd }
  if (%awaypager.snd == $null) { did -c awaysysconf 19 | did -ma awaysysconf 21 %oldpager.snd | did -b awaysysconf 22 }
  if (%awaylog.snd != $null) { did -c awaysysconf 25 | did -nra awaysysconf 26 %awaylog.snd }
  if (%awaylog.snd == $null) { did -c awaysysconf 24 | did -ma awaysysconf 26 %oldlog.snd | did -b awaysysconf 27 }
  if (%awaynick != $null) { did -c awaysysconf 30 | did -nra awaysysconf 31 %awaynick }
  if (%awaynick == $null) { did -c awaysysconf 29 | did -ma awaysysconf 31 %oldnick1 }
  if (%awaymode == Away) { did -bm awaysysconf 28,29,30,31,32,34 }
}
On *:DIALOG:awaysysconf:sclick:34:{ .timer 1 0 asuninstall }
On *:DIALOG:awaysysconf:sclick:3:{ awaysystemhelp }
On *:DIALOG:awaysysconf:sclick:1:{
  if ($did(6).state == 1) { .disable #awaypager }
  if ($did(7).state == 1) { .enable #awaypager }
  if ($did(9).state == 1) { .disable #awaylogging }
  if ($did(10).state == 1) { .enable #awaylogging }
  if ($did(12).state == 1) { .set %awaysystem.log Off }
  if ($did(13).state == 1) { .set %awaysystem.log On }
  if ($did(19).state == 1) && (%awaypager.snd != $null) { .set %oldpager.snd %awaypager.snd | .unset %awaypager.snd }
  if ($did(20).state == 1) { .set %awaypager.snd $shortfn($did(21).text) }
  if ($did(24).state == 1) && (%awaylog.snd != $null) { .set %oldlog.snd %awaylog.snd | .unset %awaylog.snd }
  if ($did(25).state == 1) { .set %awaylog.snd $shortfn($did(26).text) }
  if ($did(29).state == 1) && (%awaynick != $null) { .set %oldnick1 %awaynick | .unset %awaynick }
  if ($did(30).state == 1) { .set %awaynick $did(31).text }
  if ($did(33).state == 1) { .enable #awaynotices }
  if ($did(33).state == 0) { .disable #awaynotices }
  echo -se 4>> AwaySystem Configuration Saved.
}
On *:DIALOG:awaysysconf:sclick:10:{ did -e awaysysconf 33 }
On *:DIALOG:awaysysconf:sclick:9:{ did -b awaysysconf 33 }
On *:DIALOG:awaysysconf:sclick:12:{ did -b awaysysconf 16 }
On *:DIALOG:awaysysconf:sclick:13:{ did -e awaysysconf 16 }
On *:DIALOG:awaysysconf:sclick:19:{
  did -m awaysysconf 21
  did -b awaysysconf 22
}
On *:DIALOG:awaysysconf:sclick:24:{
  did -m awaysysconf 26
  did -b awaysysconf 27
}
On *:DIALOG:awaysysconf:sclick:20:{
  did -n awaysysconf 21
  did -e awaysysconf 22
}
On *:DIALOG:awaysysconf:sclick:25:{
  did -n awaysysconf 26
  did -e awaysysconf 27
}
On *:DIALOG:awaysysconf:sclick:29:{ did -m awaysysconf 31 }
On *:DIALOG:awaysysconf:sclick:30:{ did -n awaysysconf 31 }
On *:DIALOG:awaysysconf:sclick:14:{ awaysystemlog }
On *:DIALOG:awaysysconf:sclick:15:{ .timer 1 0 clearawaysystemlog }
On *:DIALOG:awaysysconf:sclick:16:{ .timer 1 0 logfolder }
On *:DIALOG:awaysysconf:sclick:22:{ .timer 1 0 pagersndselect }
On *:DIALOG:awaysysconf:sclick:27:{ .timer 1 0 logsndselect }
alias -l goaway { 
  if ($server == $null) { echo 4 -ae >> You are not connected to an IRC Server }
  elseif (%awaymode == Away) { echo 4 -ae >> You're already away! }
  else { $dialog(awayd,awayd) } 
}
dialog awayd { 
  title "Enter Away Mode" 
  size -1 -1 300 120 
  text "Away message:", 202, 14 10 80 20 
  edit "", 1, 10 30 280 22, autohs 
  check "Away&Pager on", 2, 10 60 90 16 
  check "Away&Log on", 3, 115 60 80 16, 3state
  button "&OK", 101, 10 86 50 25, OK default 
  button "&Cancel", 102, 70 86 50 25, cancel
  text "(", 105, 170 100 7 20
  check "= No Notice Logging)", 104, 175 100 119 16, 3state
} 
on *:DIALOG:awayd:init:*:{ 
  if ($group(#awaypager).status == on) { did -c awayd 2 } 
  if ($group(#awaylogging).status == on) { did -c awayd 3 }
  if ($group(#awaynotices).status == off) && ($group(#awaylogging).status == on) { did -cu awayd 3 }
  did -cu awayd 104
}
on *:DIALOG:awayd:sclick:104:{ did -cu awayd 104 }
on *:DIALOG:awayd:sclick:101:{ 
  %awaypager.status = $group(#awaypager).status
  %awaylogging.status = $group(#awaylogging).status
  %awaynotices.status = $group(#awaynotices).status
  if ($did(2).state == 1) { .enable #awaypager }
  if ($did(2).state == 0) { .disable #awaypager }
  if ($did(3).state == 1) { .enable #awaylogging | .enable #awaynotices }
  if ($did(3).state == 0) { .disable #awaylogging | .disable #awaynotices }
  if ($did(3).state == 2) { .enable #awaylogging | .disable #awaynotices }
  if ($did(1).text != $null) { .set %awaymsg $did(1).text }
  else { .set %awaymsg Away }
  setaway
} 
alias -l awaystatus.compare {
  if (%awaypager.status == on) { .enable #awaypager }
  if (%awaylogging.status == on) { .enable #awaylogging }
  if (%awaynotices.status == on) { .enable #awaynotices }
  if (%awaypager.status == off) { .disable #awaypager }
  if (%awaypager.status == off) { .disable #awaylogging }
  if (%awaynotices.status == off) { .disable #awaynotices }
  .unset %awaypager.status
  .unset %awaylogging.status
  .unset %awaynotices.status
}
