@echo off
setlocal

:: One-click Firefox setup: unpacks the bundled Firefox files into a folder you
:: own and makes a desktop shortcut. No installer is run, no admin rights needed.
:: Expected layout (all inside the downloaded repo):
::   setup.bat
::   FirefoxPack\firefox.zip.001, firefox.zip.002, ...   (or a single firefox.zip)

set "SCRIPT_DIR=%~dp0"
set "PACK=%SCRIPT_DIR%FirefoxPack"
set "ZIP_PATH=%PACK%\firefox.zip"
set "TEMP_ZIP="
set "DEST=%LOCALAPPDATA%\FirefoxPortable"
set "PROFILE_DIR=%DEST%\Profile"

where tar >nul 2>&1
if errorlevel 1 goto :notar

:: Use a single zip if present, otherwise join the split parts
if exist "%ZIP_PATH%" goto :havezip
if not exist "%PACK%\firefox.zip.001" goto :nozip

echo Joining zip parts...
set "TEMP_ZIP=%TEMP%\firefox_joined.zip"
copy /b "%PACK%\firefox.zip.*" "%TEMP_ZIP%" >nul
if errorlevel 1 goto :joinfail
set "ZIP_PATH=%TEMP_ZIP%"

:havezip
echo Extracting to: "%DEST%"
if not exist "%DEST%" mkdir "%DEST%"
if not exist "%PROFILE_DIR%" mkdir "%PROFILE_DIR%"

tar -xf "%ZIP_PATH%" -C "%DEST%"
if errorlevel 1 goto :extractfail

if defined TEMP_ZIP del "%TEMP_ZIP%" 2>nul

:: Find firefox.exe wherever it ended up inside the extracted folder
set "FF_EXE="
for /f "delims=" %%F in ('dir /s /b "%DEST%\firefox.exe" 2^>nul') do if not defined FF_EXE set "FF_EXE=%%F"
if not defined FF_EXE goto :noexe

for %%I in ("%FF_EXE%") do set "FF_DIR=%%~dpI"
echo Found Firefox: "%FF_EXE%"

:: Desktop shortcut that keeps the profile in the same folder
powershell -NoProfile -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut([Environment]::GetFolderPath('Desktop')+'\Firefox.lnk'); $s.TargetPath=$env:FF_EXE; $s.Arguments='-profile '+[char]34+$env:PROFILE_DIR+[char]34; $s.WorkingDirectory=$env:FF_DIR; $s.Save()"
if errorlevel 1 goto :shortcutfail

echo Desktop shortcut created.
echo Done. Launch Firefox from the shortcut or from "%FF_EXE%".
goto :end

:nozip
echo ERROR: No Firefox files found in "%PACK%"
echo Make sure the whole repo was downloaded and extracted, including FirefoxPack.
goto :end

:notar
echo ERROR: 'tar' was not found. This needs Windows 10 or 11.
goto :end

:joinfail
echo ERROR: Could not join the zip parts.
goto :end

:extractfail
echo ERROR: Extraction failed. A part may be missing or incomplete.
if defined TEMP_ZIP del "%TEMP_ZIP%" 2>nul
goto :end

:noexe
echo ERROR: firefox.exe was not found after extraction.
goto :end

:shortcutfail
echo WARNING: Could not create the desktop shortcut.
echo You can still run Firefox directly from "%FF_EXE%".

:end
endlocal
pause
