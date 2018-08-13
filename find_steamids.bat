@echo off
if exist results.csv (
    echo Removing old results...
    DEL results.csv
    echo .
    echo .
    echo .
    echo Done!
) else (
    goto Start
)

:Start
cd ..
if exist "servers" (
    echo MultiAdmin is in multiple server mode, switching directories...
    cd servers
    goto MultServer
) else (
    echo Servers folder does not exist, checking for single server log folder!
    goto SingleServer
)

:MultServer
cd "%~dp0\..\servers"
for /f "tokens=*" %%A in ('dir /b /a:d') do (
    if exist "%%A\logs" (
        echo Found logs folder, switching directories...
        pushd "%%A\logs"
        if exist "*_MA_output_log.txt" (
            echo Found file, executing code
            echo .
            echo .
            echo .
            findstr /R 76561*  "*_MA_output_log.txt" >> "..\..\..\tools\pre-results.txt"
            goto Parse
        ) else (
            echo MultiAdmin output does not exist!
            goto End
        )
        popd
    ) else (
        echo Logs folder not found!
        goto End
    )
)

:SingleServer
if exist "logs" (
    echo Found logs folder, switching directories...
    cd "logs"
) else (
    echo Are you sure you put this in the right place?
    goto End
)
findstr /R 76561*  "*_MA_output_log.txt" >> "..\tools\pre-results.txt"
goto Parse

:Parse
cd ..\..\..\tools
echo Trimming results...
for /f "tokens=7 delims= " %%a in (pre-results.txt) do @echo %%a >> results.csv
echo Done!
goto End

:End
DEL pre-results.txt
echo Press any key to close...
pause >NUL
exit