#!/usr/bin/awk -f

BEGIN {
    number=1
    stderr="/dev/stderr"
    max_primes=100  
    out_file="/dev/stdout"
    OFMT="%20i"

    if (1 in ARGV) {
        max_primes=ARGV[1]

        if (max_primes !~ /^[1-9][0-9]*$/) {
            max_primes=100
        }
    }

    if (2 in ARGV) {
        out_file=ARGV[2]
    }

    output_format=OFMT ":" OFMT "\n"
    printf(output_format, 1, 2) > out_file

    for (count=2; count<=max_primes; count++) {
        do {
            number+=2
            divisor=3
            divisorsquare=9
            isprime=1
            
            while (isprime && divisorsquare<=number) {
                remainder=number%divisor
                if (remainder==0) {
                    isprime=0
                } else {
                    divisor+=2
                    divisorsquare=divisor*divisor
                }
            }
            if (isprime) {
                printf(output_format, count, number) >> out_file

                if (!(count%1000)) {
                    printf("%d primes found.\n", count) > stderr
                }
            }
        } while (!isprime)
    }
    printf("\n%d primes found.\n", count-1) > stderr
}