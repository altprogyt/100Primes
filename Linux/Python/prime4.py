#!/usr/bin/python3
#-----------------------------------------------------------------------------------------------------------------------
# prime4:   Generate the first 100 prime numbers.
#-----------------------------------------------------------------------------------------------------------------------

primes = [(2, 4), (3, 9)]
number = 3

for count in range(2, 100):
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

for prime_data in primes:
    print(prime_data[0])
