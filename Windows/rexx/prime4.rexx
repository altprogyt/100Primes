#!/usr/bin/rexx
/******************************************************************************/
/* prime3:  Generate the first 100 prime numbers.                             */
/******************************************************************************/

trace 'o'

primes.1.prime=2
primes.1.square=4
primes.2.prime=3
primes.2.square=9

number=3
isprime=0

do i=3 to 100
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
end

do i=1 to 100
    say primes.i.prime
end

