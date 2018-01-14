setlocal enabledelayedexpansion

:: Number of colors to loop through.
SET MAXCOLORS=16777215
SET /p LASTTORUN=<LastColorToRun.txt
SET /a START=%LASTTORUN%+1

:: Hack to get Hex Color, Loop through all colors.
for /l %%x in (%START%, 1, %MAXCOLORS%) do (
   call ConvertToHex.bat %%x
)

endlocal
