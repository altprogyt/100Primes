#!/bin/bash

declare -a primes=( $(for i in {1..100} ; do echo 0; done) )
declare -a primesquares=( $(for i in {1..100} ; do echo 0; done) )

echo 2
primes[0]=2
primesquares[0]=4
echo 3
primes[1]=3
primesquares[1]=9
number=3

for count in {2..99} ; do
    while true ; do
        (( number += 2 ))
        primepointer=1
        (( divisor = primes[primepointer] ))
        (( divisorsquare = primesquares[primepointer] ))
        isprime=1
        while (( isprime )) && (( divisorsquare <= number )) ; do
            (( remainder = number % divisor ))
            if (( remainder == 0 )); then
                isprime=0
                break
            else
                (( primepointer += 1 ))
                (( divisor = primes[primepointer] ))
                (( divisorsquare = primesquares[primepointer] ))
            fi
        done
        if (( isprime )) ; then
            (( primes[count] = number ))
            (( primesquares[count] = number * number ))
            echo $number
            break
        fi
    done
done
