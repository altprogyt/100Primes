import java.util.*;
import java.lang.Math;

public class prime4 {
    public static void main(String[] args) {
        int number;
        int count;
        int divisor;
        int divisorsquare;
        int[] primes = new int[100];
        int[] primesquares = new int[100];
        int primepointer;
        int remainder;
        boolean isprime;

        System.out.println(2);
        primes[0] = 2;
        primesquares[0] = 4;
        System.out.println(3);
        primes[1] = 3;
        primesquares[1] = 9;
        number = 3;
        for (count = 2; count < 100; count++) {
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
                    System.out.println(number);
                }
            } while (!isprime);
        }
    }
}
