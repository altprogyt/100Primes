@echo off
:: Run the primes test
for /f "tokens=1" %%a in ('dir /b /on prime*.bat') do echo.&echo %%a&runtime %%a >%%a.log 2>&1
exit /b