rem**This file is for running API scans through AbuseIPDB by individual IP or by file.**

@echo off

:start
cls
echo.
echo Welcome to IP checker, a CMD tool for checking IP's abuse rating using AbuseIPDB.
echo.
echo ip (check a specific ip address)
echo file (iterate through an ip list and generate results)
echo results (view results of file search)
echo done (exit task)
echo.
set /p CHOICE= What do you want to do?: 
goto %CHOICE%

:ip
cls
set /p IP= What IP do you want to check? 
curl -s -G https://api.abuseipdb.com/api/v2/check --data-urlencode "ipAddress=%IP%" -d maxAgeInDays=90 -d verbose -H "Key: b22b6cca921f2c5b30b0dd94d9fe37fe615ef432ab14116df066d1e5fd588d28ebfcd8ff19ff5cb3" -H "Accept: application/json"  >> ipresults.json
echo.
goto start

:file
cls
set /p FILE= What file are your IPs stored in? 
for /f "Delims=" %%A in (%FILE%) do (
echo Scanning %%A
curl -s -G https://api.abuseipdb.com/api/v2/check --data-urlencode "ipAddress=%%A" -d maxAgeInDays=365 -H "Key: INSERT_YOUR_ABUSEIPDB_KEY_HERE" -H "Accept: application/json" >> %FILE%ipresults.json
echo \n >> %FILE%ipresults.json
)
pause
goto start

:results
start %FILE%ipresults.json
goto start

:done
echo.
echo Trust is like an eraser, it gets smaller after every mistake - Beluga
echo.
