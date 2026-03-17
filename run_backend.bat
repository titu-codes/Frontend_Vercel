@echo off
echo Starting HRMS Backend...
cd /d "%~dp0backend"
set USE_SQLITE=true
python start_server.py
pause
