#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>

#define OUTPUT_FILE_LEN 256
#define OUTPUT_FORMAT "%20i: %20i\n"

int main(int argc, char *argv[]) {
    unsigned int number = 3;
    unsigned int count;
    unsigned int num_primes = 100;
    unsigned int divisor;
    unsigned long divisor_square;
    unsigned int remainder;
    int isprime = 0;
    char output_file[OUTPUT_FILE_LEN];
    FILE *fp=stdout;

    typedef struct {
        void *next;
        unsigned int prime;
        unsigned long square;
    } prime_t;
    prime_t *prime_list = NULL;
    prime_t *prime_p;
    prime_t *prime_last;

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

    if (num_primes < 2) {
        fclose(fp);
        fprintf(stderr, "1 prime found\n");
        return 0;
    }

    fprintf(fp, OUTPUT_FORMAT, 2, 3);

    if ((prime_list = (prime_t *)malloc(sizeof(prime_t))) == NULL) {
        fprintf(stderr, "Error allocating memory\n");
        fclose(fp);
        return 1;
    }
    prime_list->next = NULL;
    prime_list->prime = 2;
    prime_list->square = 4;

    if ((prime_last = (prime_t *)malloc(sizeof(prime_t))) == NULL) {
        fprintf(stderr, "Error allocating memory\n");
        fclose(fp);
        return 1;
    }
    prime_list->next = (prime_t *)prime_last;
    prime_last->next = NULL;
    prime_last->prime = 3;
    prime_last->square = 9;

    for (count = 2; count < num_primes; count++) {
        while (1) {
            number += 2;
            prime_p = (prime_t *)prime_list->next;
            divisor = prime_p->prime;
            divisor_square = prime_p->square;
            isprime = 1;

            while (divisor_square <= number) {
                remainder = number % divisor;

                if (!remainder) {
                    isprime = 0;
                    break;
                } else {
                    prime_p = (prime_t *)prime_p->next;
                    divisor = prime_p->prime;
                    divisor_square = prime_p->square;
                }
            }
            if (isprime) {
                if ((prime_p = (prime_t *)malloc(sizeof(prime_t))) == NULL) {
                    fprintf(stderr, "Error allocating memory\n");
                    fclose(fp);
                    return 1;
                }
                prime_last->next = (prime_t *)prime_p;
                prime_last = prime_p;
                prime_last->next = NULL;
                prime_last->prime = number;
                prime_last->square = number * number;

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