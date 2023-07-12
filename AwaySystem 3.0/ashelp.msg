 AwaySystem 3 by mudpuddle - Help Window
 Homepage: 12http://www.geocities.com/mmircs/
 Email: 12MmIRCS@bryansdomain.virtualave.net
 IRC:4 #Lounge_Legends on DALnet (/server irc.dal.net:7000)

 Revision 6.27.2000 - File version 3.00.2032
 ------------------------------------------------------------------

 Help Contents:

  1. Script Overview
  2. Features of AwaySystem
  2a. AwaySystem Popup Menus
  2b. AwaySystem Preferences
  3. How to change your Away mode
  4. Uninstalling AwaySystem
  5. Troubleshooting
  6. Release Notes

 ------------------------------------------------------------------

 1. Script Overview

  AwaySystem is an Away script built for mIRC 5.71. It adds many features
  to the Away features already built into mIRC itself. Settings are easily
  configured by a series of Dialogs and popup menus. And setting Away is
  just as easy. All the features of AwaySystem will be discussed in this help
  file.

 -------------------------------------------------------------------

 2. Features of AwaySystem

  AwaySystem is accessed from the popup menus available in the Channel,
  Nicklist, and Menubar (usually named Commands) right click menus. The current
  Away status is shown in the popup menu. Away modes are: Away, Back, StealthAway
  and IdleAway mode. List of features and fixes are below.


  //No bug were reported with AwaySystem 2000 Final Edition. So there
  //are no bug fixes in this version (but I'm sure there's plenty new ones tho heh).

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

  *Deop on Away mode will remove your ops from a channel if you are opped there.

 ----------------------------

 2a. AwaySystem Popup Menus

  Set to Away Mode (Only appears when you are in Back mode) will bring up a
  secondary dialog so that you may specify an Away message, temporarily change
  the state of AwayLog and AwayPager events, and to enable/disable/change your
  preset AwayNick (as discussed later in AwaySystem Control Center). Use the drop
  downAway message menu to select your Presets or RandomAway messages (if configured).
  At the right of the Away message box, you'll see a counter. This shows how many 
  characters you have in your message. The maximum is 100 characters. You'll see this 
  in the StealthAway and Change away message dialogs.

  Set to StealthAway Mode will set you away, but will not display a message
  to the whole channel. AwayNick will be disabled. While in StealthAway mode,
  returning to back mode will also set you back quietly.

  Change Away Message (Only Appears in Away Mode) will bring up a dialog
  allowing you to change your current Away message without having to go into Back
  mode.

  Set to Back Mode (only Available in Away mode) will set you into Back mode, and
  remove the Away status from mIRC.

  AwaySystem Preferences will pop up the AwaySystem Preferences dialog so that
  you may configure AwaySystem's options. All features will be discussed later on.

  AwaySystem LogViewer will launch the AwaySystem Log Viewer so that you may
  read the events AwaySystem has logged (Logging is controllable from the AwaySystem
  Control Center, discussed later).

  Help! will bring up this Help window (duh!)


 -------------------------------
 2b. AwaySystem Preferences 

  4Note: While in Away mode, options in 12blue4 will apply, others are either 
  4disabled or won't take effect until you come into Back mode.

  4Note: Options are not saved until you click the OK or Apply button in the 
  4Preferences Dialog. For exception of the Menu items.


 --Buttons
  
   OK will save your options and exit the dialog

   Cancel will close the dialog without saving options

   Apply will save all options without closing the dialog

 --Menus

  -File menu
    Exit same as the Cancel button
  
  -Tools menu
    Show Status bar will show/hide the status bar in the Preferences dialog
    EventLog Utilities gives you a submenu to let you view, or delete your logs.
    Clear AwayNicks & Away Messages will clear all Away nicks and messages from storage.
    Reset Preferences will reset all AwaySystem options to their defaults
    Uninstall AwaySystem Starts the AwaySystem Uninstall Wizard

  -Help menu
    Contents opens this help window
    Visit MmIRCS Website launches your browser to the MmIRCS Website
    Email MmIRCS opens your mail client to send mail to MmIRCS
    Submit a bug opens your web browser to the bug submission form at MmIRCS
    About AwaySystem brings up the About dialog


 --Main Preferences tab
 
  -Awaypager-

    Enable AwayPager sets the status of the CTCP Pager to on or off. AwayPager 
    shows all incoming CTCP PAGE messages in the window @AwayPager. 
    
    Allow Pages in Back mode will enable or disable the CTCP Pager in Back mode. 
    With this option enabled, you will be able to receive PAGE requests regardless
    if your Away status. Since AwaySystem will use it's internal CTCP Pager, this
    eliminates the need for a seperate CTCP Pager addon. 4Note: If the AwayPager
    4option is Disabled, this option has no effect.
 
    Send Reply on message reception sends a confirmation message to the person
    who paged you, telling them you received their page.
   
  -AwayLog-

   Enable AwayLog sets the status of the Away Logging to on or off. AwayLog shows 
   all messages directed to you from the Channel, Query (/msg) into the Window
   @AwayLog

   Include Notices Will log all notices you receive into the AwayLog window.
   It does not however, alert the person that you are in Away mode.

   12Close /msg Windows will close the Query (/msg) window when someone has
   has messaged you in Away mode, but will still log the message into the @AwayLog 
   window.

   12Include Actions (/me's) will log all action messages with your nick in them

   Let user know that you're in Away Mode and... will send a /msg to the 
   person that sent you one, or said your nickname in the channel telling them that
   you are away from your computer. It will also tell them the status of the AwayPager.

   Send Notice to user only one time will allow AwaySystem to keep track of
   all the people that send you a message, and will only send them a notice once
   while you're away, instead of EVERY time they send you something. This works in
   conjunction with the option above


  -General Options-

   Repeat Away message drop-down will enable AwaySystem to repeat the away 
   message to all channels at the rate you specify. Default setting is every 45
   minutes. To disable, pull down the list and select Never.

   Enable Active Titlebar Updating will show your Away Status in the mIRC Titlebar
   with an Away counter, which 'Actively' shows how long you've been away so far in 
   your mIRC Titlebar.

   Save old titlebar and replace on back mode will make AwaySystem save the text
   in your titlebar BEFORE using the Active Titlebar. When you return to back mode,
   AwaySystem restores your text.

   Activate auto IdleAway after: Enables the IdleAway feature. If mIRC has been 
   idle for more than the specified time, AwaySystem will automatically set you into
   IdleAway mode. Default selection is Never. Idle is checked by the system every 10 
   seconds when connected to an IRC server, and stops upon disconnection. Which means
   You can't be set to IdleAway mode when offline.
 
   12Set to Back mode on Input will automatically set you into Back mode when you
   say something to a channel.
 
 
  -EventLog Options-

   EventLog enables AwaySystem to log all events you receive into a log file for
   later viewing. Since all contents of the @AwayPager and @AwayLog windows are lost
   when they are closed, AwayLogging will keep all events in a log file (awaysys.log)
   in the folder you specify. Such logged events include: Time & date of event, Setting
   to Away mode events (even shows the Away message), all AwayLog and AwayPager events,
   Reconnects to IRC (when away) and Away message changes.

   Check the box 12Enable Logging to enable this feature.

   Use the 12Change Folder button to change the folder where AwaySystem keeps it's log
   file. The Default folder is set to the mIRC Logging folder when AwaySystem was initially 
   loaded.

   //Check the Tools menu under EventLog Utilities for the Logfile utilities.. 

   4Note: When you specify a new log folder, the Log folder will still be the last saved
   4folder until you click OK or Apply to save your configuration.

 --Sounds & AwayNick tab

   -AwaySystem Sound Events-

    12AwaySystem can assign seperate sound events to the reception of an AwayLog, or 
    12AwayPager message.
 
    Click the large button once to choose the Default Sound (beep). To choose a WAVE 
    sound file click it again. The filename is displayed on the button. Use the 
    12Preview button to preview the sound before you accept it. To disable the sound,
    click the button once more to display No Sound.
 
  -Nickname Options-
 
    AwayNick allows AwaySystem to change your current nickname to the one you specify
    when you go into Away Mode. When you return to Back mode, your old nickname is
    restored.

    Check the box I want to change my nickname to: and enter a nickname in the drop
    box. You can use @me to tell AwaySystem to replace it with your current Nick when
    you enter (Idle)Away mode. If you have used other AwayNicks before, the pull-down
    will list the nicks you have used.

    12Identify to Nickserv with this password on return: if you have an AwayNick 
    specified, AwaySystem will attempt to Identify to NickServ with the specified 
    password when you return to Back mode. This feature works with any network that 
    allows /nickserv identify <password> as it's command, namely DALnet, UnitedChat 
    and a few others.

    12Enable "Quiet Identifying" will disable the echo AwaySystem gives you when
    Identifying to NickServ.

    4Notice: The password you enter with this feature is not encrypted! Anyone with
    4access to your computer can get your password. For security, when you disable this
    4feature, AwaySystem deletes the stored password, so you will have to enter it again
    4if you wish to continue using this feature.   


 --Message Themes tab

   Controls in this tab allow you to set your own themes to AwaySystem public messages.
   You can change the way AwaySystem shows your Away mode and Back mode messages. First
   I will describe the fields and buttons, then I'll tell ya how to create a theme.
 
   Current Theme the current Away theme is shown here.
 
   Available Themes listbox that shows the themes you have added.
 
   New button clears out the text boxes for you to create a new theme.

   <<Add button adds the theme created in the text boxes to the list, or if the
   Theme Name is of one that is in the Available Themes listbox, it updates that
   theme. 4Note: You can't update the theme AwaySystem Classic.

   Remove>> removes the theme from your computer. 4Note: You can't remove the
   4theme AwaySystem Classic.
 
   Theme Name: allows you to set a name for your theme (Name is what shows in the
   listbox)

   Away Mode Message: allows you to create the message that is shown when going into
   Away Mode.
 
   Back Mode Message: allows you to create the message that is shown when going into 
   Back Mode.
  
   Use /ame checkbox specifies that you want your away message displayed as
   an action (/me) to the channel. Otherwise if unchecked, it will show it as a regular
   /amsg (/say or /msg) message

   --How to create a New Theme--

   To create a new theme, click the New button.. Type in a Theme Name of any name you
   wish. 4Note: If you enter a theme name that is already taken, when you click the Add
   4button later on, that theme with that name will be replaced!

   Type what you want the Away message to say.. Here's the parts of an Away Message:
   (Theme used is AwaySystem Classic)

   is away (Reason: @awaymsg) since @awaytime. AwayPager is @awaypager, AwayLog is @awaylog
   ^----------------------^  ^--------------^               ^-------------^                                 ^----------------^                           ^------------^
           |                                      |                                       |                                                      |                                                 |
   regular text      Your Away message   Time you went away          AwayPager status               AwayLog Status      

   Use the @ commands pointed out above in your Away Message.
   Valid Commands: @awaymsg, @awaytime, @awaypager and @awaylog for away messages

   Here's part of a Back mode message:
   is back (Back from: @awaymsg) Gone for @awayduration
   ^-------------------------^  ^-------------^                      ^-------------------^
                   |                               |                                               |
   Regular text                 Away message                 Duration of Away

   Use the @ commands pointed out above in your Back Message. You may also use
   the Away Mode commands listed above here as well except for the @awaypager
   and @awaylog
 
   Valid Commands: @awaymsg, @awayduration, @awaytime
 
   4Note: You may also use 12c6o12n10tro9l4 codes in your messages. Just 
   4remember to use double digits for color codes (like red would be 04). Underline and
   4Reverse are also supported.

   Next step is to select the command you want to use to display your message..
 
   Once you have your messages fixed up, and your Theme name and command selected,
   click the Add button to save the theme to disk.. If you don't click Add and you click the OK 
   button on the Preferences dialog, Your theme will not be saved!!! However, if you wish to
   edit a theme, you may click OK and it will save the changes. When  you click the Add button,
   the theme is saved, regardless if you click Cancel on the Preferences dialog.
 
   To set the theme to the Current Theme, select it in the Available Themes listbox, and
   either double click it, or click OK or Apply on the Preferences Dialog.
 
 --Presets tab

  12AwaySystem allows you to have preconfigured messages (called Presets) that you may
  12choose from when you're at the Away Mode Dialog.
  
  To create a preset, type it's name into the Preset name box. And type the message you
  want associated with that name into the Away Message box.. Your message is limited to
  100 characters because of restrictions on message limits.. You have to take into account
  the AwaySystem Theme message as well.

  After you have set your preset name and message, click the Add button to add it to the list.
 
  To update a Preset, first click it's name in the Preset listbox. It's contents are displayed in
  the text boxes to the right.. Edit them (all except for the Theme Name) and click the Add
  button to update it.. Your theme update is also saved when you click OK or Apply on the 
  Preferences dialog box. However, a new theme is not saved until you click the Add button.

  To learn how to select your preset when you go away, See the Set to Away Mode Dialog
  section.

 --Miscellaneous tab

   -RandomAway Configuration

    12RandomAway is a neat little feature that randomly reads lines from text files and sets it as
    12your Away message..

    To choose which file is used for RandomAway, click the button that say "Disable RandomAway"
    A box pops up allowing you to choose your file.. Select ONLY text documents (usually .txt files).

    If you wish to create a new RandomAway file, click the New button. AwaySystem generates a file, and
    launches Notepad to edit it. 4Note: if randomaway.txt already exists in your mIRC Folder, New will just
    4open the file in Notepad.
    If a file is already selected, click the Open button to open the file for editing.

   How to write a RandomAway Text File

    Follow the instructions above for creating a new text file..
    Remember, RandomAway treats each new line as a message.. And also remember, messages
    longer than 100 characters are cut off..


    To learn how to use RandomAway in your Away message, read the Set to Away mode Dialog section.


   -Miscellaneous Options

    12Disable AwaySystem CTCP VERSION Reply when someone sends you a CTCP Version, AwaySystem
    will send out a reply to the user showing them which version you are using. This is the *ONLY* form of 
    Advertising AwaySystem sends out to other users.

    12Disable Alert/Error Dialogs, use /echo This option will disable the dialog error messages, and use
   the regular /echo command to show the error message.

    12Disable Show Last Viewed Preferences Tab AwaySystem keeps track of which tab you last viewed
    in the preferences dialog. And when you reopen it, AwaySystem displays that tab. If you find this
    annoying, you can turn it off here.

    12Disable AwayNick Remembering disables the collection of the new awaynicks you use.

    12Disable Away Message Remembering disables the collection of the new awaynicks you use.

    12Disable IdleAway Warning dialog disables alert box that gives you 10 seconds to abort IdleAway

    12Deop on Away Mode will remove your op status from IRC Channels when you enter Away mode.
 
 
 -------------------------------------------------------------
 3. How to change your Away mode

  There's 2 ways to go into Away Mode or Back mode. The first way is an alias.

  For Away mode type: /awaymode I've gone into Away mode
  To Enter StealthAway mode, type: /awaymode -s I've gone into StealthAway mode
  To use a preset type: /awaymode -p # - Replace the # with the number of the preset.
  To list your presets, just type /awaymode -p - It will also show you the preset numbers.
 
  To return to back mode type: /backmode


  --Set to Away mode Dialog

    The second way of entering Away mode is the Dialog way.. Access the AwaySystem Popup Menu,
    and click either Away mode or StealthAway mode.

     Away Message - type your away reason here. Or pull down the list to show the available
    presets or to use the RandomAway message (if enabled)

     AwayPager checkbox - allows you to temporarily disable/enable the AwayPager (box
     checked is enabled). When you return to back mode, AwaySystem will revert to the previous
     settings.

     AwayLog checkbox - is a 3 state checkbox.. Full check is ALL AwayLog options enabled
     (Message logging, notice capturing), shaded is just Message logging with no notice
     capturing, while unchecked is AwayLog totally disabled.

     Nick checkbox & textarea allows you to temporarily change/disable/enable your AwayNick.
     Drop down the list to display the last used AwayNicks. You may specify a new nickname in 
     that box, bypassing the one you set in the Configuration dialog. When you set to back mode,
     your nick will change to your original one, and the previous AwayNick will be restored.

    4Note: The StealthAway dialog box is the same as the Set to Away mode one, for the exception of the
    4AwayNick option.

  --Changing your Away message while you're already Away

    Select "Change Away message" from the AwaySystem popup menu. Type your new message in the
    message box, or select a preset or RandomAway message (if Configured)

  --Setting to Back Mode

    Select Set to Back mode from the AwaySystem popup menu


 -------------------------
 4. Uninstalling AwaySystem

  To Uninstall AwaySystem, open the AwaySystem Preferences dialog. Click the Tools
  menu, and select Uninstall AwaySystem...

  When the AwaySystem Uninstall Wizard appears, select the type of uninstall you wish
  to use.. The Automatic option will totally remove AwaySystem from your computer.
  You can select Custom to select options you want to remove. 
  
  When you've made your selections, select the Next button to continue.. If you decide
  you don't want to Uninstall AwaySystem (which I wouldn't blame ya heh) select Cancel.
  
  Once uninstall continues YOU CAN NOT cancel out.. When AwaySystem is done
  uninstalling, click Finish to finish the uninstall and return to mIRC.
 
 -------------------------
 5. Troubleshooting

  AwaySystem performs an Initilization check each time mIRC is started. If any problems
  with the configuration file are found, AwaySystem will automatically rebuild the ini file.
  This may seem a little far for an Away script, but I wrote this script with newbies in mind.
  That's why AwaySystem is soooo easy to use and understand. 
  
  If the AwaySystem configuration file is missing, while mIRC is running, you'll see the 
  rebuild button in the AwaySystem popup menu. Click it to rebuild the ini file and it will
  restore everything to the defaults.
 
  To force AwaySystem to rebuild it's ini file on demand, enter the AwaySystem Preferences
  and click Tools menu then select Reset Preferences. All your previous settings will be lost!
  Log files will still remain, but if you changed the folder instead of using the default mIRC log
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

  Please be sure to check the MmIRCS Website (12http://www.geocities.com/mmircs/) from time to
  time for updates and new releases.

 -----------------------
 6. Release Notes (Techy stuff)

  Alot of changes have been made to this version of AwaySystem. The Away Mode marker is now
  a varible. In theory, You can use AwaySystem in multiple instances of mIRC... BUT since the
  same settings file is used, your AwayPager/Log options will be identical to the other. This
  has not been throughly tested.

  This version of AwaySystem HAS NOT been tested with mIRC16... It is unknown how it will work
  under Windows 3.1... It should work the same as other versions, none of the filename handlers
  have been modified.. If you use Win16, please email me your comments, and tell me what areas
  need to be worked on.

  I have written and tested this script under Windows 2000 Professional, and have done a quick
  run in Windows 95 (only cause my 486 will only work under 95). I much rather use the NT Family
  than the 9x re-incarnations.

  If you do run across ANY bugs, please let me know by using the bug report form at the MmIRCS
  Website.. I check the form daily, and will work on issuing a bugfix as quickly as I can. 

  Comments are also welcome. Please direct them to 12MmIRCS@bryansdomain.virtualave.net

 ----------------

  3AwaySystem was built by myself, in my spare time, but I do not mind if you modify my script.
  3However, if you do modify it, I would appriciate it if you give me (mudpuddle) some credit
  3in it. I released this script as 'Open Source', so anyone can modify it, and download it
  3free of charge.

