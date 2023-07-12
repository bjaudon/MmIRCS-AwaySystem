AwaySystem 2000 Second Edition by mudpuddle - Help Window
Homepage: 12http://www.geocities.com/mmircs/
Email: 12MmIRCS@bryansdomain.virtualave.net
IRC:4 #Lounge_Legends on DALnet (/server irc.dal.net:7000)

Revision 2.13.2000
------------------------------------------------------------------

Help Contents:

1. Script Overview
2. Features of AwaySystem
2a. AwaySystem Popup Menus
2b. AwaySystem Control Center
3. Removing AwaySystem
4. Troubleshooting
5. Release Notes


------------------------------------------------------------------

1. Script Overview

 AwaySystem is an Away script built for mIRC 5.61 & 5.7. It adds many features
to the Away features already built into mIRC itself. Settings are easily
configured by a series of Dialogs and popup menus. And setting Away is
just as easy. All the features of AwaySystem will be discussed in this help
file.

-------------------------------------------------------------------

2. Features of AwaySystem

 AwaySystem is accessed from the popup menus available in the Channel,
Nicklist, and Menubar (usually named Commands) right click menus. The current
Away status is shown in the popup menu. Away modes are: Away, Back, StealthAway
and IdleAway mode.


Features introduced in AwaySystem 2000 First Edition:

StealthAway, which enables you to go into Away mode quietly without notifying the
whole channel. You will only see a message (local echo) from AwaySystem notifying you
that you went away.

You now can Change your Away Message without having to drop out of Away mode. 

You can set to Away or StealthAway while you're offline, and AwaySystem will set
you to online away when you connect to IRC.

----------------------------

New features in AwaySystem 2000 Second Edition include:

Improved mIRC Titlebar info. AwaySystem will show the current Away message, and
AwayPager and AwayLog stats (Including Notices) as well as Offline/Online and shows
how long you've been away. The counter updates every second. You may choose to disable
Active Titlebar Updating from the AwaySystem options to show the original 'stay-put'
titlebar.

Added configuration file importing. When uninstalling awaysystem, it will now keep
your old settings and not automatically overwrite your old configuration file. In
addition, when you remove AwaySystem, the config file is still saved for future import
if you choose to.

A few bugs were fixed in the AwayLogging feature - If the logging folder somehow got
unset, you couldn't click the change folder button.. This has been fixed. The problem
with that was if it did get unset, when AwaySystem tried to write a log event, it would
halt the whole script, and throw everything into a whirl. AwaySystem will just disable
Logging with a error message telling you to go back and enable it.

Fixed the bug that when you're in the channel with another person with AwaySystem
and you both have "Notify User that You're In Away mode" enabled, and you are away
and send a /msg or say their nickname in a channel, it would cause AwaySystem to go
into an endless loop of the replies. So the message is now a notice, because notices
when received do not give out a reply message, they are just logged into the @AwayLog.

Addition to the AwayLog: Nicknames are now kept track of, and AwaySystem will only send
them a message once per Away session. Meaning if they already got notified you're away,
they will not get notified again until you re-enter Away mode. You may disable this
feature from the AwaySystem Configuration dialog.

Added a neat thing in the Logging tab in the AwaySystem Configuration dialog. At the
bottom, you'll see "AwaySystem Log file (awaysys.log) is currently ___ KB" - This lets
you tell, by a glance, how big your log file is so you'll know when you might want to
clear it. The size is shown in Kilobytes, and is updated when you receive a new message.

Fixed dialog system for mIRC 5.7. AwaySystem uses the DBU dialog sizing method. Viewing
AwaySystem 2000 First Edition in mIRC 5.7 would make the dialog 10 pixels smaller than it
actually should have been. AwaySystem 2000 Second Edition fixes this problem, but if 
viewed in mIRC 5.61, the dialog will seem too big. Which is only a cosmetic thing and 
doesn't render the script useless.

Added several small nice touches to some of the windows in AwaySystem. The 
@AwaySystemLogs window is now named AwaySystem LogViewer, and shows the full path & 
filename of the current AwaySystem log file.

----------------------------

2a. AwaySystem Popup Menus

Set to Away Mode (Only appears when you are in Back mode) will bring up a
secondary dialog so that you may specify an Away message, temporarily change
the state of AwayLog and AwayPager events, and to enable/disable/change your
preset AwayNick (as discussed later in AwaySystem Control Center).

Set to StealthAway Mode will set you away, but will not display a message
to the whole channel. AwayNick will be disabled. While in StealthAway mode,
returning to back mode will also set you back quietly.

Change Away Message (Only Appears in Away Mode) will bring up a dialog
allowing you to change your current Away message without having to go into Back
mode.

Set to Back Mode (only Available in Away mode) will set you into Back mode, and
remove the Away status from mIRC.

AwaySystem Configuration will pop up the AwaySystem Control Center dialog so that
you may configure AwaySystem's options. All features will be discussed later on.

AwaySystem LogViewer will launch the AwaySystem Log Viewer so that you may
read the events AwaySystem has logged (Logging is controllable from the AwaySystem
Control Center, discussed later).

