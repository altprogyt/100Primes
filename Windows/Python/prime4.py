primes = [0] * (25)
primesquares = [0] * (25)

print(2)
primes[0] = 2
primesquares[0] = 4
print(3)
primes[1] = 3
primesquares[1] = 9
number = 3
for count in range(2, 24 + 1, 1):
    while True:    #This simulates a Do Loop
        number = 2 + number
        primepointer = 1
        divisor = primes[primepointer]
        divisorsquare = primesquares[primepointer]
        isprime = True
        while isprime and divisorsquare <= number:
            remainder = number % divisor
            if remainder == 0:
                isprime = False
            else:
                primepointer = 1 + primepointer
                divisor = primes[primepointer]
                divisorsquare = primesquares[primepointer]
        if isprime:
            primes[count] = number
            primesquares[count] = number * number
            print(number)
        if isprime: break
