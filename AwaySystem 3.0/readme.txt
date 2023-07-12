AwaySystem 3 by mudpuddle - ReAdMe
Homepage: http://www.geocities.com/mmircs/
Email: MmIRCS@bryansdomain.virtualave.net
IRC: #Lounge_Legends on DALnet (/server irc.dal.net:7000)

Revision 6.26.2000
------------------------------------------------------------------

Contents


1. AwaySystem intro
2. Installing and configuring AwaySystem 3
3. Credits
4. Issues addressed & new features in AwaySystem 3

------------------------------------------------------------------


1. AwaySystem intro

 AwaySystem is a mIRC 5.71 script that enhances the /away command already built
into mIRC. With AwaySystem, you can set various options to log messages directed to you
while you're away, keep CTCP Page messages, change your nick when you go away, as well
as an Anti-idle feature while you're away so you don't get kicked from the channel you're
in. (No guarantees tho heh). There's many more features to AwaySystem, discussed in the 
help file once you load AwaySystem. Enjoy! 

Please continue reading on for Step by step instructions in loading AwaySystem 3


-----------------------------------
2. Installing and configuring AwaySystem 3


-Tools required for installation:

You'll need a screwdriver, hammer, pliers, and an industrial steamroller (incase you need to
flatten your 'puter) heh! Nah, AwaySystem is so simple to install, and besides.. Why flatten your
beloved puter that you sold your arm and leg for, and still paying on? :) Real tools are listed
below:


 1. An Unzipping program, such as WinZip (Evaluation version free from www.winzip.com),
 and basic knowledge using it (read the help file to learn how to use it)

 2. mIRC version 5.71 or later.

-Inventory check...

 There should be 6 files included within this ZIP file. 

 1. awaysys.mrc - AwaySystem Core script  *required install*

 2. awaysys.dlg - AwaySystem dialog system  *required install*
 
 3. ashelp.msg - the AwaySystem 3 Help file (extracting this is optional, it is not
 really needed for proper operation. However, I do recommend you install and read it.
 Without this file, you won't have access to AwaySystem's Help, and you may get lost
 in AwaySystem's features.)

 4. mmircs.bmp - Icon file for dialogs.. Not required for operation, but is a nice touch to
 the dialogs..

 5. yield.ico - Another Icon file for Error dialogs. Not required, but nice for looks.. 

 6. readme.txt - This readme text document (does not have to be extracted at all)


- Installing AwaySystem.

 -Upgrading from AwaySystem 2.0 or later:
  Uninstall your previous version of AwaySystem by going into the AwaySystem
  Configuration, and click the Unload button.. Choose to save your config file. Or
  simply unzip AwaySystem 3 to the same folder as your old version, and overwrite the
  file when prompted.. Then Restart mIRC. AwaySystem will ask to import your old settings.
  
  
 -For Initial installs, no previous AwaySystem versions are installed, do the following:

 1. Unzip the files to any folder on your hard drive. I do recommend it being somewhere in
 your mIRC folder for simpler installation.

 2. Start mIRC and type: /load -rs awaysys.mrc
 This will load AwaySystem into mIRC. If the folder name you install AwaySystem in contains a
 space, enclose the path and filename in Quotes (eg /load -rs "C:\Program Files\mirc\awaysys.mrc")

 3. If prompted a mIRC Script Warning dialog, click YES so that AwaySystem may create
 settings and load the AwaySystem dialog component.

 4. Access AwaySystem from the Channel, Status, and Menubar (Commands) menus and read the
 help file (if installed) for more information about your new Away System.

-------------------
3. Credits

I would like to thank [DJ]Exode for his great help in Beta testing AwaySystem. You rock d00d!


----------------
4. Issues addressed & new features in AwaySystem 3

  No bug were reported with AwaySystem 2000 Final Edition. So there
  are no bug fixes in this version (but I'm sure there's plenty new ones tho heh).
 
 New features in AwaySystem 3 include:
 
  *Redesigned Preferences dialog.. Bigger, New Menus, combo boxes, and options galore.
   Takes advantage of new Menu system, and while loops. AwaySystem gives you complete
   control over how the script operates. Nothing is done without your say-so.
 
  *AwayNick Remembering - AwaySystem keeps track of any new AwayNicks you have used
   You can also use @me in the nick box.. When going away, AwaySystem will replace it
   with your current nickname.. Such as @me-b-gon would return mudpuddle-b-gon
 
  *In addition to the AwayNick Remembering, AwaySystem will also keep track of the last
   Away Messages you have used.
 
  *AwaySystem Themes - I've gotten alot of email from people wanting to change the
   way AwaySystem shows the away message to the channel. Well, here's my solution..
   Create your own themes for Away and Back mode messages!
 
  *Presets have also been added.. You can put in preset away messages to be accessed 
   from the Away Mode Dialog box.
 
  *AwaySystem now Captures Action (/me) messages in the channel. As long as it has 
   your nickname in it, considered it logged.
 
  *Added a fun feature called RandomAway.. You create a text file with each new line 
   being an away message. Configure AwaySystem to use that file, and select "RandomAway
   Message" from the Away Mode Dialog and AwaySystem randomly chooses a line from the 
   file you specified.
 
  *Away Aliases have been added! You can type /awaymode [-sp] <awaymessage/preset #> to
   set yourself away. The /backmode command will set you into Back Mode.
 
  *Icons have been added to some dialogs to give them a little more color.
 
  *IdleAway displays an optional warning dialog giving you 10 seconds to either Abort going
   into IdleAway mode, or to go immediately.

  *Deop on Away mode will remove your ops from a channel when you go Away.

------------------------------------------------------------------

AwaySystem was built by myself, in my spare time, but I do not mind if you modify my script.
However, if you do modify it, I would appriciate it if you give me (mudpuddle) some credit
in it. I released this script as 'Open Source', so anyone can modify it, and download it
free of charge.

---------------------

Enjoy!
-mudpuddle