---------------
Help! Submenu

Help Window will bring up this Help window (duh!)

MmIRCS Website will launch your configured browser to the MmIRCS Website
(Web browser is configureable in the mIRC Options window, see mIRC help for more
information.)

Email MmIRCS will open your default mail handler to send mail to MmIRCS

Submit a Bug will launch your Web browser to the bug submission form at MmIRCS

About AwaySystem Shows basic version information, and script date for AwaySystem.


-------------------------------
2b. AwaySystem Control Center 

4Note: While in Away mode, options in 12blue4 will apply, others are either 
4disabled or won't take effect until you come into Back mode.

4Note: Options are not saved until you click the OK button in the Configuration Dialog.


--Buttons
  
  Unload... will unload the AwaySystem script from mIRC. Read the Removing AwaySystem
  for more information.

  Reset... will reset ALL options to their default values. You can also use this to
  rebuld AwaySystem's configuration file as noted in Troubleshooting

  OK will save all changed options to the configuration file, and dismiss the 
  Configuration dialog. Some options may only apply in Back mode, so they will be saved
  as soon as you return to Back mode.

  Cancel button dismisses the Configuration dialog without saving changes.

  Help! brings up this Help window.


--Pager/Log tab
 
  AwayPager sets the status of the CTCP Pager to on or off. AwayPager shows all
  incoming CTCP PAGE messages in the window @AwayPager. 

  AwayLog sets the status of the Away Logging to on or off. AwayLog shows all
  messages directed to you from the Channel, Query (/msg) into the Window @AwayLog

  -AwayLog Options 
    12Notify user that you are in Away Mode will send a /msg to the person that
    sent you one, or said your nickname in the channel telling them that you are
    away from your computer. It will also tell them the status of the AwayPager.

    Capture Notices Will log all notices you receive into the AwayLog window.
    It does not however, alert the person that you are in Away mode.

    12Close Query Windows will close the Query (/msg) window when someone has
    has messaged you in Away mode, but will still log the message into the @AwayLog 
    window.

    Send Away mode notify once per session will allow AwaySystem to keep track of
    all the people that send you a message, and will only send them a notice once
    while you're away, instead of EVERY time they send you something. This works in
    conjunction with the Notify user that you are in Away mode setting.

--Logging Tab

 AwayLogging enables AwaySystem to log all events you receive into a log file for
later viewing. Since all contents of the @AwayPager and @AwayLog windows are lost
when they are closed, AwayLogging will keep all events in a log file (awaysys.log)
in the folder you specify. Such logged events include: Time & date of event, Setting
to Away mode events (even shows the Away message), all AwayLog and AwayPager events,
and Away message changes.

Check the box 12Enable Logging to enable this feature.

Use the 12View button to bring up the Log Viewer window.

Use the 12Clear button to delete the log file

Use the 12Change Folder button to change the folder where AwaySystem keeps it's log
file. The Default folder is set to the mIRC Logging folder when AwaySystem was initially loaded.

4Note: When you specify a new log folder, the Log folder will still be the last saved
4folder until you click OK to save your configuration.

--Sounds tab

 AwaySystem can assign seperate sound events to the reception of an AwayLog, or 
AwayPager message.
Use the 12Choose button to choose a WAVE sound file, the path appears in the text
field. And you can use the 12Preview button to preview the sound before you accept
it. Uncheck the Enable box to disable the sound scheme for the event.

--Nick tab

 AwayNick allows AwaySystem to change your current nickname to the one you specify
when you go into Away Mode. When you return to Back mode, your old nickname is
restored.

  -On Return to Back mode:

   12Identify to Nickserv if you have an AwayNick specified, AwaySystem will attempt
   to Identify to NickServ with the specified password when you return to Back mode.
   This feature works with any network that allows /nickserv identify <password> as it's
   command, namely DALnet, UnitedChat and a few others.

   12Enable "Quiet Identifying" will supress the echo AwaySystem gives you when
   Identifying to NickServ.

   4Notice: The password you enter with this feature is not encrypted! Anyone with
   4access to your computer can get your password. For security, when you disable this
   4feature, AwaySystem deletes the stored password, so you will have to enter it again
   4if you wish to continue using this feature.   

--Other tab

Repeat Away message every ___ minutes will enable AwaySystem to repeat the away 
message to all channels at the rate you specify. Default setting is every 45 minutes.

Show Away mode status in mIRC Titlebar will show your Away status and time you went
away in the mIRC Titlebar.

Enable Active Titlebar Updating will enable the Away counter, which 'Actively' shows
how long you've been away so far in your mIRC Titlebar.

Go Into Away mode after ___ minutes idle Enables the IdleAway feature. If mIRC has
been idle for more than the specified time, AwaySystem will automatically set you into
Away mode. Default is 15 minutes idle. Idle is checked every 10 seconds when connected
to an IRC server, and stops upon disconnection.

12Set to Back mode on Input will automatically set you into Back mode when you say
something to a channel.

