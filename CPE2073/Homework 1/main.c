/////////////////////////////////////////////////////////////////
//
// CPE2073 Homework 1
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
double evalQuadratic(double x)
{
    double y = (3.1 * x * x) - (4.7 * x) + 17.3;
    return y;
}
// Main function - program execution starts here
int main(void)
{
    double x = 0; // The zeros in these lines initialize the value
    double y = 0; // of x and y to 0.
    // Print your name and id to screen
    printf("Homework 1: Yasirul Choudhury, orb234\n\n");
    // Assign a value to x and call the function
    x = 1.7;
    y = evalQuadratic(x);
    printf("For x = 1.7, the function evaluates to %lf\n", y);
    // Another way of calling the function without using variables x and y
    printf("For x = -9.2, the function evaluates to %lf\n", evalQuadratic(-9.2));
    keypress();
    return 0;
}
