function main() {
    var number;
    var count;
    var divisor;
    var divisorsquare;
    var primes = createArray(25);
    var primesquares = createArray(25);
    var primepointer;
    var remainder;
    var isprime;

    window.alert(2);
    primes[0] = 2;
    primesquares[0] = 4;
    window.alert(3);
    primes[1] = 3;
    primesquares[1] = 9;
    number = 3;
    for (count = 2; count <= 24; count++) {
        do {
            number = 2 + number;
            primepointer = 1;
            divisor = primes[primepointer];
            divisorsquare = primesquares[primepointer];
            isprime = true;
            while (isprime && divisorsquare <= number) {
                remainder = number % divisor;
                if (remainder == 0) {
                    isprime = false;
                } else {
                    primepointer = 1 + primepointer;
                    divisor = primes[primepointer];
                    divisorsquare = primesquares[primepointer];
                }
            }
            if (isprime) {
                primes[count] = number;
                primesquares[count] = number * number;
                window.alert(number);
            }
        } while (!isprime);
    }
}
