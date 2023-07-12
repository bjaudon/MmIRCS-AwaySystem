AwaySystem 2000 Second Edition by mudpuddle - ReAdMe
Homepage: http://www.geocities.com/mmircs/
Email: MmIRCS@bryansdomain.virtualave.net
IRC: #Lounge_Legends on DALnet (/server irc.dal.net:7000)

Revision 2.13.2000
------------------------------------------------------------------

Contents

1. AwaySystem Intro
2. Installing and configuring AwaySystem 2000 SE
3. Credits
4. Release Notes

------------------------------------------------------------------

1. AwaySystem intro

Welcome to AwaySystem 2000 Second Edition! Thank you for downloading,
AwaySystem 2000 SE, I hope you enjoy the ULTIMATE away script for mIRC!

What purpose does AwaySystem serve do you ask? AwaySystem extends on the 
built-in /away command that mIRC comes with. With that command, you may only
go away from IRC quietly (which means, nobody will know you went away without
doing a /whois or by you manually telling them.). AwaySystem lets you go Away
with 100% pure dialog system for all functions. AwaySystem can log any messages
to you, either by private message, notice and channel message with your nickname
in them. AwaySystem comes with a built-in CTCP Pager system, that you can even
configure to use even while you're not away! All incoming messages are temporarily
stored into a custom mIRC window. And they may also be recorded for permanent storage
in a log file to ANY folder you wish. AwaySystem can even play seperate sounds to any
event it logs. You may configure AwaySystem to automatically set you away after so
many minutes being idle on IRC, as well as it changing your nickname to a special
one when you go away and EVEN Identify to NickServ when you return (on Networks that
support /nickserv as the command)!

AwaySystem does not alias out the original /away command, so it's still the same as it
was before, so you may totally bypass AwaySystem's features with that, or you may use
StealthAway to set away quietly, enabling you to use AwaySystem's features.

AwaySystem was designed for beginners to IRC in mind, with very minimal knowledge to mIRC.
AwaySystem upkeeps itself by checking it's settings on every mIRC startup for accidental
deletion or corruption, which minimizes any error messages or possible complications
from invalid settings. This may seem like too much for an Away Script, but that's why
AwaySystem is so easy to use!

Please continue reading on for Step by step instructions in loading AwaySystem 2000 Second Edition.


-----------------------------------
2. Installing and configuring AwaySystem 2000 SE


-Tools required for installation:

 1. An Unzipping program, such as WinZip (Evaluation version free from www.winzip.com), and basic
    knowledge using it (read the help file to learn how to use it)

 2. mIRC version 5.61 or later, although I recommend version 5.7 because of the dialog sizing


-Inventory check...

 There should be 3 files included within this ZIP file. 

 1. awaysys.mrc - the Main script file of AwaySystem

 2. ashelp.msg - the AwaySystem 2000 SE Help file (extracting this is optional, it is not really
    needed for proper operation. However, I do recommend you install and read it.)

 3. readme.txt - This readme text document (does not have to be extracted at all)


- Installing AwaySystem.

  Note: If you're upgrading AwaySystem from version 2.0 or later, simply shut down mIRC, extract these files to 
  the SAME EXACT folder as your previous version, overwriting the old file(s) and restart mIRC. AwaySystem will
  import your existing settings.

-For Initial installs, no previous awaysystem versions are installed, do the following:

 1. Unzip the files to any folder on your hard drive. I do recommend it being somewhere in your mIRC folder
 for simpler installation.

 2. Start mIRC and type: /load -rs awaysys.mrc
    This will load AwaySystem into mIRC.

 3. If prompted a mIRC Script Warning dialog, click YES so that AwaySystem may create settings.

 4. Access AwaySystem from the Channel, Status, and Menubar (Commands) menus and read the help file (if installed)
    for more information about your new Away System.



-------------------
3. Credits

I would like to thank these people for doing BETA tests and their help in scripting this thing!

swiftlysweet
^msw^
Cewks10
[DJ]Exode
dmmc^
Joeman

Thanks for the help and support you guys!

-------------------
4. Release Notes.

Several issues I know of about AwaySystem 2000 SE are if you're using mIRC 5.61 with this
script, you will notice that the Dialog systems do not look right. They're bigger than they
should. This is because of a bug that mIRC 5.61 has with DBU Dialog sizing (DBU = Dialog
Box Units, a way of sizing dialogs). mIRC 5.61 renders that style of sizing 10 pixels
smaller than it should be. You should either brave it, or just upgrade to mIRC 5.7 so that
AwaySystem may look 'Purdy'.

AwaySystem SHOULD work with mIRC16 for Windows 3.1x, I have 'sorta' tested this, I
installed the 16-bit version of mIRC on Windows NT 4.0 and it works just fine.

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




Enjoy!
-mudpuddle

P.S. If you find any bugs in my script, Please send bug reports to me from my website, I
take all reports seriously, and have fixed MANY bugs thanks to your submissions! Thanks
again!

