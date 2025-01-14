#!/usr/bin/rexx
/******************************************************************************/
/* prime3:  Generate the first 100 prime numbers.                             */
/******************************************************************************/

trace 'o'

say 2
number=1
isprime=0

do i=2 to 100
    do forever
        number=2+number
        divisor=3
        divisor_square=divisor*divisor
        isprime=1

        do while number>=divisor_square
            remainder=number//divisor

            if remainder=0 then do
                isprime=0
                leave
            end
            else do
                divisor=2+divisor
                divisor_square=divisor*divisor
            end
        end

        if isprime=1 then do
            say number
            leave
        end
    end
end
