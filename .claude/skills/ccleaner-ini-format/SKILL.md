---
name: ccleaner-ini-format
description: CCleaner winapp2.ini custom-cleaner entry format ([Name*], LangSecRef=, Detect=/DetectFile=, Default=, FileKeyN=path|mask|RECURSE/REMOVESELF, RegKey, Warning=, environment variables). ClearTemp.definitions.ini is modeled on it — use when adding or extending cleanup-category keys, or comparing ClearTemp's schema with CCleaner's.
---

> ClearTemp implements only a subset of this format — see CLAUDE.md "ClearTemp.definitions.ini category schema" for what is actually supported.

# How to add your own program for CCleaner for Windows to clean

Links:
* [What do CCleaner for Windows’s INI files do?](https://support.ccleaner.com/s/article/what-do-ccleaner-for-windows-s-ini-files-do)
* [How to add your own program for CCleaner for Windows to clean](https://support.ccleaner.com/s/article/how-to-add-your-own-program-for-ccleaner-for-windows-to-clean)
* [How to add other areas of Windows for CCleaner to clean](https://support.ccleaner.com/s/article/how-to-add-other-areas-of-windows-for-ccleaner-to-clean)


## Preferred Format:

```
[Name*]
LangSecRef=
Detect/DetectFile=
Default=False
FileKey/RegKey

*Warning=
*See bottom for information on Warning (it is optional)
```

### [Name*]

This is the name of your entry, usually followed by a * for formatting purposes. This is what will appear in the Applications list within CCleaner.

### LangSecRef=

This indicates where on the list of applications within CCleaner your entry will appear. Appropriate LangSecRef numbers are below.

* 3021 = Applications
* 3022 = Internet
* 3023 = Multimedia
* 3024 = Utilities
* 3025 = Windows
* 3026 = Firefox/Mozilla
* 3027 = Opera
* 3028 = Safari
* 3029 = Google Chrome
* 3030 = Thunderbird
* 3031 = Windows Store
* 3032 = CCleaner Browser
* 3033 = Vivaldi
* 3034 = Brave
* 3035 = Opera GX

### Detect/DetectFile

These values are what CCleaner looks for to check if it should return true on an entry. Eg. DetectFile=%WinDir%\ will return true because this points to your windows directory.

Environment Variables (below) are vastly preferred over direct paths (such as C:\*)

* Detect= points to a registry key
* DetectFile= points to a file or folder.
* Detect Paths:
  * HKLM = HKEY_LOCAL_MACHINE
  * HKU = HKEY_USERS
  * HKCU = HKEY_CURRENT_USER

### DetectFile paths

( C:\ substituted for system drive)

```%AppData%```

Windows XP: C:\Documents and Settings\{username}\Application Data
Windows Vista/7: C:\Users\{username}\AppData\Roaming

```%CommonAppData%```

Windows XP: C:\Documents and Settings\All Users\Application Data
Windows Vista/7: C:\ProgramData

```%CommonProgramFiles%```

C:\Program Files\Common Files
C:\Program Files(x86)\Common Files
This will work for both 32 and 64 bit directories as CCleaner will detect it on its own.

```%HomeDrive%```

C:\

```%LocalAppData%```

Windows XP: C:\Documents and Settings\{username}\Local Settings\Application Data
Windows Vista/7: C:\Users\{username}\AppData\Local\

```%ProgramFiles%```

C:\Program Files\
C:\Program Files(x86)
This will work for both 32bit and 64bit because CCleaner detects these paths on its own.

```%SystemDrive%```

C:\

```%UserProfile%```

Windows XP: %SystemDrive%\Documents and Settings\{username}
Windows Vista/7: %SystemDrive%\Users\{username}

```%WinDir%```

C:\Windows

### Default=False

It is preferred that Default be set to false because Default is the default setting of the tickbox (False=Unticked)

This is to ensure no one has any boxes ticked that they didn't want ticked.

### FileKey1/RegKey1=

The FileKeys and RegKeys are paths of items you'd like to delete. When pointing to these, you must list the path (using the environment variables above) then use the pipe symbol | and have the filenames/registry keys after

* FileKey1=%AppData%\CCleaner|*.* - This deletes all files in a folder
* FileKey2=%LocalAppData%\CCleaner|*.log - This deletes all log files in a folder
* FileKey3=%AppData%\CCleaner|CCleaner.Log|RECURSE - This deletes all files with this name and extension in all subfolders as well
* FileKey4=%LocalAppData%\CCleaner\temp|*.*|REMOVESELF - This deletes all files in a folder and deletes the folder as well.

* | - the pipe symbol is used to separate file mask options.
* *.* - deletes every file in that folder.
* RECURSE - deletes subfolders and their contents
* REMOVESELF - is the same as RECURSE but it deletes the folder as well. Deletes all files with the same extension (*.example) or all files with the same name (example.*)

### Warning=

If there is something the end user should know about an entry, such as it resetting play counts in a media player, high scores on a game, add a warning= followed by the message.
Eg: Warning=This will delete all of your high scores.
This is considered a courtesy to the end user in helping making them aware of what they're deleting.

Remember, when posting, please test your entries before you post them, so you can be sure they don't harm the workings of the programs. Also try to post which operation system(s) you tested it with!