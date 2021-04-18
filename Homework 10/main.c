/////////////////////////////////////////////////////////////////
//
// CPE2073 Homework 10
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

double evalPoly(double coeffs[], int order, double x){
    double sum = 0;

    for (int i = 0; order >= 0; order--, i++){
        // printf("This is what element %i has evaluated to: %lf\n", i, coeffs[i] * pow(x, order));
        sum += coeffs[i] * pow(x, order); 

        // first array ex) sum += 5 * (3.1^1) = 15.5
        // then, sum += -17 * (3.1^0) = -17
        // therefore, sum is 15.5 - 17 = -1.5

        // printf("For debugging purposes, here is %lf to the power of %i: %lf\n", x, i, pow(x, i));
    }
    printf("y = %lf\n\n", sum);
    return 0;
}

int main(){
    printf("Homework 10: Yasirul Choudhury, orb234\n\n");
    double array1[] = {5, -17};
    double array2[] = {-1.7, 0, -3, 0.1, 3.5};
    double array3[] = {2, -3, 4, -5, 6, -7, 8};
    double array4[] = {3.2, 0, 0, -2, 0};

    evalPoly(array1, 1, 3.1);
    evalPoly(array2, 4, -1.2);
    evalPoly(array3, 6, 3);
    evalPoly(array4, 4, 1.3);


    keypress();
    return 0;
}
