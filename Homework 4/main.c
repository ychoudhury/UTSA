/////////////////////////////////////////////////////////////////
//
// CPE2073 Homework 4
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

double RCcircuit(double V, double R, double C, double t){
    double y = V * (1.0 - exp(-1.0 * (t/(R * C))));
    return y;
}

int main(){
    double V = 7.2;
    double R = 2200;
    double C = 470e-6;
    printf("Homework 4: Yasirul Choudhury, orb234\n\n");

    for(double t = 0; t < 5; t += 0.1){
        printf("Time: %lf s, Output Voltage: %lf V \n", t, RCcircuit(V, R, C, t));
    }
    
    keypress();
    return 0;
}
