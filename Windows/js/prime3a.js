function main() {
    var count;
    var divisor;
    var divisorsquare;
    var remainder;
    var isprime;
    var maxPrimes = 100;
    var outputFile = null;

    const output = require('fs');
    const sprintf = require('sprintf-js').sprintf;
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
    outputLines.push(sprintf("%20d: %20d", 1, 2));
    var number = 1;

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
                outputLines.push(sprintf("%20d: %20d", count, number));
            }
        } while (!isprime);

        if (count % 1000 == 0) {
            console.error(sprintf("%d primes found.", count));
        }
    }
    if (outputFile) {
        output.writeFileSync(outputFile, outputLines.join("\n"));
    } else {
        for (var i = 0; i < outputLines.length; i++) {
            console.log(outputLines[i]);
        }
    }
    console.error(sprintf("%d primes found.", count - 1));
}
main();
