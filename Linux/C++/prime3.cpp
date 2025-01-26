#include <iostream>

using namespace std;

int main(int argc, char* argv[]) {
    int number = 1;
    int count;
    int divisor;
    int divisorsquare;
    int remainder;
    bool isprime;

    cout << "2" << endl;

    for (count = 1; count <100; count++) {
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
                cout << number << endl;
            }
        } while (!isprime);
    }
    return 0;
}
