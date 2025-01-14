#include <stdio.h>

#define NUM_PRIMES 100

int main() {
    int number = 3;
    int count;
    int remainder;
    int isprime = 0;
    int prime_id;

    struct {
        int prime;
        int square;
    } primes[NUM_PRIMES];

    primes[0].prime = 2;
    primes[0].square = 4;
    primes[1].prime = 3;
    primes[1].square = 9;

    printf("2\n3\n");

    for (count = 2; count < NUM_PRIMES; count++) {
        while (1) {
            number += 2;
            isprime = 1;
            prime_id = 1;

            while (primes[prime_id].square <= number) {
                remainder = number % primes[prime_id].prime;

                if (!remainder) {
                    isprime = 0;
                    break;
                } else {
                    prime_id++;
                }
            }
            if (isprime) {
                primes[count].prime = number;
                primes[count].square = number * number;
                printf("%d\n", number);
                break;
            }
        }
    }
}