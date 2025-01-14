#!/usr/bin/awk -f

BEGIN {
    print 2
    number=1

    for (count=2; count<=100; count++) {
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
                print number
            }
        } while (!isprime)
    }
}
