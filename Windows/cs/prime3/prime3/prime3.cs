using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace prime3 {
    internal class prime3 {
        static void Main(string[] args) {
            int count;
            int divisor;
            int divisorsquare;
            int remainder;
            bool isprime;

            Console.WriteLine(2);
            int number = 1;

            for (count = 1; count <= 99; count++) {
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
                        Console.WriteLine(number);
                    }
                } while (!isprime);
            }
        }
    }
}
