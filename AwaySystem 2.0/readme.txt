 ############################################
 AwaySystem Version 2.0 by mudpuddle - Readme

 Email bug reports and suggestions to:
 MmIRCS@bryansdomain.virtualave.net

 Script Date: November 9, 1999
 ############################################
 
 ___________________________________

 Contents:
 
 1:What is AwaySystem?
 2:Setup
 3:After Setup
 4:Differences from AwaySystem 1.0
 5:Troubleshooting
 6:And the end...
 ___________________________________


 --------------------
 What is AwaySystem?
 --------------------

 AwaySystem is a mIRC script that will set you to Away on IRC, and announce
 to the channels you're in, automatically change your nickname to one you
 specify, or to easily set an away reason, receive CTCP Pages, log Messages
 with your name in them on a channel or Notices. You can configure the options
 in an easily understandable dialog window, accessible through your popup
 menus. When in Away mode you announce to the channel your reason, the time
 you went away, and the status of your CTCP Pager, and Message Logging. When
 you come out of Away, you announce to the channel the length of time you were
 away, as well as the reason you went away. If you used AwaySystem v1.0 you'll
 be pretty familiar with AwaySystem 2. A list of the Differences will be
 discussed in Differences from AwaySystem 1.0.


 ------
 Setup
 ------

 NOTICE!!! This script requires mIRC 5.61 or later, 32 or 16 bit.
 5.6 or earlier WILL NOT work because of the advanced dialog system
 that only 5.61 supports. This script HAS NOT been tested on Peace and
 Protection, or other custom mIRC Scripts (although you really don't need
 an Away System on most heh), so don't be surprised if it breaks.

 ------------------------------------------

 If you're upgrading from a previous version of AwaySystem, go into the
 AwaySystem Configuration, and press the Unload button and follow the
 On-Screen instructions before continuing. You may also want to remove
 any other Away System script you may have to avoid possibility of
 conflicts.

 Unzip these files to a folder (preferably your mIRC folder, but any will 
 do) If you want the Online Help, make sure the ashelp.msg is in the same
 folder as the awaysys.mrc file, or you won't get the help.

 awaysys.mrc
 ashelp.msg - Optional, if you want the Help documentation.

 Launch mIRC, and type this in the status window.. (this is assuming you
 unzipped AwaySystem to your mIRC Folder, of course) 
 
 /load -rs awaysys.mrc

 Note to mIRC 32-bit users: mIRC has a hissy fit with spaced filenames.
 Don't forget to truncate your foldernames if you installed this script in
 a different folder with a 2-word Foldername. (eg. New Folder could be
 Newfol~1) or you'll get a "File not found" error. Use File Properties to
 get the MS-DOS name of the folder if necessary. This doesn't apply to
 non-spaced long filenames like "MyFolderLivesHere". Also, the AwaySystem
 Configuration file (awaysys.ini) is placed in your mIRC root folder.

 If you get a "mIRC Script Warning", click the YES button. If you don't get
 the message:

 *** AwaySystem 2.0 by mudpuddle Loaded!

 and the AwaySystem Configuration dialog does not pop up, You either clicked
 no, or you made a mistake in the /load command. Keep trying!

 If you clicked no, the script is loaded, just not initialized.. Just type:
 /asresetdefault
 or restart mIRC and you're fine. AwaySystem will detect that no settings
 exist, and will reset itself to the defaults.


 ------------
 After Setup
 ------------

 All the AwaySystem menus are in the Menubar (usually named Commands)
 and in the Channel, Query, and Status right click Popups. Read the
 AwaySystem Help (the Help! button in the configuration, or context menus)
 if you've installed the help, for more information about how to use and
 configure AwaySystem.


 ---------------------------------
 Differences from AwaySystem v1.0
 ---------------------------------
 
 There are several differences in AwaySystem 2.0 from the previous version.
 Also, a lot of the bugs have been squished.

 Better control over the script.. You can choose to send a notice to the
 person that sent you a Query message saying you're away, or you can opt
 not to. As well as controlling what happens with those Query windows.

 A new dialog system. Uses mIRC 5.61's tabbed dialogs.

 The Change Logging Folder has a window showing which folder the logs
 are kept in, and it doesn't save the options as soon as you choose the
 folder.. You can press Cancel to forget it and go back to the old
 folder, or OK to save the option.
 
 Settings are kept in a .ini file instead of variables.. (Except for
 temporary things, like your away message) Which means settings aren't
 as easily messed up by other scripts.
 
 Local echoes are more like the default mIRC echoes. It uses the
 $colour(info) identifier instead of straight out going red. Which the
 red was kinda hard to see on some screens. This will color the echo to
 the color you have specified for the Info in the "mIRC Colour setup".
 (Other colors include CTCP and Action)

 The Help System can be optionally installed.. It's no longer integrated
 into the script. Which means, I can add more things into the script
 without breaking the 30kb barrier because of the help file And, if you
 get tired of it, you can just delete the help file.

 You can now specify the rate that AwaySystem announces to the channel
 your awayness by entering the amount of time, in Minutes, you wish it to
 repeat.

 You can specify if you want your Away Mode status to be placed in the mIRC
 Titlebar. The time you went away will be posted there if this option is on.
 So you can easily tell if you're Away or not.

 You can now choose to not accept CTCP PAGE requests in Back Mode. 

 There's now an IdleAway option. This option will set you to IdleAway mode
 when mIRC has been idle for the specified amount of time. Typical setting
 is 15 minutes. Note: If you experience system slowdown, try disabling this
 feature. When enabled, AwaySystem will check your idle time every 10 seconds.
 Just for that reason, I've disabled this option by default.

 You can set the option "Set to Back Mode on input" to set you to Back Mode
 when you say something to channel. This is similar to the "Cancel Away on 
 Keypress" option in the mIRC Options under IRC. BTW, if you have that mIRC
 option checked, and the "Set to Back Mode on input" unchecked, mIRC will
 unset your IRC away mode, not the AwaySystem away mode!

 On DALnet you can make AwaySystem Automatically Identify to Nickserv when you
 come back out of Away Mode with the AwayNick feature enabled. Also, if you
 ever disable this feature, AwaySystem unsets the password you specified from
 the configuration file for security.

 There's now Dynamic Popups, which means you don't see both "Set to Away
 Mode" and "Set to Back mode" options in the popups. You'll see the
 appropriate option depending on your Away status.

 You can temporarily change your AwayNick in the "Go into Away Mode" dialog.
 The previous nickname (if any) you set in the Configuration dialog will be
 restored upon returning to Back Mode.

 Command line options now exist. /goaway will bring up the "Go into Away
 Mode" dialog, /setback will set you to Back mode, and /awaysys.config will
 bring up the AwaySystem Configuration dialog.

 
 ---------------
 Troubleshooting
 ---------------

 Basically, if you have any problems with AwaySystem, usually a restart of
 mIRC will do the trick to fix it, because AwaySystem checks for the .ini
 file in your mIRC folder, and if it doesn't find it, it writes a new one.
 
 You can type the command:
 /asresetdefault
 to reset AwaySystem to it's default settings. Notice: No conformation
 message is displayed! Only use this command when you're absolutely sure
 you want to reset the settings. This will create a new awaysys.ini file
 with the default settings.

 You may also try unloading AwaySystem and making sure the awaysys.ini
 file does not exist in your mIRC main folder, and then reload AwaySystem
 to default back to the original settings if all else fails.
 (The "Unload" button in the AwaySystem Configuration dialog will remove
 the awaysys.ini file automatically)


 --------------
 And the end...
 --------------

 I've tried to fix all the buggies I could find in this version, and I've
 tested, and tested this script and have fixed every bug that I could find,
 but I'm sure there are probably ssome I haven't found yet. So if you do
 find one PLEASE email it to me at MmIRCS@bryansdomain.virtualave.net in
 detail so I can figure out which routine is causing the problem.

 If you have any ideas on what I could do on the next version of
 AwaySystem, please drop me a line at that address and I'll see what
 I can do! ;)

 Enjoy!
 - mudpuddle
