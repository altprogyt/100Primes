using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace prime4 {
    internal class prime4 {
        const uint NUM_PRIMES = 100;
        static void Main(string[] args) {
            int count;
            int divisor;
            int divisorsquare;
            int[] primes = new int[NUM_PRIMES];
            int[] primesquares = new int[NUM_PRIMES];
            int primepointer;
            int remainder;
            bool isprime;

            Console.WriteLine(2);
            primes[0] = 2;
            primesquares[0] = 4;
            Console.WriteLine(3);
            primes[1] = 3;
            primesquares[1] = 9;
            int number = 3;

            for (count = 2; count < NUM_PRIMES; count++) {
                while (true) {
                    number += 2;
                    primepointer = 1;
                    divisor = primes[primepointer];
                    divisorsquare = primesquares[primepointer];
                    isprime = true;

                    while (divisorsquare <= number) {
                        remainder = number % divisor;

                        if (remainder == 0) {
                            isprime = false;
                            break;
                        } else {
                            primepointer = 1 + primepointer;
                            divisor = primes[primepointer];
                            divisorsquare = primesquares[primepointer];
                        }
                    }
                    if (isprime) {
                        primes[count] = number;
                        primesquares[count] = number * number;
                        Console.WriteLine(number);
                        break;
                    }
                }
            }
        }
    }
}
