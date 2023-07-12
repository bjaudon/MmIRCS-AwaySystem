AwaySystem 4.0 Readme
http://www.geocities.com/mmircs
MmIRCS@bryansdomain.virtualave.net

Date released: 10/30/2004
--------------------------------------

Topics discussed in this file:

1 Changes to AwaySystem 4.0 from 3.02
2 Loading AwaySystem into mIRC
3 Disclaimer

--------------------------------------

1. Changes to AwaySystem 4.0 from 3.02


Several enhancements to AwaySystem have been made. 

AwaySystem is modified to allow use in mIRC 6.16+. 

Cosmetic surgery done to Preferences dialog, Simple encryption to the
password used to identify to NickServ, and other bugs in some of the routines.

Fixed bug in preset creator, when preset was removed, AwayNick remained.

LogViewer is now known as AwaySystem Eventlog Viewer. 

The AwaySystem EventLog Viewer now shows you the file is loading, and gives
file size in the titlebar after loading the buffer.

The File menu in the Preferences dialog is now functional. Including Save,
Save & Exit, and Exit without Saving Changes.

Added AwaySystem Theme Export to the Tools menu > AwaySystem Themes Utilities.
The Theme Import Wizard is also under this menu.


---------------------------------------

2. Loading AwaySystem into mIRC

Contents of the ZIP file:

1. awaysys.mrc - Core script file
2. awaysys.hlp - AwaySystem Winhelp file
3. mmircs.bmp - MmIRCS Logo icon
4. yield.ico - Error dialog icon

*--Upgrade Note-------------------------------------------------------------------------*
| To upgrade AwaySystem simply follow the directions below, making sure you overwrite	|
| your old awaysys.mrc file and be sure that mIRC is not running or type:		|
| /reload -rs <path\>awaysys.mrc							|
| or even restart mIRC to make sure mIRC gets the new version of AwaySystem. The only	| 
| difference between a clean install and upgrade is that AwaySystem will find your old	| 
| settings and ask if you want to import them.						|
*---------------------------------------------------------------------------------------*

Unzip the files to any folder. In mIRC type /load -rs <path\>awaysys.mrc
<path\> being the folder where you unzipped AwaySystem (such as C:\mirc\scripts\)
Note: if the folder name is a long name (contains spaces), you must enclose the entire
path in quotes (") like: /load -rs "C:\Program Files\mIRC\awaysys.mrc"

Click YES to the Remote Script warning.. If you don't, AwaySystem will not be properly
set up.

Access AwaySystem from the menubar, status and channel popup menus.. Be sure to read
the help for further information about AwaySystem's features.

-----------------------------------------

3. Disclaimer

AwaySystem is provided AS IS without warranty of any kind, either express or implied. In no 
event shall MmIRCS be liable for any damages whatsoever including direct, indirect, 
incidental, consequential, loss of business profits, or special damages even if MmIRCS
has been advised of the possibility of such damages.

The term "MmIRCS" refers to it's scripters, scripts, and testers.

-----------------------------------------

Enjoy!

MmIRCS <MmIRCS@bryansdomain.virtualave.net>