#!/usr/bin/python3
#-----------------------------------------------------------------------------------------------------------------------
# prime3:   Generate the first 100 prime numbers.
#-----------------------------------------------------------------------------------------------------------------------

print(2)
number = 1

for count in range(99):
    isprime = False

    while not isprime:    #This simulates a Do Loop
        number = 2 + number
        divisor = 3
        divisor_square = divisor * divisor
        isprime = True

        while divisor_square <= number:
            remainder = number % divisor

            if remainder == 0:
                isprime = False
                break
            else:
                divisor = 2 + divisor
                divisor_square = divisor * divisor
        else:
            print(number)
