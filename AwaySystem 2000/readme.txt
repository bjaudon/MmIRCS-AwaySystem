AwaySystem 2000 by mudpuddle - ReAdMe
Homepage: http://www.geocities.com/mmircs/
Bug reports: http://www.geocities.com/mmircs/bugsubmit.html
Email: MmIRCS@bryansdomain.virtualave.net
IRC: #Lounge_Legends on DALnet (/server irc.dal.net:7000)

Revision 1.10.2000
------------------------------------------------------------------

Contents

1. What is AwaySystem?
2. What is included in the ZIP File?
3. Installing and setting up AwaySystem
4. Credits

------------------------------------------------------------------

1. What is AwaySystem?

AwaySystem is a mIRC 5.61 addon that enhances mIRC's Away feature. 
mIRC 5.61 is REQUIRED to run this script because of the advanced
dialog features used in this script. As of this script date, mIRC
5.61 is the current version.

AwaySystem lets you specify an away message, and it announces it to
all the channels you're currently on, instead of quietly like /away
does, unless you choose to go Away quietly. All is done through a series
of graphical, easy to understand dialogs. AwaySystem allows logging channel
messages, notices and private messages into one convienent window for viewing
while you are away. You may also receive CTCP PAGE messages while you're in
Back mode, which logs these messages in a seperate window. Other features
include the ability to automatically change your nickname to a preset AwayNick,
and restore the old one on return to back mode. IdleAway and AutoIdent
were new features introduced in version 2.0. IdleAway allows setting to Away
automatically if you haven't been on mIRC for the specified amount of time,
and AutoIdent will automatically send a NickServ IDENTIFY request when you
return to back mode so that your primary nickname will have already been
identified with the password. A new feature added into AwaySystem 2000 is
StealthAway. StealthAway allows you to enter Away mode without saying your
away message to the channel. In StealthAway, when setting to Back mode, it
will set back Quietly. A few other enhancements include a few Dialog mods,
and a few modifications to routines that play sound events, and write logging
events. Which improves AwaySystem's Win32 Long Filename support. End result, a
couple KB shaved off the script, and filenames aren't shortened when you bring
up the Configuration dialog for the log folder and sound events. The AwaySystem
Logviewer now automatically updates when new events are received while it's open.
You can now enter Away mode while you're offline, and AwaySystem will set you
away when you connect to IRC.


For a total list and explanation of features, I encourage you to install and read
the AwaySystem help once you've set up AwaySystem.


-------------------------------------
2. What is included in the ZIP File?

These files should be included in the ZIP file. I will explain what each file does here.


awaysys.mrc - The heart of AwaySystem.. This file is the code for the AwaySystem script

ashelp.msg - The AwaySystem help file. This file explains each feature of AwaySystem. 
             Installation of this help file is purely optional. It is not needed for 
             AwaySystem to function.

readme.txt - This readme document (duh!)



----------------------------------------
3. Installing and setting up AwaySystem

First unzip the files to the destination folder.. This could be any folder you wish,
but I recommend using the root mIRC Folder (generally C:\mIRC) for easier access.
If you do not want the AwaySystem help, you may save yourself the 8KB it requires
for disk space by not unzipping it.. But I HIGHLY Recommend you read it, especially
if you've never used AwaySystem before. 

Notice: In this explanation I am assuming you did unzip these files to your mIRC Folder.
If you didn't, be sure to add the correct path in the MS-DOS style (eg C:\My Mirc would
be C:\Mymir~1). For the correct MS-DOS name, double click My Computer and right click the
folder you wish to use, and click properties.. Look for the MS-DOS name. This is a 'feature'
in all versions of 32-bit mIRC.


Step one: Launch mIRC. 

Step two: In the Status window, type: /load -rs awaysys.mrc

Step three: If prompted to Initilize the script, choose yes. You should get the message
"*** AwaySystem 2000 by mudpuddle loaded!" and the AwaySystem Configuration dialog
should pop up. If it does not, right click in the status window and see if there is 
an AwaySystem entry.. If so, point to it, and click Configure AwaySystem. If not, repeat
the last step.

Step four: Configure your options.. Don't be afraid to see what they do! Use the help
utility to learn more about AwaySystem features!

Step five: Enjoy my script! I've put alot of time into it to make sure it is worth 
downloading and worth your time to use. Hope you like it as much as I enjoyed making it!


--------------
4. Credits

I'd like to give thanks to these people for putting up with me begging them to Beta
test and review AwaySystem. Thanks guys!

swiftlysweet
^msw^
Cewks10
[DJ]Exode
Phnx
dmmc^


----------

Enjoy!
-mudpuddle

P.S. If you find any bugs in my script, Please send bug reports to me from my website, I
take all reports seriously, and have fixed MANY bugs thanks to your submissions! Thanks
again!

