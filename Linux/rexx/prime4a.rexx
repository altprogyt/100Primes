#!/usr/bin/rexx
/******************************************************************************/
/* prime4:  Generate the first 100 prime numbers.                             */
/******************************************************************************/

trace 'o'
numeric digits 20

parse arg prime_count prime_file

prime_count=get_decimal(prime_count)

if prime_count<1 then do
    prime_count=100
end

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

if prime_count=1 then do
    call lineout prime_file, print_prime(1, 2)
    call lineout prime_file
    call lineout 'stderr', '1 prime found.'
    exit 0
end

primes.1.prime=2
primes.1.square=4
primes.2.prime=3
primes.2.square=9
number=3
isprime=0

do i=3 to prime_count
    do forever
        number=2+number
        prime_index=2
        isprime=1

        do while number>=primes.prime_index.square
            remainder=number//primes.prime_index.prime

            if remainder=0 then do
                isprime=0
                leave
            end
            else do
                prime_index=1+prime_index
            end
        end

        if isprime=1 then do
            primes.i.prime=number
            primes.i.square=number*number
            leave
        end
    end

    if i//1000=0 then do
        call lineout 'stderr', i || ' primes found.'
    end
end

do i=1 to prime_count
    call lineout prime_file, print_prime(i, primes.i.prime)
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