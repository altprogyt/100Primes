import java.util.*;
import java.io.*;

public class prime4a {
    public static void main(String[] args) {
        int number;
        int count;
        int divisor;
        long divisorsquare;
        int primepointer;
        int remainder;
        boolean isPrime;
        int maxPrimes = 100;
        boolean printToFile=false;
        Prime thisPrime;

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
        if (maxPrimes < 1) {
            maxPrimes = 100;
        }
        ArrayList<Prime> primesList = new ArrayList<Prime>();
        primesList.add(new Prime(0, 2));

        if (maxPrimes < 2) {
            System.out.println(primesList.get(0).print());
            System.err.println("1 prime found.");

            if (printToFile) {
                System.out.close();
            }        
            return;
        }

        primesList.add(new Prime(1, 3));
        number = 3;

        for (count = 2; count < maxPrimes; count++) {
            do {
                number = 2 + number;
                primepointer = 1;
                thisPrime = primesList.get(primepointer);
                divisor = thisPrime.getNumber();
                divisorsquare = thisPrime.getSquare();
                isPrime = true;
                while (isPrime && divisorsquare <= number) {
                    remainder = number % divisor;
                    if (remainder == 0) {
                        isPrime = false;
                    } else {
                        primepointer = 1 + primepointer;
                        thisPrime = primesList.get(primepointer);
                        divisor = thisPrime.getNumber();
                        divisorsquare = thisPrime.getSquare();
                    }
                }
                if (isPrime) {
                    primesList.add(new Prime(count, number));
                }
            } while (!isPrime);

            if (count % 1000 == 0) {
                System.err.println(String.format("%d primes found.", count));
            }
        }
        System.err.println(String.format("%d primes found.", maxPrimes));

        for (Prime p : primesList) {
            System.out.println(p.print());
        }
        System.err.println(String.format("%d primes found.", maxPrimes));

        if (printToFile) {
            System.out.close();
        }
    }
}

