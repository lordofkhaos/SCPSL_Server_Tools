@echo off
setlocal enabledelayedexpansion
title %~nx0
cd ..
set "scp=%cd%"
echo %scp%

choice /c yn /n /m "Run logkillers [y=yes, n=no]?"
if errorlevel 2 goto no
if errorlevel 1 goto exscp

:exscp
cd %scp%
echo Executing SCP logkiller...
if exist ("*\logs\$scp_logkiller.bat") in "servers" (
    cd servers
    cd "%~dp0\..\servers"
    for /f "tokens=*" %%A in ('dir /b /a:d') do (
        if exist "%%A\logs" (
            echo Found logs folder, switching directories...
            pushd "%%A\logs"
            start "" /min $scp_logkiller.bat
            popd
            echo Successfully executed $scp_logkiller.bat
            echo.
            goto exma
        ) else (
            echo Logs folder not found!
            echo.
            goto End
        )
    )
) if exist ("$scp_scplogkiller.bat") in ("%scp%\logs\") (
    cd "%~dp0\..\logs"
    start "" /min $scp_logkiller.bat
    echo Successfully executed $scp_logkiller.bat
    echo.
    goto exma
) else (
    echo $scp_logkiller.bat not found, skipping
)

:exma
cd %scp%
echo Executing MA logkiller...
if exist ("*\logs\$ma_logkiller.bat") in "servers" (
    cd servers
    cd "%~dp0\..\servers"
    for /f "tokens=*" %%A in ('dir /b /a:d') do (
        if exist "%%A\logs" (
            echo Found logs folder, switching directories...
            pushd "%%A\logs"
            start "" /min $ma_logkiller.bat
            popd
            echo Successfully executed $ma_logkiller.bat
            echo.
            goto exround
        ) else (
            echo Logs folder not found!
            echo.
            goto End
        )
    )
) if exist ("$ma_scplogkiller.bat") in ("%scp%\logs\") (
    cd "%~dp0\..\logs"
    start "" /min $ma_logkiller.bat
    echo Successfully executed $ma_logkiller.bat
    echo.
    goto exround
) else (
    echo $ma_logkiller.bat not found, skipping
)


:exround
cd /d "%AppData%\SCP Secret Laboratory\ServerLogs"
for /f "tokens=*" %%A in ('dir /b /a:d') do (
    if exist %%A\$round_logkiller.bat (
        cd %%A
        start /min "" $round_logkiller.bat
        echo Done
        echo.
        goto exat
    ) else (
        echo Round logkiller not found, skipping!
        echo.
        goto exat
    )
)

:exat
cd /d "%AppData%\SCP Secret Laboratory\ATServerLogs"
for /f "tokens=*" %%A in ('dir /b /a:d') do (
    if exist %%A\$at_logkiller.bat (
        cd %%A
        start /min "" $at_logkiller.bat
        goto end
    ) else (
        echo AdminToolbox logkiller not found, skipping!
        goto end
    )
)

:end
echo Logkiller execution complete!
echo press any key to exit...
pause >NUL
exit

:no
echo Logkiller execution aborted!
echo press any key to exit...
pause >NUL
taskkill /im cmd.exe /f /t
exit