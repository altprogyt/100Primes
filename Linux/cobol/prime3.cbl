      ******************************************************************
      * prime3: Generate the first 100 primes                          *
      ******************************************************************
       identification division.
       program-id. prime3.

       environment division.

       data division.

       local-storage section.

       01  filler.
           05  ls-number                   binary-int value 1.
           05  ls-count                    binary-int.
           05  ls-divisor                  binary-int.
           05  ls-divisor-sq               binary-int.
           05  ls-quotient                 binary-int.
           05  ls-remainder                binary-int.
           05  filler                      pic x(01) value 'N'.
               88  is-prime                value 'Y' false 'N'.
           05  filler                      pic x(07).
           05  ls-display-area.
               10  ls-disp-prefix          pic z(07)9(01).
               10  filler                  pic x(02) value ': '.
               10  ls-disp-number          pic z(07)9(01).
               10  filler                  pic x(06) value spaces. 

       procedure division.

       0000-main.
           move 1 to ls-disp-prefix
           move 2 to ls-disp-number
           display ls-display-area

           perform varying ls-count from 2 by 1 until ls-count > 1000
               set is-prime to false

               perform until is-prime
                   add 2 to ls-number
                   move 3 to ls-divisor
                   multiply ls-divisor by ls-divisor 
                           giving ls-divisor-sq
                   set is-prime to true

                   perform until ls-divisor-sq > ls-number
                       divide ls-number by ls-divisor giving ls-quotient
                               remainder ls-remainder
                       if ls-remainder = zero
                           set is-prime to false
                           exit perform
                       else
                           add 2 to ls-divisor
                           multiply ls-divisor by ls-divisor 
                                   giving ls-divisor-sq
                       end-if
                   end-perform

                   if is-prime
                       move ls-count to ls-disp-prefix
                       move ls-number to ls-disp-number
                       display ls-display-area
                   end-if
               end-perform
           end-perform

           goback
           .
