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
    int remainder;
    bool isprime;

    cout << 2 << endl;
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
