/////////////////////////////////////////////////////////////////
//
// CPE2073 Homework 15
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

#define PI 3.141592653

double NumIntegrate(double (*func)(double), double lower, double upper, double stepSize){
    double sum = 0;
    for(double i = lower; i < upper; i += stepSize){
        sum += func(i);
    }
    return sum * stepSize;
}

double a(double x){
    return (3.0 * x * x) - (17.0 * x) + 5.0;
}

double b(double x){
    return (2 * cos(3 *x)) - sin(2 * x);
}

double c(double x){
    return 4 * sqrt(1 - (x * x));
}

double d(double x){
    return (1 / sqrt(PI)) * exp(-x * x);
}


int main(){
    printf("Homework 15: Yasirul Choudhury, orb234\n\n");

    printf("%.5lf\n", NumIntegrate(a, 3.1, 5.7, 0.00001));
    printf("%.5lf\n", NumIntegrate(b, (-PI/4), (PI/4), 0.00001));
    printf("%.5lf  -  This result is pi!\n", NumIntegrate(c, 0, 1, 0.00001));
    printf("%.5lf\n", NumIntegrate(d, -5, 5, 0.00001));
    printf("\n");


    keypress();
    return 0;
}
