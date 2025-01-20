import java.io.*;

public class prime3a {
    public static void main(String[] args) {
        int number = 1;
        int count;
        int divisor;
        long divisorSquare;
        int remainder;
        boolean isprime;
        int maxPrimes = 100;
        boolean printToFile=false;

        try {
            if (args.length > 0) {
                maxPrimes=Integer.parseInt(args[0]);
            }
        } catch (Exception e) {
            System.err.println(String.format("Error parsing count:%n%s%n", e.toString()));
        }
        try {
            if (args.length > 1) {
                PrintStream out = new PrintStream(new FileOutputStream(args[1]));
                System.setOut(out);
                printToFile=true;
            }
        } catch (Exception e) {
            System.err.println(String.format("Error parsing output filename:%n%s%n", e.toString()));
        }

        System.out.println(printPrime(1, 2));
        number = 1;
        for (count = 1; count < maxPrimes; count++) {
            do {
                number = 2 + number;
                divisor = 3;
                divisorSquare = divisor * divisor;
                isprime = true;
                while (isprime && divisorSquare <= number) {
                    remainder = number % divisor;
                    if (remainder == 0) {
                        isprime = false;
                    } else {
                        divisor = 2 + divisor;
                        divisorSquare = divisor * divisor;
                    }
                }
                if (isprime) {
                    System.out.println(printPrime(1 + count, number));
                }
            } while (!isprime);

            if (count % 1000 == 0) {
                System.err.println(String.format("%d primes found.", count));
            }
        }
        System.err.println(String.format("%d primes found.", maxPrimes));

        if (printToFile) {
            System.out.close();
        }
    }
    private static String printPrime(int seq, int number) {
        return String.format("%20s: %20s", seq, number);
    }
}
