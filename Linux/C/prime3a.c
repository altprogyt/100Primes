#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define OUTPUT_FILE_LEN 256
#define OUTPUT_FORMAT "%20i: %20i\n"

int main(int argc, char *argv[]) {
    unsigned int number = 1;
    unsigned int count;
    unsigned int num_primes = 100;
    unsigned int divisor;
    unsigned long divisor_square;
    unsigned int remainder;
    int isprime = 0;
    char output_file[OUTPUT_FILE_LEN];
    FILE *fp=stdout;

    if (argc > 1) {
        num_primes = (unsigned int)atoi(argv[1]);

        if (num_primes < 1) {
            num_primes = 100;
        }

        if (argc > 2) {
            strncpy(output_file, argv[2], OUTPUT_FILE_LEN - 1);

            if ((fp = fopen(output_file, "w")) == NULL) {
                fprintf(stderr, "Error opening %s\n", output_file);
                return 1;
            }
        }
    }

    fprintf(fp, OUTPUT_FORMAT, 1, 2);

    for (count = 1; count < num_primes; count++) {
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
                fprintf(fp, OUTPUT_FORMAT, 1+count, number);
                break;
            }
        }
        if (!(count % 1000)) {
            fprintf(stderr, "%i primes found\n", count);
        }
    }

    fclose(fp);
    fprintf(stderr, "%i primes found\n", count);
    return 0;
}