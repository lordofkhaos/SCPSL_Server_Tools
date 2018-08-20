@echo off
title %~nx0
setlocal enabledelayedexpansion
set "tools=%cd%"
set "sc=NULL"

:asklogkillers
cd %tools%
choice /c yn /n /m "Auto run logkillers [y=yes, n=no]?"
if errorlevel 2 goto asksteam
if errorlevel 1 goto arl

:asksteam
cd %tools%
choice /c yn /n /m "Auto run find_steamids [y=yes, n=no]?"
if errorlevel 2 goto end
if errorlevel 1 goto ars

:arl
cd %tools%
choice /c mhd /n /m "Auto run how often [m=minute, h=hourly, d=daily]?"
if errorlevel 3 goto ldaily
if errorlevel 2 goto lhourly 
if errorlevel 1 goto lminute

:ldaily
set "sc=DAILY"
goto arl2

:lhourly
set "sc=HOURLY"
goto arl2

:lminute
set "sc=MINUTE"
goto arl2

:arl2
echo !sc!
set /p time="Enter every how often you want to run the logkillers: "
schtasks /create /sc !sc! /mo !time! /tn AUTORUN_LOGKILLERS /tr "%tools%\run_logkillers.bat"
echo Logkillers will be run every !time! !sc!
goto asksteam


:ars
cd %tools%
choice /c mhd /n /m "Auto run how often [m=minute, h=hourly, d=daily]?"
if errorlevel 3 goto sdaily
if errorlevel 2 goto shourly
if errorlevel 1 goto sminute

:sdaily
set "sc=DAILY"
goto ars2

:shourly
set "sc=HOURLY"
goto ars2

:sminute
set "sc=MINUTE"
goto ars2

:ars2
set /p time="Enter every how often you want to run the steamid finder: "
schtasks /sc !sc! /mo !time! /tn AUTORUN_FINDSTEAMIDS /tr "%tools%\find_steamids.bat"
echo "Steamid finder will be run every !time! !sc!"
goto end


:end
cls
echo "Autoruns complete^!"
exit