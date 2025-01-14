#include <iostream>
#include <sstream>
#include <string>
#include <cstdlib>
#include <cmath>

using namespace std;

// Headers
string toString (double);
int toInt (string);
double toDouble (string);

int main() {
    int number;
    int count;
    int divisor;
    int divisorsquare;
    int primes[25];
    int primesquares[25];
    int primepointer;
    int remainder;
    bool isprime;

    cout << 2 << endl;
    primes[0] = 2;
    primesquares[0] = 4;
    cout << 3 << endl;
    primes[1] = 3;
    primesquares[1] = 9;
    number = 3;
    for (count = 2; count <= 24; count++) {
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
                cout << number << endl;
            }
        } while (!isprime);
    }
    return 0;
}

// The following implements type conversion functions.
string toString (double value) { //int also
    stringstream temp;
    temp << value;
    return temp.str();
}

int toInt (string text) {
    return atoi(text.c_str());
}

double toDouble (string text) {
    return atof(text.c_str());
}
