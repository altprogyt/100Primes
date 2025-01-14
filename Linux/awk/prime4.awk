#!/usr/bin/awk -f

BEGIN {
    primes[0]=2
    primesquares[0]=4
    print 2

    primes[1]=3
    primesquares[1]=9
    print 3

    number=3

    for (count=2; count<=99; count++) {
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
                print number
            }
        } while (!isprime)
    }
}
