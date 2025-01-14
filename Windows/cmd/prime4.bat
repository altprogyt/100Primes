@echo off
:: prime4 - Generate the first 100 primes.

setlocal

:: Starting values
echo 1: 2
echo 1: 2 >&2
set /a primes_0=2
set /a primesquares_0=4

echo 2: 3
echo 2: 3 >&2
set /a primes_1=3
set /a primesquares_1=9

set /a number=3
for /l %%a in (2;1;99) do call :nextprime %%a

endlocal
exit /b

:nextprime

set id=%1

:do_1
    set /a number=2+number
    set /a primepointer=1
    set /a divisor=primes_%primepointer%
    set /a divsquare=primesquares_%primepointer%
    set isprime=true
    set /a test=number-divsquare

    :while_1
    if not "%isprime%" == "true" goto end_while_1
    if %test% lss 0 goto end_while_1
        set /a remainder=number-divisor*(number/divisor)
        if %remainder% == 0 (
            set isprime=false
        ) else (
            set /a primepointer=1+primepointer
            set /a divisor=primes_%primepointer%
            set /a divsquare=primesquares_%primepointer%
        )
        set /a test=number-divsquare
    goto while_1
    :end_while_1

    if "%isprime%" == "true" (
        set /a primes_%id%=number
        set /a primesquares_%id%=number*number
        set /a label=1+id
        echo %label%: %number%
    )
    :: if "%isprime%" == "true" (
        :: set /a label=1+id
        :: echo %label%: %number%
        :: echo %label%: %number% >&2
    :: )

if "%isprime%" == "true" goto end_do_1
goto do_1
:end_do_1

goto :eof