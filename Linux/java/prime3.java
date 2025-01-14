import java.util.*;
import java.lang.Math;

public class Program {
    public static void main(String[] args) {
        int number;
        int count;
        int divisor;
        int divisorsquare;
        int remainder;
        boolean isprime;

        System.out.println(2);
        number = 1;
        for (count = 1; count <= 9; count++) {
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
                    System.out.println(number);
                }
            } while (!isprime);
        }
    }
}
