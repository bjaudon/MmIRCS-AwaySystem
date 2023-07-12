AwaySystem 2000 Final Edition (ver 2.12) by mudpuddle - ReAdMe
Homepage: http://www.geocities.com/mmircs/
Email: MmIRCS@bryansdomain.virtualave.net
IRC: #Lounge_Legends on DALnet (/server irc.dal.net:7000)

Revision 3.14.2000
------------------------------------------------------------------

Contents

1. AwaySystem Intro
2. Installing and configuring AwaySystem 2000 Final Edition
3. Credits
4. Issues addressed & new features in AwaySystem 2000 Final Edition
5. Release Notes

------------------------------------------------------------------

1. AwaySystem intro

 AwaySystem is a mIRC 5.61/5.70 script that enhances the /away command already built
into mIRC. With AwaySystem, you can set various options to log messages directed to you
while you're away, keep CTCP Page messages, change your nick when you go away, as well
as an Anti-idle feature while you're away so you don't get kicked from the channel you're
in. (No guarantees tho heh). There's many more features to AwaySystem, discussed in the 
help file once you load AwaySystem. Enjoy! 

Please continue reading on for Step by step instructions in loading AwaySystem 2000
Final Edition.


-----------------------------------
2. Installing and configuring AwaySystem 2000 FE


-Tools required for installation:

You'll need a screwdriver, hammer, pliers, and an industrial steamroller (incase you need to
flatten your 'puter) heh! Nah, AwaySystem is so simple to install, and besides.. Why flatten your
beloved puter that you sold your arm and leg for, and still paying on? :) Real tools are listed
below:


 1. An Unzipping program, such as WinZip (Evaluation version free from www.winzip.com),
 and basic knowledge using it (read the help file to learn how to use it)

 2. mIRC version 5.61 or later, although I recommend version 5.7 because of the dialog 
 sizing, but 5.61 works just fine.

-Inventory check...

 There should be 3 files included within this ZIP file. 

 1. awaysys.mrc - the Main script file of AwaySystem

 2. ashelp.msg - the AwaySystem 2000 FE Help file (extracting this is optional, it is not
 really needed for proper operation. However, I do recommend you install and read it.
 Without this file, you won't have access to AwaySystem's Help.)

 3. readme.txt - This readme text document (does not have to be extracted at all)


- Installing AwaySystem.

  Note: If you're upgrading AwaySystem from version 2.0 or later, simply shut down mIRC,
  extract these files to the SAME EXACT folder as your previous version, overwriting the 
  old file(s) and restart mIRC. AwaySystem will import your existing settings.
  

-For Initial installs, no previous AwaySystem versions are installed, do the following:

 1. Unzip the files to any folder on your hard drive. I do recommend it being somewhere in
 your mIRC folder for simpler installation.

 2. Start mIRC and type: /load -rs awaysys.mrc
 This will load AwaySystem into mIRC.

 3. If prompted a mIRC Script Warning dialog, click YES so that AwaySystem may create
 settings.

 4. Access AwaySystem from the Channel, Status, and Menubar (Commands) menus and read the
 help file (if installed) for more information about your new Away System.



-------------------
3. Credits

I would like to thank these people for doing BETA tests and their help in scripting this
thing!

swiftlysweet
^msw^
Cewks10
[DJ]Exode
dmmc^
Joeman

Thanks guys!


----------------
4. Issues addressed & new features in AwaySystem 2000 Final Edition

This version addresses some little glitches with the AwayNick remembering mechanism.
Other fixes include the Away message repeater bug would not repeat your away message if
you got disconnected from IRC because the timer was not re-started.

Fixed IdleAway routine that would disable your AwayNick and not change it when it went
into IdleAway mode. 

Added an Away message counter. The Away message fields in Away, StealthAway and the Change
Away message dialogs have been enlarged to 100 characters.

Updated configuration importing - Checks options to see their state if they already exist.
If not, they are written to defaults. Also, the AwayPager, AwayLog, "Notice Capturing", and
"Set to back mode on input" options are saved in importing.

As mentioned above, the AwayPager, AwayLog, "Notice Capturing" and "Set to back mode on
input" options are now saved in the awaysys.ini file, they're no longer groups.



-------------------
5. Release Notes.

As with AwaySystem 2000 Second Edition, the dialog size factor will still be the same in
this version of AwaySystem. mIRC 5.61 had a bug in the DBU Dialog sizing option. Apparently,
I did not know about this bug until mIRC 5.7. What happened is in mIRC 5.61, the dialogs
were sizing 10 pixels smaller than they should have been. So, in mIRC 5.7, Khaled fixed
this problem, which in turn, threw off new scripts written in mIRC 5.61.

AwaySystem SHOULD work with mIRC16 for Windows 3.1x, I have 'sorta' tested this, I
installed the 16-bit version of mIRC on Windows NT 4.0 and it works just fine.

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

I will fix the AwayPager and AwayLog status for importing in later versions of AwaySystem,
when I have alot more time.


AwaySystem was built by myself, in my spare time, but I do not mind if you modify my script.
However, if you do modify it, I would appriciate it if you give me (mudpuddle) some credit
in it. I released this script as 'Open Source', so anyone can modify it, and download it
free of charge.

---------------------

Enjoy!
-mudpuddle
