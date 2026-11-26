# Firefox-Unblocked
A batch file that installs firefox on your school PC without requiring administrator rights!

The script:

1. Extracts `firefox.zip` into `%LOCALAPPDATA%\FirefoxPortable` using `tar`, which is built into Windows 10/11.
2. Finds `firefox.exe` in the extracted files.
3. Creates a `Profile` folder next to it, so your bookmarks and settings stay in one place.
4. Creates a **Firefox** shortcut on your desktop that launches with that profile.

Instructions
Click Code > Download ZIP on this repo and extract it.
Open the extracted folder and double-click setup.bat.
Launch Firefox from the new desktop shortcut, or from %LOCALAPPDATA%\FirefoxPortable.
## Known issues and limitations

- **No auto-updates.** The Mozilla update service needs admin rights. To update, rebuild the zip from a newer installer and re-run the script.
- **Can't be set as the default browser**, because that writes to the registry.
- **Won't appear in Installed apps or the Start menu.** Use the desktop shortcut.

## Legal stuff

No Firefox files have been modified. They come from the official Mozilla installer, extracted and re-zipped. Firefox is a trademark of the Mozilla Foundation, and this project is not affiliated with or endorsed by Mozilla.

~~Make sure you're allowed to run this on the computer you're using. Many schools and workplaces have rules about installing or running software that hasn't been approved, and you're responsible for following them. The author isn't responsible for any consequences of using this script.~~

thanks to: https://github.com/prestonGarvey1/Unblocked-Steam for giving me the idea for this
by the way, the entire batch file and majority of this repo was made with ai, fuck ai but.. who doesnt want firefox unblocked with no web filter?
