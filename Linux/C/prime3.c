#include <stdio.h>

#define NUM_PRIMES 100

int main() {
    int number = 1;
    int count;
    int divisor;
    int divisor_square;
    int remainder;
    int isprime = 0;

    printf("2\n");

    for (count = 1; count < NUM_PRIMES; count++) {
        while (1) {
            number += 2;
            divisor = 3;
            divisor_square = divisor * divisor;
            isprime = 1;

            while (divisor_square <= number) {
                remainder = number % divisor;

                if (!remainder) {
                    isprime = 0;
                    break;
                } else {
                    divisor += 2;
                    divisor_square = divisor * divisor;
                }
            }
            if (isprime) {
                printf("%d\n", number);
                break;
            }
        }
    }
}