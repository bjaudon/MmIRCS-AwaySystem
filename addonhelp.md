This page will show you the basic steps for installing an addon into your mIRC Client. Not all scripts are loaded the same, but the steps are quite similar.  
  
**Step One - Tools checklist.**  
If you don't already have a program called Winzip, you'll need to download it (or some other Unzipping program like PKZip) to open the ZIP files. You can get Winzip from  [http://www.winzip.com](http://www.winzip.com/), read their help for information on how to set it up. Without it, you will not be able to unzip the files that are kept within the .ZIP file.  
  
**Step Two - Downloading the addon.**  
Just merely click the name of the addon you want to download.. If prompted, click Save to disk, and I recommend saving to the desktop for quick access.  
  
**Step Three - Unzipping the archive.**  (Winzip)  
Just double click the file you just downloaded.. You'll get a new window that will pop up shortly thereafter..  
Look in the list for a file named  **Readme.txt**, if it's there double click it and read it. If not, keep reading here.  
Keep in mind the files with a  **.mrc**  extension (an extension is the letters after the dot in the filename, such as awaysys_**.mrc**_). You'll need to know atleast one of the filenames so you can load the addon.  
Click the Actions menu and click Extract.. Make sure the button  **all files**  is checked, then specify your mIRC folder in the box.. If you're not sure what your mIRC folder is, launch mIRC and type this exactly in your status window:  
_//echo $mircdir  
_you'll find a message with the path of your mIRC is in.. Type that into the field in Winzip, then click the Extract button. After the light turns back to green in the Winzip status bar (bottom righthand corner), you can close Winzip.  
  
**Step Four - Loading the addon.**  
As noted in Step Three, most scripts come with a readme file.. You should read it. Most of the time they include installation instructions specific to the script. With that filename you just looked at in Winzip, type this into your status window in mIRC:  
_/load -rs scriptfilename.mrc  
_Where  _scriptfilename.mrc_  is the filename of the .mrc file you just found in Winzip. By default, mIRC shows a "Script Warning" dialog explaining the risks of loading unknown mIRC scripts.. If you want to continue click the Yes button.. By clicking No, the initialization features of the script will not be executed, so the script may not operate properly.  
**Note**: Some scripts do not have initilization, so you will not get that mIRC Warning dialog.  
  
**Step Five - Accessing the script.**  
Most features of an addon are accessable through popups.. Popups are the menus you get when you right click in a channel, nickname, status or Query/DCC window. There's also a place called the menubar (Default name is Commands) at the top of your screen. This is located in the menu bar of mIRC, between the DCC and Window menus. Look under those for new selections, they will most likely be your addon!  
Some addons are alias only scripts.. Aliases are commands you type in mIRC such as  _/help_  etc.. They usually begin with a "/".. Most of those types of addons come with a commands list, usually in the readme file or in a message that pops up when you first load the addon.
