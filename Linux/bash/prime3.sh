#!/bin/bash

# Main
echo 2
number=1
for count in {2..100}; do
    while true; do
        (( number += 2 ))
        divisor=3
        (( divisorsquare = divisor * divisor ))
        isprime=1
        while (( isprime )) && (( divisorsquare <= number )) ; do
            (( remainder = number % divisor ))
            if (( remainder == 0 )) ; then
                isprime=0
                break
            else
                divisor=$(( 2 + $divisor ))
                divisorsquare=$(( $divisor * $divisor ))
            fi
        done
        if (( isprime )) ; then
            echo $number
            break
        fi
    done
done
