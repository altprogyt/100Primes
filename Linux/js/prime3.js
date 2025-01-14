function main() {
    var number;
    var count;
    var divisor;
    var divisorsquare;
    var remainder;
    var isprime;

    window.alert(2);
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
                window.alert(number);
            }
        } while (!isprime);
    }
}
