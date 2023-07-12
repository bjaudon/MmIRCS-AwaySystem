AwaySystem 2000 by mudpuddle - Help Window
Homepage: 12http://www.geocities.com/mmircs/
Bug reports: 12http://www.geocities.com/mmircs/bugsubmit.html
Email: 12MmIRCS@bryansdomain.virtualave.net
IRC:4 #Lounge_Legends on DALnet (/server irc.dal.net:7000)

Revision 1.10.2000
------------------------------------------------------------------

Help Contents:

1. Script Overview
2. Features of AwaySystem
2a. AwaySystem Popup Menus
2b. AwaySystem Control Center
3. Removing AwaySystem
4. Troubleshooting

------------------------------------------------------------------

1. Script Overview

 AwaySystem is an Away script built for mIRC 5.61. It adds many features
to the Away features already built into mIRC itself. Settings are easily
configured by a series of Dialogs and popup menus. And setting Away is
just as easy. All the features of AwaySystem will be discussed in this help
file.

-------------------------------------------------------------------

2. Features of AwaySystem

 AwaySystem is accessed from the popup menus available in the Channel,
Nicklist, and Menubar (usually named Commands)right click menus. The current
Away status is shown in the popup menu. Away modes are: Away, Back, StealthAway
and IdleAway mode.

New features in AwaySystem 2000 include:

StealthAway, which enables you to go into Away mode quietly without notifying the
whole channel. You will only see a message (local echo) from AwaySystem notifying you
that you went away.

Another feature is the ability to Change your Away Message without having to 
drop out of Away mode. 

And yet one more feature.... You can set to Away or StealthAway while you're offline,
and AwaySystem will set you to online away when you connect to IRC! What a deal!

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

View AwaySystem Logs will show the AwaySystem Log viewer window so that you may
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

--Pager/Log tab
 
  AwayPager sets the status of the CTCP Pager to on or off. AwayPager shows all
  incoming CTCP PAGE messages in the window @AwayPager. 

  AwayLog sets the status of the Away Logging to on or off. AwayLog shows all
  messages directed to you from the Channel, Query (/msg) into the Window @AwayLog

  -AwayLog Options 
    Notify user that you are in Away Mode will send a /msg to the person that
    sent you one, or said your nickname in the channel telling them that you are
    away from your computer. It will also tell them the status of the AwayPager.

    Capture Notices Will log all notices you receive into the AwayLog window.
    It does not however, alert the person that you are in Away mode.

    Close Query Windows will close the Query (/msg) window when someone has
    has messaged you in Away mode, but will still log the message into the @AwayLog 
    window.

--Logging Tab

 AwayLogging enables AwaySystem to log all events you receive into a log file for
later viewing. Since all contents of the @AwayPager and @AwayLog windows are lost
when they are closed, AwayLogging will keep all events in a log file (awaysys.log)
in the folder you specify. Such logged events include: Time & date of event, Setting
to Away mode events (even shows the Away message), all AwayLog and AwayPager events,
and Away message changes.

Use the View button to bring up the Log Viewer window.

Use the Clear button to delete the log file

Use the Change Folder button to change the folder where AwaySystem keeps it's log
file. The Default folder is the mIRC Logging folder as configured in the mIRC Options
dialog. See the mIRC Help for more information about that option.

--Sounds tab

 AwaySystem can assign seperate sound events to the reception of an AwayLog, or 
AwayPager message.
Use the Choose button to choose a WAVE sound file, the path appears in the text
field. And you can use the Preview button to preview the sound before you accept
it. Uncheck the Enable box to disable the sound scheme for the event.

--Nick tab

 AwayNick allows AwaySystem to change your current nickname to the one you specify
when you go into Away Mode. When you return to Back mode, your old nickname is
restored.

  -DALnet Options -On Return to Back mode:

   Identify to Nickserv if you have an AwayNick specified, AwaySystem will attempt
   to Identify to NickServ with the specified password when you return to Back mode.
   This feature currently only works with DALnet.

   Enable "Quiet Identifying" will supress the echo AwaySystem gives you when
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

Allow CTCP PAGE requests in Back mode will enable or disable the CTCP Pager in Back
mode. With this option enabled, you will be able to receive PAGE requests regardless
if your Away status. Since AwaySystem will use it's internal CTCP Pager, this
eliminates the need for a seperate CTCP Pager addon.

Go Into Away mode after ___ minutes idle Enables the IdleAway feature. If mIRC has
been idle for more than the specified time, AwaySystem will automatically set you into
Away mode. Default is 15 minutes idle. Idle is checked every 10 seconds when connected
to an IRC server, and stops upon disconnection.

Set to Back mode on Input will automatically set you into Back mode when you say
something to a channel.

-------------------------
3. Removing AwaySystem

Removing AwaySystem is actually easier than installing it! Simply click the Unload
button from the AwaySystem Control Center.. You will be asked a couple questions before
you can continue. All you will have to remove then is the AwaySystem script file itself
and the AwaySystem help file from the folder you unzipped it to. If you wish for the 
AwaySystem log file to be removed as well, click the Clear button in the Logging folder
before clicking the Unload button.

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


-End of AwaySystem Help-