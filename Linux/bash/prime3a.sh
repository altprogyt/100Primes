#!/bin/bash

# Main
out_file=${2:-/dev/stdout}
>$out_file
temp_file=$(mktemp)

max_primes=$(echo ${1:-100} | awk -v value=100 '/^[1-9][0-9]*$/{value=$0}END{print value}')

echo "2">$temp_file
number=1
count=2

while (( count <= max_primes )); do
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
            echo $number>>$temp_file
            break
        fi
    done

    if (( count % 1000 == 0 )) ; then
        echo "$count primes found." >&2
    fi

    (( count += 1 ))
done

awk -v out_file=$out_file '
    BEGIN {
        OFMT="%20i"
        output_format=OFMT ": " OFMT "\n"
    }
    {
        printf(output_format, NR, $0) >> out_file
    }
' $temp_file >$out_file

echo "$((count-1)) primes found." >&2
exit 0
