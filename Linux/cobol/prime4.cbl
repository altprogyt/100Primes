      ******************************************************************
      * prime4: Generate the first 100 primes                          *
      ******************************************************************
       identification division.
       program-id. prime4.

       environment division.

       data division.

       local-storage section.

       01  filler.
           05  sub1                        binary-int.
           05  ls-number                   binary-int value 3.
           05  ls-count                    binary-int.
           05  ls-divisor                  binary-int.
           05  ls-divisor-sq               binary-int.
           05  ls-quotient                 binary-int.
           05  ls-remainder                binary-int.
           05  filler                      pic x(01) value 'N'.
               88  is-prime                value 'Y' false 'N'.
           05  filler                      pic x(03).
           05  ls-prime-table-area.
               10  filler.
                   15  filler                  pic x(24)
                           value '       1:        2      '.
                   15  filler              binary-int value 2.
                   15  filler              binary-int value 4.
               10  filler.
                   15  filler                  pic x(24)
                           value '       2:        3      '.
                   15  filler              binary-int value 3.
                   15  filler              binary-int value 9.
               10  filler                  occurs 998 times.
                   15  filler              pic x(32)
                           value '        :               '.
           05  filler redefines ls-prime-table-area.
               10  ls-prime-info           occurs 1000 times.
                   15  ls-display-area.
                       20  ls-disp-prefix  pic z(07)9(01).
                       20  filler          pic x(02).
                       20  ls-disp-number  pic z(07)9(01).
                       20  filler          pic x(06).
                   15  ls-prime-number     binary-int.
                   15  ls-prime-square     binary-int. 

       procedure division.

       0000-main.
           perform varying ls-count from 3 by 1 until ls-count > 1000
               set is-prime to false
               
               perform until is-prime
                   add 2 to ls-number
                   set is-prime to true

                   perform varying sub1 from 1 by 1
                           until ls-prime-square(sub1) > ls-number
                       divide ls-number by ls-prime-number(sub1) 
                               giving ls-quotient
                               remainder ls-remainder
                       if ls-remainder = zero
                           set is-prime to false
                           exit perform
                       end-if
                   end-perform

                   if is-prime
                       move ls-count to ls-disp-prefix(ls-count)
                       move ls-number to ls-disp-number(ls-count)
                                         ls-prime-number(ls-count)
                       multiply ls-number by ls-number
                               giving ls-prime-square(ls-count)                 
                   end-if
               end-perform
           end-perform

           perform varying sub1 from 1 by 1 until sub1 > 1000
               display ls-display-area(sub1)
           end-perform

           goback
           .
