#!/usr/bin/rexx
/******************************************************************************/
/* prime3:  Generate the first 100 prime numbers.                             */
/******************************************************************************/

trace 'o'
numeric digits 20

parse arg prime_count prime_file

prime_count=get_decimal(prime_count)

if prime_count<1 then do
    prime_count=100
end

number=1
isprime=0

if prime_file<>'' then do
    result=stream(prime_file, 'C', 'QUERY EXISTS')
    if result=prime_file then do
        address cmd 'rm' prime_file
    end
    result=stream(prime_file, 'C', 'WRITE')
    if result<>'' then do
        call lineout 'stderr', 'Error opening 'prime_file'.'
        prime_file='stdout'
    end
end
else do
    prime_file='stdout'
end

call lineout prime_file, print_prime(1, 2)

do i=2 to prime_count
    do forever
        number=2+number
        divisor=3
        divisor_square=divisor*divisor
        isprime=1

        do while number>=divisor_square
            remainder=number//divisor

            if remainder=0 then do
                isprime=0
                leave
            end
            else do
                divisor=2+divisor
                divisor_square=divisor*divisor
            end
        end

        if isprime=1 then do
            call lineout prime_file, print_prime(i, number)
            leave
        end
    end

    if i//1000=0 then do
        call lineout 'stderr', i || ' primes found.'
    end
end

call lineout prime_file
call lineout 'stderr', prime_count || ' primes found.'
exit 0

get_decimal: procedure
    arg text
    text=strip(text)
    int_value=0

    do i=1 to length(text)
        char=substr(text, i, 1)
        if char<'0' | char>'9' then do
            iterate
        end
        int_value=int_value*10 + (char - '0')
    end

    return int_value

print_prime: procedure
    arg prime_index, prime_value
    return_text=right(prime_index, 20)': 'right(prime_value, 20)
    return return_text