const sprintf = require('sprintf-js').sprintf;

class Prime {
    static seq = 0;

    ToString() {
        return sprintf("%20d: %20d", this.Seq, this.Value);
    }
    constructor(Value) {
        if (isNaN(Value)) {
            throw new Error("Value must be a number");
        }
        this.Value = Value;
        this.Square = Value * Value;
        this.Seq = ++Prime.seq;
    }
}
function main() {
    var number;
    var count;
    var divisor;
    var divisorsquare;
    var primes = new Array();
    var primepointer;
    var remainder;
    var isprime;
    var maxPrimes = 100;
    var outputFile = null;

    const output = require('fs');
    const args = process.argv.slice(2);

    try {
        maxPrimes = parseInt(args[0]);

        if (maxPrimes < 1 || isNaN(maxPrimes)) {
            maxPrimes = 100;
        }
    } catch (e) {
    }

    try {
        outputFile = args[1];

        if (!outputFile) {
            outputFile = null;
        }
    } catch (e) {
    }

    var outputLines = [];
    primes.push(new Prime(2));

    if (maxPrimes > 1) {
        primes.push(new Prime(3));
        var number = 3;

        for (count = 2; count < maxPrimes; count++) {
            do {
                number = 2 + number;
                primepointer = 1;
                divisor = primes[primepointer].Value;
                divisorsquare = primes[primepointer].Square;
                isprime = true;
                while (isprime && divisorsquare <= number) {
                    remainder = number % divisor;
                    if (remainder == 0) {
                        isprime = false;
                    } else {
                        primepointer = 1 + primepointer;
                        divisor = primes[primepointer].Value;
                        divisorsquare = primes[primepointer].Square;
                    }
                }
                if (isprime) {
                    primes.push(new Prime(number));
                }
            } while (!isprime);

            if (count % 1000 == 0) {
                console.error(sprintf("%d primes found.", count));
            }
        }
    }
    if (outputFile) {
        for (var i = 0; i < maxPrimes; i++) {
            outputLines.push(primes[i].ToString());
        }
        output.writeFileSync(outputFile, outputLines.join("\n"));
    } else {
        for (var i = 0; i < maxPrimes; i++) {
            console.log(primes[i].ToString());
        }
    }
    console.error(sprintf("%d primes found.", maxPrimes));
}
main();
