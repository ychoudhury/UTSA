/////////////////////////////////////////////////////////////////
//
// CPE2073 Homework 5
//
// Yasirul Choudhury, orb234
//
// Depending on your compiler settings, you may need to comment out
// system() call or the printf() call, below.
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <math.h>
#ifdef _WIN32
#include <process.h>
#define keypress() system("pause")
#else
#define keypress() printf( "Press [Enter] to continue . . .\n"); getchar()
#endif

double squareRoot(double x){
    double epsilon = 0.0001;
    double y = 1.0;
    while(fabs(((y * y) - x)) > epsilon){
        y = (((x / y) + y) / 2.0);
    }
    return y;
}

int main(){
    printf("Homework 5: Yasirul Choudhury, orb234\n\n");

    for (double x = 2; x < 9; x++){
        printf("The square root of %.lf is %.4lf\n", x, squareRoot(x));
    }
    keypress();
    return 0;
}
