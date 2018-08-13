@echo off
setlocal enabledelayedexpansion
title %~nx0
cd ..
set "scp=%cd%"
choice /c en /n /m "Are there existing logkillers [e=existing, n=no]?"
if errorlevel 2 goto askscp
if errorlevel 1 goto delscp

:delscp
cd "%~dp0\..\servers"
for /f "tokens=*" %%A in ('dir /b /a:d') do (
        if exist "%%A\logs\$scp_logkiller.bat" (
            DEL $scp_logkiller.bat
            goto delma
        ) else (
            cd %scp%\logs
            DEL $scp_logkiller.bat
            goto delma
        )
)
:delma
cd /d %scp%
cd "%~dp0\..\servers"
for /f "tokens=*" %%A in ('dir /b /a:d') do (
        if exist "%%A\logs\$ma_logkiller.bat" (
            DEL $ma_logkiller.bat
            goto delround
        ) else (
            cd %scp%\logs
            DEL $ma_logkiller.bat
            goto delround
        )
)
:delround
cd /d "%AppData%\SCP Secret Laboratory\ServerLogs"
for /f "tokens=*" %%A in ('dir /b /a:d') do (
    if exist %%A\$round_logkiller.bat (
        DEL $round_logkiller.bat
        goto delat
    ) else (
        goto delat
    )
)
:delat
cd /d "%AppData%\SCP Secret Laboratory\ATServerLogs"
for /f "tokens=*" %%A in ('dir /b /a:d') do (
    if exist %%A\$at_logkiller.bat (
        DEL $at_logkiller.bat
        goto askscp
    ) else (
        goto askscp
    )
)

:askscp
cls
choice /c yn /n /m "Create SCP logfile killers [y=yes, n=no]?"
if errorlevel 2 goto askma
if errorlevel 1 goto scpyes

:askma
cls
choice /c yn /n /m "Create MA logfile killers [y=yes, n=no]?"
if errorlevel 2 goto askround
if errorlevel 1 goto mayes

:askround
cls
choice /c yn /n /m "Create Round logfile killers [y=yes, n=no]?"
if errorlevel 2 goto askat
if errorlevel 1 goto roundyes

:askat
cls
choice /c yn /n /m "Is AdminToolbox installed with logfile creation [y=yes, n=no]?"
if errorlevel 2 goto none
if errorlevel 1 goto atinstalled

:atinstalled
cls
choice /c yn /n /m "Create AdminToolbox logfile killers [y=yes, n=no]?"
if errorlevel 2 goto none
if errorlevel 1 goto atyes

:none
cd /d %scp%
cls
echo We seem to have run out of options...
echo (press any key to exit)
pause >NUL
exit

:scpyes
cd /d %scp%
set /p days="Enter amount of days you want to keep the SCP logs for: "
if exist servers (
    echo Multiple server mode detected!
    cd servers
    cd "%~dp0\..\servers"
    for /f "tokens=*" %%A in ('dir /b /a:d') do (
        if exist "%%A\logs" (
            echo Found logs folder, switching directories...
            pushd "%%A\logs"
            echo forfiles /s /m *SCP_output_log.txt /D -%days% /C "cmd /c del @file" >> $scp_logkiller.bat
            echo exit >> $scp_logkiller.bat
            popd
            echo SCP logkiller creation completed.
            goto askma
        ) else (
            echo Logs folder not found!
            goto End
        )
    )
) else (
    echo Single server mode detected!
    cd "%~dp0\..\logs"
    echo forfiles /s /m *SCP_output_log.txt /D -%days% /C "cmd /c del @file" >> $scp_logkiller.bat
    echo exit >> $scp_logkiller.bat
    echo SCP logkiller creation completed.
    goto askma
)



:mayes
cd /d %scp%
set /p days="Enter amount of days you want to keep the MA logs for: "
if exist servers (
    echo Multiple server mode detected!
    cd servers
    cd "%~dp0\..\servers"
    for /f "tokens=*" %%A in ('dir /b /a:d') do (
        if exist "%%A\logs" (
            echo Found logs folder, switching directories...
            pushd "%%A\logs"
            echo forfiles /s /m *MA_output_log.txt /D -!days! /C "cmd /c del @file" >> $ma_logkiller.bat
            echo exit >> $ma_logkiller.bat
            popd
            echo MA logkiller creation completed.
            goto askround
        ) else (
            echo Logs folder not found!
            goto End
        )
    )
) else (
    echo Single server mode detected!
    cd "%~dp0\..\logs"
    echo forfiles /s /m *MA_output_log.txt /D -!days! /C "cmd /c del @file" >> $ma_logkiller.bat
    echo exit >> $ma_logkiller.bat
    echo MA logkiller creation completed.
    goto askround
)


:roundyes
set /p days="Enter amount of days you want the round logs kept for: "
cd /d "%AppData%\SCP Secret Laboratory\ServerLogs"
for /f "tokens=*" %%A in ('dir /b /a:d') do (
    echo forfiles /s /m *.txt /D -!days! /C "cmd /c del @file" >> %%A\$round_logkiller.bat
    echo exit >> %%A\$round_logkiller.bat
)
echo Round logkiller creation completed.
goto askat

:atyes
set /p days="Enter amount of days you want the AT logs kept for: "
cd /d "%AppData%\SCP Secret Laboratory\ATServerLogs"
for /f "tokens=*" %%A in ('dir /b /a:d') do (
    echo forfiles /s /m *.txt /D -!days! /C "cmd /c del @file" >> %%A\$at_logkiller.bat
    echo exit >> %%A\$at_logkiller.bat
)
goto End

:End
exit