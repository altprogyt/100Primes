using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace prime4 {
    class Prime {
        private static uint NextValue = 0;
        public uint Seq { get; set; } = 0;
        public uint Value { get; set; }
        public ulong Square { get; set; }
        public Prime(uint number) {
            this.Seq = ++NextValue;
            this.Value = number;
            this.Square = number * number;
        }
        public override string ToString() {
            return String.Format("{0,20}: {1,20}", this.Seq, this.Value);
        }
    }
    internal class prime4a {
        const uint MAX_PRIMES = 100;
        static StreamWriter outputStream = null;

        static void Main(string[] args) {
            uint count;
            uint divisor;
            ulong divisorsquare;
            uint maxPrimes = MAX_PRIMES;
            int primepointer;
            uint remainder;
            bool isprime;
            List<Prime> primeList = new List<Prime>();

            try {
                maxPrimes = (uint)Int32.Parse(args[0]);
                if (maxPrimes < 1) {
                    maxPrimes = MAX_PRIMES;
                }
            } catch {
            }
            try {
                outputStream = new StreamWriter(args[1]);
            } catch {
            }

            primeList.Add(new Prime(2));

            if (maxPrimes > 1) { 
                uint number = 3;

                primeList.Add(new Prime(3));

                for (count = 3; count <= maxPrimes; count++) {
                    do {
                        number += 2;
                        primepointer = 1;
                        divisor = primeList[primepointer].Value;
                        divisorsquare = primeList[primepointer].Square;
                        isprime = true;

                        while (divisorsquare <= number) {
                            remainder = number % divisor;

                            if (remainder == 0) {
                                isprime = false;
                                break;
                            } else {
                                primepointer++;
                                divisor = primeList[primepointer].Value;
                                divisorsquare = primeList[primepointer].Square;
                            }
                        }
                        if (isprime) {
                            primeList.Add(new Prime(number));
                        }
                    } while (!isprime);

                    if (count % 1000 == 0) {
                        Console.Error.WriteLine("{0} primes found.", count);

                        if (outputStream != null) {
                            outputStream.Flush();
                        }
                    }
                }
            }
            if (outputStream != null) {
                foreach (Prime p in primeList) {
                    outputStream.WriteLine(p.ToString());
                }
            } else {
                foreach (Prime p in primeList) {
                    Console.WriteLine(p.ToString());
                }
            }
            Console.Error.WriteLine("{0} primes found.", maxPrimes);

            if (outputStream != null) {
                outputStream.Close();
            }
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
