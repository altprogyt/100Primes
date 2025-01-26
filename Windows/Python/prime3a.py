#!/usr/bin/python3
#-----------------------------------------------------------------------------------------------------------------------
# prime3:   Generate the first 100 prime numbers.
#-----------------------------------------------------------------------------------------------------------------------

import sys

try:
    num_primes = int(sys.argv[1])
except (IndexError, ValueError):
    num_primes = 100
finally:
    if num_primes < 1:
        num_primes = 100

try:
    output_file = sys.argv[2]
    file = open(output_file, "w")
except IndexError:
    file = sys.stdout
except IOError:
    sys.stderr.write("Unable to open output file")
    file = sys.stdout

number = 1
format_string = "%20i: %20li\n"

file.write(format_string % (1, 2))

for count in range(2, 1 + num_primes):
    while True:    #This simulates a Do Loop
        number = 2 + number
        divisor = 3
        divisor_square = divisor * divisor

        while divisor_square <= number:
            remainder = number % divisor

            if remainder == 0:
                break
            else:
                divisor = 2 + divisor
                divisor_square = divisor * divisor
        else:
            file.write(format_string % (count, number))
            break
    if (count % 1000) == 0:
        file.flush()
        sys.stderr.write("%d primes found\n" % count)

sys.stderr.write("%d primes found\n" % count)
file.close()
sys.exit(0)
