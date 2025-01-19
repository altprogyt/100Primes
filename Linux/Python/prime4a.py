#!/usr/bin/python3
#-----------------------------------------------------------------------------------------------------------------------
# prime4:   Generate the first 100 prime numbers.
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

format_string = "%20i: %20li\n"

if num_primes == 1:
    file.write(format_string % (1, 2))
    sys.stderr.write("1 prime found.\n")
    sys.exit(0)

primes = [(2, 4), (3, 9)]
number = 3

for count in range(3, 1 + num_primes):
    while True:
        number = 2 + number

        for prime_data in list(x for x in primes if x[1] <= number):
            remainder = number % prime_data[0]
            if remainder == 0:
                break
        else:
            new_prime = (number, number * number)
            primes.append(new_prime)
            break
    if (count % 1000) == 0:
        file.flush()
        sys.stderr.write("%d primes found\n" % count)

for i in range(count):
    file.write(format_string % (i, primes[i][0]))

sys.stderr.write("%d primes found\n" % count)
file.close()
sys.exit(0)
