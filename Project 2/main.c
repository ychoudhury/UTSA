/////////////////////////////////////////////////////////////////
//
// CPE2073 Homework 2
//
// Yasirul Choudhury, orb234
//
// Depending on your compiler and settings, you may need to comment out
// system() call or the printf() call, below.

#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#ifdef _WIN32
#include <process.h>
#define keypress() system("pause")
#else
#define keypress() // printf("Press [Enter] to continue . . .\n"); getchar()
#endif
// This function is hard-coded to return y = 3.1 x^2 - 4.7 x + 17.3
double evalQuadratic(double a, double b, double c, double x)
{
    double result = (a * (x * x)) + (b * x) + c;
    return result;
}
// Main function - program execution starts here
int main(void)
{
    double a = 0; // Initialize all variables to 0 so that they do not 
    double b = 0; // take the value of whatever is stored in memory
    double c = 0;
    double x = 0;
    double y = 0;
    // Print your name and id to screen
    printf("Homework 2: Yasirul Choudhury, orb234\n\n");
    // Assign values and call the function

    a = 2.9;
    b = -15;
    c = 3.4;
    x = 1.5;
    y = evalQuadratic(a,b,c,x);
    printf("For x = %lf, the equation %lfx^2 + %lfx + %lf = %lf\n", x, a, b, c, y);
    
    a = -0.1;
    b = 1.8;
    c = -2.7;
    x = 34.6;
    y = evalQuadratic(a,b,c,x);
    printf("For x = %lf, the equation %lfx^2 + %lfx + %lf = %lf\n", x, a, b, c, y);
    
    a = -3;
    b = 4;
    c = -5;
    x = -4;
    y = evalQuadratic(a,b,c,x);
    printf("For x = %lf, the equation %lfx^2 + %lfx + %lf = %lf\n", x, a, b, c, y);
    keypress();
    return 0;
}
