@echo off
cd ..
title %~nx0
set "scp=%cd%"
setlocal enabledelayedexpansion

:init
choice /c yn /n /m "Delete interfacing [y=yes, n=no]?"
if errorlevel 2 goto retdisc
if errorlevel 1 goto askdisc

:askdisc
choice /c yn /n /m "Delete discord interfacing [y=yes, n=no]?"
if errorlevel 2 goto asksteam
if errorlevel 1 goto nodisc

:nodisc
cd %scp%
cd SCPSL_Data\Plugins
if exist "discord-rpc.dll" (
    DEL discord-rpc.dll
    echo Done
    echo.
    pause Press any key to continue...
    pause >nul
    goto asksteam
) else (
    echo Either the batchfile is in the wrong place or discord has already been removed
    echo Press any key to continue...
    echo.
    pause >nul
    goto asksteam
)

:asksteam
choice /c yn /n /m "Delete steam interfacing [y=yes, n=no]?"
if errorlevel 2 goto end
if errorlevel 1 goto nosteam

:nosteam
cd %scp%
if exist "steam_appid.txt" (
    DEL steam_appid.txt
    echo Done
    echo.
    pause Press any key to continue...
    pause >nul
    goto end
) else (
    echo Either the batchfile is in the wrong place or discord has already been removed
    echo Press any key to continue...
    echo.
    pause >nul
)

:retdisc
choice /c yn /n /m "Return discord-rpc.dll [y=yes, n=no]?"
if errorlevel 2 goto retsteam
if errorlevel 1 goto downdisc


:downdisc
cd %scp%
if exist "SCPSL_Data\Plugins" (
    echo Replacing discord-rpc.dll
    set "link=https://cdn.discordapp.com/attachments/470448742903054339/479009821971185665/discord-rpc.dll"
    powershell -command "& { $tls12 = [Enum]::ToObject([Net.SecurityProtocolType], 3072); [Net.ServicePointManager]::SecurityProtocol = $tls12; (New-Object Net.WebClient).DownloadFile('!link!', 'SCPSL_Data\Plugins\discord-rpc.dll') }"
    if exist "SCPSL_Data\Plugins\discord-rpc.dll" (
	    echo  Done.
	    echo  Download successful!
        echo.
        echo Press any key to continue...
        pause >nul
        goto 
    ) else (
	    echo  Download failed.
	    echo.
	    echo  Press any key to retry.
	    pause > nul
	    goto downdisc
    )
) else (
    echo ERROR: Batchfile in wrong place
    echo Press any key to continue...
    echo.
    pause >nul
    goto end
)

:retsteam
choice /c yn /n /m "Return steam_appid.txt [y=yes, n=no]?"
if errorlevel 2 goto end
if errorlevel 1 goto asksmod

:asksmod
choice /c yn /n /m "Is this an Smod server [y=yes, n=no]?"
if errorlevel 2 goto downvanilla
if errorlevel 1 goto downsmod

:downsmod
cd %scp%
if exist "%scp%\SCPSL_Data" (
    echo Replacing steam_appid.txt
    @echo 786920 >> steam_appid.txt
    if exist "steam_appid.txt" (
	    echo  Done.
	    echo  Download successful!
        echo.
        echo Press any key to continue...
        pause >nul
        goto end
    ) else (
	    echo  Download failed.
	    echo.
	    echo  Press any key to retry.
	    pause > nul
	    goto downsmod
    )
) else (
    echo ERROR: Batchfile in wrong place
    echo Press any key to continue...
    echo.
    pause >nul
    goto end
)

:downvanilla
cd %scp%
if exist "%scp%\SCPSL_Data" (
    echo Replacing steam_appid.txt
    @echo 700330 >> steam_appid.txt
    if exist "steam_appid.txt" (
	    echo  Done.
	    echo  Download successful!
        echo.
        echo Press any key to continue...
        pause >nul
        goto end
    ) else (
	    echo  Download failed.
	    echo.
	    echo  Press any key to retry.
	    pause > nul
	    goto downvanilla
    )
) else (
    echo ERROR: Batchfile in wrong place
    echo Press any key to continue...
    echo.
    pause >nul
    goto end
)

:end
cls
cd %scp%
echo Batchfile run complete
echo Courtesy of ^[Khaos^]
echo.
echo Press any key to exist...
pause >nul
exit