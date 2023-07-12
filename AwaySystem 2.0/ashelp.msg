10AwaySystem version 2.0 by mudpuddle 6Help Window
Email bug reports and suggestions to: 12MmIRCS@bryansdomain.virtualave.net
November 9, 1999

3Help
-----------------------------------------------------------------------------------------

4»AwaySystem modes
7Set to Away Mode or the command /goaway will bring up a dialog box for you to
enter your away reason, and to temporarily enable or disable your AwayNick,
AwayPager or AwayLog. The AwayLog checkbox toggles 3 ways. Full check is AwayLog
with notice logging enabled, shaded is AwayLog with No notice logging, and cleared
is no AwayLog. When you come back into back mode, your previous settings are reset.
You will also announce to the channels your AwayPager/Log status, reason and time
you went away. Also by default, every 45 minutes you re-post this information.
(This can be changed, as discussed in "Other Options" below).

7Set to Back Mode or the command /setback will bring you out of Away Mode, and
reset your AwayPager/Log settings. Will also announce to channel(s) that you have
returned.

4» AwaySystem Configuration 
5Note: when in Away Mode, and if you've set your AwayLog and AwayPager to other
5settings using the Away Mode dialog, the settings here will show them instead of the
5real ones, and if you change them, it will only change the Away Mode settings.

The command /awaysys.config will bring up the AwaySystem Configuration dialog.

The 4Unload button will remove the AwaySystem script from mIRC and unset it's varibles.
5Note: this option is unavailable in Away Mode.

7AwayPager is a feature that will allow someone to send you a CTCP Page request. 
AwayPager shows those requests in a window named @AwayPager. You do not have
to be away for this feature to work! The command for someone to send you a Page is:
4/ctcp nickname PAGE message. You can set the AwayPager status to On or Off.
Default mode is On

7AwayLog is a feature that will log all incoming Messages (/msg), messages with your 
nick in them in a channel, and notice messages (if enabled), into a window named
@AwayLog. The date/time, nickname, type of message (Notice or Message), and
channel (if it's a channel message with your nick) are also posted. You can set AwayLog
status to On or Off. Default mode is On

7AwayLog Options:
Notify user that you are in Away Mode will send an Away Mode message to the 
person that sent you a private message. Default is On

Capture notices will log notices you get to your @AwayLog window in Away Mode.
Default is On

Close Query Window when in Away Mode, and you get a private message, this will
close that window. The message will be logged in the @AwayLog. Default is On

4»AwaySound
Allows you to assign a sound event to the reception of an AwayPager and/or an
AwayLog message. You can set individual sounds to the  AwayPager or AwayLog
event. Click Enable on either AwayPager and AwayLog menus. Then click the Change...
button to surf to a wave, or type the path and filename in the edit box. Default is
Off (No sounds)

4»AwayNick
Allows you to set your away nickname when you go into away mode.. Click Enable to 
turn on and enter a Nick in the 'Nick' edit box. Disabled will not change your current 
nickname when you go into Away Mode. Default mode is Off
5Note: this option is unavailable in Away Mode.

4DALnet Options
7Identify to Nickserv is a feature that will automatically identify to NickServ when you
return to Back Mode with the AwayNick feature enabled. Use the edit box to enter your
password. It's covered in asterisks, so you need to make sure you have it right before
clicking OK. This only works on the DALnet Network.

7Enable "Quiet Identify" will suppress the 2*** AwaySystem is Identifing to NickServ
echo when your nick changes back.

4»AwaySystem Logging
7Change log folder changes the AwaySystem logging folder to the specified folder.
By Default, the logging folder is what is specified in your mIRC Logging Options. Using
this, you change the AwaySystem logging folder to any folder you wish.
5Note: AwaySystem Logging must enabled so you can use this.

7AwaySystem Logging sets the logging of the AwayLog, and AwayPager windows
(described above) to On or Off.. This option will log ALL incoming AwayLog messages
to a file named awaysys.log. Use View to open a window to see all messages that
are logged. Use Clear to delete all messages in the awaysys.log file.
Default mode is Off (No logging)

4»Other Options (5Note: You can not change these settings in Away Mode.)
7Repeat Away Message lets you specify the rate that AwaySystem repeats your
awayness to the channel(s). You can enter the amount of time that you wish your 
message be repeated in Minutes. The default setting is 45 minutes.

7Show Away Status in Titlebar will show your Away Time in the mIRC Titlebar when you're
in Away Mode. Default is On

7Allow CTCP PAGE requests in Back Mode will set the option of recieving CTCP PAGEs
in Back Mode to the @AwayPager window to on or off.  Default is On

The 7Go into Away Mode after ___ minutes (IdleAway) will enable the IdleAway feature.
This feature will check your mIRC idle, and set you to IdleAway mode after the specified
legnth in Minutes. Typical setting is 15 minutes. Saying something to the channel, or
entering Back Mode will set you out of IdleAway. If you experience system slowdown, try
disabling this feature first. Default setting is Off

7Go into Back Mode on input When Away, it will set you to back mode when you say
something in a channel. It will also still announce to the channel that you have returned!
Default setting is Off

5-End of Help-