Allow CTCP PAGE requests in Back mode will enable or disable the CTCP Pager in Back
mode. With this option enabled, you will be able to receive PAGE requests regardless
if your Away status. Since AwaySystem will use it's internal CTCP Pager, this
eliminates the need for a seperate CTCP Pager addon. 4Note: If the AwayPager option
4in the general tab is Disabled, this option has no effect.


---Set to Away mode Dialog

 Away Message - type your away reason here.

 AwayPager checkbox - allows you to temporarily disable/enable the AwayPager (box
 checked is enabled). When you return to back mode, AwaySystem will revert to the previous
 settings.

 AwayLog checkbox - is a 3 state checkbox.. Full check is ALL AwayLog options enabled
 (Message logging, notice capturing), shaded is just Message logging with no notice
 capturing, while unchecked is AwayLog totally disabled.

 Nick checkbox & textarea allows you to temporarily change/disable/enable your AwayNick.
 You may specify a new nickname in that box, bypassing the one you set in the
 Configuration dialog. When you set to back mode, your nick will change to your original
 one, and the previous AwayNick will be restored.


---Set to StealthAway mode dialog 

 This dialog box is the same as the Set to Away mode one, for the exception of the
 AwayNick option.


-------------------------
3. Removing AwaySystem

Removing AwaySystem is actually easier than installing it! Simply click the Unload
button from the AwaySystem Control Center.. AwaySystem will ask you if you are sure you
wish to uninstall AwaySystem. After that, you can opt to clear the AwaySystem Logs, and
keep or delete your AwaySystem configuration. Keeping your configuration will allow you
to later import them if you wish to reload AwaySystem. The only options that aren't kept
when you import are the AwayPager, AwayLog, and Set to back mode on input. After the
unloading, all you will have to remove is the AwaySystem script file itself and the
AwaySystem help file from the folder you unzipped it to.

-------------------------
4. Troubleshooting

AwaySystem performs an Initilization check each time mIRC is started. If any problems
with the configuration file are found, AwaySystem will automatically rebuild the ini file.
This may seem a little far for an Away script, but I wrote this script with newbies in mind.
That's why AwaySystem is soooo easy to use and understand. 

If the AwaySystem configuration file is missing, while mIRC is running, you'll see the 
rebuild button in the AwaySystem popup menu. Click it to rebuild the ini file and it will
restore everything to the defaults.

To force AwaySystem to rebuild it's ini file on demand, click the Reset button in the
AwaySystem Contol Center dialog. All your previous settings will be lost! Log files
will still remain, but if you changed the folder instead of using the default mIRC log
folder, AwaySystem will not append to the existing file, and will make a new one in the
default folder. AwaySystem recreates the settings within the ini file, but never actually
deletes the file. So if your really paranoid, you can delete the Awaysys.ini file in the
main mIRC folder and restart mIRC, or click the Reset button again. This will force 
AwaySystem to create a new settings file.

Sending Bug Reports click the "Submit a bug" in the AwaySystem Help submenu. You will
be brought to a page where you may enter the information I need to have so that I may
fix the bug in AwaySystem. Be sure to be as detailed as possible when submitting bugs.
Things like the exact wording of error messages (if any) you got from mIRC (such as
*** if - Invalid syntax (line 37 Awaysys.mrc) etc...), or the actions you took to
discover the bug, and how it could be recreated will help me pinpoint the problem.


-----------------------
5. Release Notes

AwaySystem SHOULD work with mIRC16 for Windows 3.1x, I have 'sorta' tested this, I
installed the 16-bit version of mIRC 5.7 on Windows NT 4.0 and it works just fine.

I have reached the 30,000 byte limit of mIRC. I don't know how I will script the next
version of AwaySystem, probably re-do the whole thing. Because the coding *is* getting
pretty bloated.

AwaySystem CAN be used in Peace and Protection 4 if you know a little bit about hacking 
scripts. The easiest way I've found is to go into the P&P away Configuration, and
disabling ALL options. No nick changes, no away logging, no nothing! Make sure you even
uncheck the options to say you're away in the Channel. Then open the mIRC
Editor for Remotes (ALT + R), click View and select away.mrc.. Press the "Find Text"
button and find "alias away" (without the quotes) and press enter. It should be in the
vicinity of line 78 thru 159. Put a colon (;) at the beginning of every line in that
alias to comment it out, and click OK. You may want to save your original away.mrc file
before doing this. That will disable P&P's version of /away and allow the original 
default /away to work, so AwaySystem can set away and back properly.
Some minor issues I've encountered with this hack are with the titlebar updating. You 
will only be able to use the titlebar function with "Active titlebar updating" enabled. 
However, your titlebar may flicker between the P&P's titlebar and AwaySystem's. That is
only a minor thing, and doesn't do anything harmful.
Note -- This action has not been thoroughly tested, but seems to work OK in Beta 13 of
P&P 4. I don't really use P&P too much, so I'm not an expert with it. You may be able to
'hack' AwaySystem into other scripts, but you're on your own for that task!

AwaySystem does not correctly support multiple instances of the same mIRC. All those
AwaySystem's will share the same ini file, and will think you're away on ALL the
instances. As long as the other mIRC is operating from a different folder, it will not
be affected.



-End of AwaySystem Help-