      ******************************************************************
      * prime3: Generate the first 100 primes                          *
      ******************************************************************
       identification division.
       program-id. prime5a.

       environment division.

       input-output section.

       file-control.
           select  standard-error assign '/dev/stderr'
                   organization is line sequential
                   access mode is sequential
                   file status is ls-stderr-status
                   .
           select  output-file assign ls-output-file
                   organization is line sequential
                   access mode is sequential
                   file status is ls-output-status
                   .

       data division.

       file section.

       fd  standard-error.
       01  standard-error-line             pic x(256).

       fd  output-file.
       01  output-line                     pic x(80).

       local-storage section.

       78  c-stdout                        value '/dev/stdout'.

       *> List pointers
       77  ls-prime-head                   usage pointer.
       77  ls-prime-ptr                    usage pointer.
       77  ls-prime-temp                   usage pointer.

       01  prime-data                      based.
           05  pd-next                     usage pointer.
           05  pd-seq                      binary-int unsigned.
           05  pd-value                    binary-int unsigned.
           05  pd-square                   binary-long unsigned.

       01  filler.                         *> Misc variables
           05  ls-number                   binary-int value 1.
           05  ls-count                    binary-int unsigned.
           05  ls-count-display            pic z(19)9(01).
           05  ls-divisor                  binary-int unsigned.
           05  ls-divisor-sq               binary-long unsigned.
           05  ls-quotient                 binary-int unsigned.
           05  ls-remainder                binary-int unsigned.
           05  ls-count-quotient           binary-int unsigned.
           05  ls-count-remainder          binary-int unsigned.
           05  ls-max-primes               binary-int unsigned 
                                           value 100.
           05  switches.
               10  filler                  pic x(01) value 'N'.
                   88  is-prime            value 'Y' false 'N'.
               10  filler                  pic x(01) value 'N'.
                   88  found-first-digit   value 'Y' false 'N'.
               10  filler                  pic x(01) value 'N'.
                   88  fatal-error         value 'Y' false 'N'.
               10  filler                  pic x(05).
           05  ls-arguments                pic x(256) value spaces.
           05  ls-output-file              pic x(256) value spaces.
           05  ls-dummy-arg                pic x(256).
           05  ls-number-parse-area.
               10  ls-max-primes-temp      pic 9(20) value zero.
               10  filler redefines ls-max-primes-temp.
                   15  ls-max-primes-tc    pic 9(01) occurs 20 times.
               10  ls-max-primes-text      pic x(20) value spaces.
               10  filler redefines ls-max-primes-text.
                   15  ls-max-primes-txc   pic x(01) occurs 20 times.
               10  ls-digit-count          binary-int value zero.
               10  ls-max-primes-x         pic x(20).
               10  filler redefines ls-max-primes-x.
                   15  ls-max-primes-c     pic x(01) occurs 20 times.
                       88  is-primes-digit values '0' thru '9'.
               10  filler redefines ls-max-primes-x.
                   15  ls-max-primes-9     pic 9(01) occurs 20 times.
               10  filler                  pic x(04).
           05  ls-display-area.
               10  ls-disp-prefix          pic z(19)9(01).
               10  filler                  pic x(02) value ': '.
               10  ls-disp-number          pic z(19)9(01).
               10  filler                  pic x(06) value spaces. 
           05  file-status.
               10  ls-stderr-status        pic 9(01)x(01).
                   88  sdterr-status-ok    value '00'.
               10  ls-output-status        pic 9(01)x(01).
                   88  output-status-ok    value '00'.
               10  filler                  pic x(04).

       procedure division.

       0000-main.
           open output standard-error
           if not sdterr-status-ok
               display 'Cannot open stderr!'
               goback
           end-if

           perform 1000-get-command-line

           if not fatal-error
               perform 2000-generate-primes
           end-if

           perform 3000-termination

           goback
           .
       1000-get-command-line.
           accept ls-arguments from command-line
           unstring ls-arguments delimited by spaces
               into ls-max-primes-x ls-output-file ls-dummy-arg

           perform 4000-parse-max-primes

           if ls-output-file = spaces
               move c-stdout to ls-output-file
           end-if

           open output output-file
           if not output-status-ok
               move c-stdout to ls-output-file
               open output output-file
               
               if not output-status-ok
                   display 'Error ' ls-output-status 
                           ' opening output stream.'
                   set fatal-error to true
                   exit paragraph
               end-if
           end-if
           .
       2000-generate-primes.
           perform 4100-allocate-first-prime
           move 1 to ls-count

           if fatal-error
               exit paragraph
           end-if

           if ls-max-primes > 1
               move 2 to ls-count
               move 3 to ls-number

               perform 4200-allocate-next-prime

               if fatal-error
                   exit paragraph
               end-if

               perform varying ls-count from 3 by 1 
                       until ls-count > ls-max-primes

                   perform until exit
                       add 2 to ls-number
                       set is-prime to true
                       set ls-prime-temp to ls-prime-head
                       set address of prime-data to ls-prime-temp
                       move pd-value to ls-divisor
                       move pd-square to ls-divisor-sq

                       perform until ls-divisor-sq > ls-number
                           divide ls-number by ls-divisor 
                                   giving ls-quotient
                                   remainder ls-remainder
                           if ls-remainder = zero
                               set is-prime to false
                               exit perform
                           else
                               set ls-prime-temp to pd-next

                               if ls-prime-temp = null
                                   exit perform
                               end-if

                               set address of prime-data 
                                       to ls-prime-temp
                               move pd-value to ls-divisor
                               move pd-square to ls-divisor-sq
                          end-if
                       end-perform

                       if is-prime
                           perform 4200-allocate-next-prime
                           
                           exit perform
                       end-if
               
                   end-perform

                   divide ls-count by 1000 giving ls-count-quotient
                           remainder ls-count-remainder
                   if ls-count-remainder = zero
                       move ls-count to ls-count-display
                       display ls-count-display ' primes found.'
                   end-if

                   if fatal-error
                       exit perform
                   end-if
               end-perform

               if fatal-error
                   exit paragraph
               end-if
           end-if
           .
       3000-termination.  
           set ls-prime-ptr to ls-prime-head

           perform until ls-prime-ptr = null
               set address of prime-data to ls-prime-ptr
               move pd-seq to ls-disp-prefix
               move pd-value to ls-disp-number
               move ls-display-area to output-line
               write output-line

               set ls-prime-ptr to pd-next
           end-perform

           if not fatal-error
               string  ls-max-primes-text  delimited by space
                       ' primes found.'     delimited by size
                       into standard-error-line
               write standard-error-line
           end-if

           close standard-error output-file

           perform 4300-free-primes
           .
       4000-parse-max-primes.
           set found-first-digit to false
           move 0 to ls-max-primes-temp
                     ls-digit-count
           move spaces to ls-max-primes-text

           perform varying ls-count from 1 by 1 until ls-count > 20
               if is-primes-digit(ls-count)
                   if not found-first-digit
                       set found-first-digit to true
                   end-if

                   compute ls-max-primes-temp = 
                           ls-max-primes-temp * 10 +
                           ls-max-primes-9(ls-count)
                   add 1 to ls-digit-count  
               else
                   if found-first-digit
                       exit perform
                   end-if
               end-if
           end-perform

           if ls-max-primes-temp > 0
               move ls-max-primes-temp to ls-max-primes

               perform varying ls-count from ls-digit-count by -1 
                       until ls-count <= zero
                   move ls-max-primes-tc(21 - ls-count) to 
                       ls-max-primes-txc(1 + ls-digit-count - ls-count)
               end-perform
           else
               move '100' to ls-max-primes-text
           end-if
           .
       4100-allocate-first-prime.
           move null to ls-prime-head
                        ls-prime-ptr
                        ls-prime-temp

           call 'malloc' using by value length of prime-data
                               returning ls-prime-head

           if ls-prime-head = null
               display 'Error allocating memory to first prime.'
               set fatal-error to true
               exit paragraph
           end-if

           set address of prime-data to ls-prime-head
           move 1 to pd-seq
           move 2 to pd-value
           move 4 to pd-square
           move null to pd-next
           move ls-prime-head to ls-prime-ptr
           .
       4200-allocate-next-prime.
           call 'malloc' using by value length of prime-data
                               returning ls-prime-temp

           if ls-prime-temp = null
               display 'Error allocating memory to next prime.'
               set fatal-error to true
               exit paragraph
           end-if

           set address of prime-data to ls-prime-ptr
           set pd-next to ls-prime-temp

           set address of prime-data to ls-prime-temp
           move ls-count to pd-seq
           move ls-number to pd-value
           multiply ls-number by ls-number giving pd-square
           set pd-next to null

           set ls-prime-ptr to ls-prime-temp
           .
       4300-free-primes.
           set ls-prime-ptr to ls-prime-head

           perform until ls-prime-ptr = null
               set address of prime-data to ls-prime-ptr
               set ls-prime-temp to pd-next
               call 'free' using by value ls-prime-ptr
               set ls-prime-ptr to ls-prime-temp
           end-perform
           .
