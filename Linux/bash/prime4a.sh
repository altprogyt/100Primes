#!/bin/bash

function print_output {(
    (( count = ${1:-2} - 1 ))
    awk -v out_file=$out_file '
        BEGIN {
            OFMT="%20i"
            output_format=OFMT ": " OFMT "\n"
        }
        {
            printf(output_format, NR, $0) >> out_file
        }
    ' $temp_file >$out_file

    echo "$count primes found." >&2
    return
)}

# Main
out_file=${2:-/dev/stdout}
>$out_file
temp_file=$(mktemp)

max_primes=$(echo ${1:-100} | awk -v value=100 '/^[1-9][0-9]*$/{value=$0}END{print value}')

eval "declare -a primes=( \$(for i in {1..$max_primes} ; do echo 0; done) )"
eval "declare -a primesquares=( \$(for i in {1..$max_primes} ; do echo 0; done) )"

echo "2">$temp_file
primes[0]=2
primesquares[0]=4

if (( max_primes == 1 )) ; then
    print_output
    exit 0
fi

echo "3">$temp_file
primes[1]=3
primesquares[1]=9
number=3
count=2

while (( count <= max_primes )); do
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
            echo $number>>$temp_file
            break
        fi
    done

    if (( count % 1000 == 0 )) ; then
        echo "$count primes found." >&2
    fi

    (( count += 1 ))
done

print_output $count
exit 0
