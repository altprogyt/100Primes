print(2)
number = 1
for count in range(1, 9 + 1, 1):
    while True:    #This simulates a Do Loop
        number = 2 + number
        divisor = 3
        divisorsquare = divisor * divisor
        isprime = True
        while isprime and divisorsquare <= number:
            remainder = number % divisor
            if remainder == 0:
                isprime = False
            else:
                divisor = 2 + divisor
                divisorsquare = divisor * divisor
        if isprime:
            print(number)
        if isprime: break
