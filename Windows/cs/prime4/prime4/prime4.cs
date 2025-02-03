using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace prime4 {
    internal class prime4 {
        const uint MAX_PRIMES = 100;

        static void Main() {
            uint count;
            uint divisor;
            ulong divisorsquare;
            int primepointer;
            uint remainder;
            bool isprime;

            uint[] primes = new uint[MAX_PRIMES];
            ulong[] primeSquares = new ulong[MAX_PRIMES];

            primes[0] = 2;
            primeSquares[0] = 4;
            primes[1] = 3;
            primeSquares[1] = 9;
            uint number = 3;

            for (count = 2; count < MAX_PRIMES; count++) {
                do {
                    number += 2;
                    primepointer = 1;
                    divisor = primes[primepointer];
                    divisorsquare = primeSquares[primepointer];
                    isprime = true;

                    while (divisorsquare <= number) {
                        remainder = number % divisor;

                        if (remainder == 0) {
                            isprime = false;
                            break;
                        } else {
                            primepointer++;
                            divisor = primes[primepointer];
                            divisorsquare = primeSquares[primepointer];
                        }
                    }
                    if (isprime) {
                        primes[count] = number;
                        primeSquares[count] = number * number;
                    }
                } while (!isprime);
            }
            for (count = 0; count < MAX_PRIMES; count++) {
                printPrime(count, primes[count]);
            }
        }
        static void printPrime(uint seq, uint number) {
            string outputLine = String.Format("{0,20}: {1,20}", 1 + seq, number);
            Console.WriteLine(outputLine);
        }
    }
}
