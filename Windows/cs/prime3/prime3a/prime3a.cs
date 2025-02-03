using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace prime3a {
    internal class prime3a {
        const int MAX_PRIMES = 100;
        static StreamWriter outputStream = null;

        static void Main(string[] args) {
            int count;
            int divisor;
            int divisorsquare;
            int remainder;
            bool isprime;
            int maxPrimes = 100;

            try {
                maxPrimes = Int32.Parse(args[0]);
                if (maxPrimes < 1) {
                    maxPrimes = MAX_PRIMES;
                }
            } catch {
            }
            try {
                outputStream = new StreamWriter(args[1]);
            } catch {
            }

            printPrime(1, 2);
            int number = 1;

            for (count = 2; count <= maxPrimes; count++) {
                do {
                    number = 2 + number;
                    divisor = 3;
                    divisorsquare = divisor * divisor;
                    isprime = true;

                    while (isprime && divisorsquare <= number) {
                        remainder = number % divisor;
                        if (remainder == 0) {
                            isprime = false;
                        } else {
                            divisor = 2 + divisor;
                            divisorsquare = divisor * divisor;
                        }
                    }
                    if (isprime) {
                        printPrime(count, number);
                    }
                } while (!isprime);

                if (count % 1000 == 0) {
                    Console.Error.WriteLine("{0} primes found.", count);
                }
            }
            Console.Error.WriteLine("{0} primes found.", maxPrimes);
            outputStream.Close();
        }
        static void printPrime(int seq, int number) {
            string outputLine = String.Format("{0,20}: {1,20}", seq, number);

            if (outputStream != null) {
                outputStream.WriteLine(outputLine);
            } else {
                Console.WriteLine(outputLine);
            }
        }
    }
}
