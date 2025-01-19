#!/usr/bin/awk -f

BEGIN {
    primes[1]=2
    primesquares[0]=4
    primes[2]=3
    primesquares[1]=9

    number=3
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

    if (max_primes==1) {
        print "1 prime found." > stderr
        exit
    }

    printf(output_format, 2, 3) >> out_file

    for (count=3; count<=max_primes; count++) {
        do {
            number+=2
            primepointer=1
            divisor=primes[primepointer]
            divisorsquare=primesquares[primepointer]
            isprime=1
            
            while (isprime && divisorsquare<=number) {
                remainder=number%divisor
                if (remainder==0) {
                    isprime=0
                } else {
                    primepointer+=1
                    divisor=primes[primepointer]
                    divisorsquare=primesquares[primepointer]
                }
            }
            if (isprime) {
                primes[count]=number
                primesquares[count]=number*number
                printf(output_format, count, number) >> out_file

                if (!(count%1000)) {
                    printf("%d primes found.\n", count) > stderr
                }
            }
        } while (!isprime)
    }
    printf("\n%d primes found.\n", count-1) > stderr
}
