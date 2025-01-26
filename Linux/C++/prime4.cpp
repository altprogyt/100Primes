#include <iostream>

#define NUM_PRIMES 100

using namespace std;

int main() {
    int number;
    int count;
    int divisor;
    int divisorsquare;
    int primes[NUM_PRIMES];
    int primesquares[NUM_PRIMES];
    int primepointer;
    int remainder;
    bool isprime;

    cout << 2 << endl;
    primes[0] = 2;
    primesquares[0] = 4;
    cout << 3 << endl;
    primes[1] = 3;
    primesquares[1] = 9;
    number = 3;
    for (count = 2; count < NUM_PRIMES; count++) {
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
                cout << number << endl;
            }
        } while (!isprime);
    }
    return 0;
}
