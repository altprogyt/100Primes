@echo off
:: prime2 - Generate the first 100 primes.

setlocal

:: Starting values
echo 1: 2
echo 1: 2 >&2
set /a number=1
for /l %%a in (2;1;100) do call :nextprime %%a

endlocal
exit /b

:nextprime

set id=%1

:do_1
    set /a number=2+number
    set /a divisor=3
    set isprime=true
    set /a test=number-divisor

    :while_1
    if not "%isprime%" == "true" goto end_while_1
    if %test% leq 0 goto end_while_1
        set /a remainder=number-divisor*(number/divisor)
        if %remainder% == 0 (
            set isprime=false
        ) else (
            set /a divisor=2+divisor
        )
        set /a test=number-divisor
    goto while_1
    :end_while_1

    if "%isprime%" == "true" (
        echo %number%
        :: echo %id%: %number%
        :: echo %id%: %number% >&2
    )

if "%isprime%" == "true" goto end_do_1
goto do_1
:end_do_1

goto :eof