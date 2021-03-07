/////////////////////////////////////////////////////////////////
//
// CPE2073 Homework 6
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

void evalQuadratic(double a, double b, double c){
    double discriminant = ((b * b) - (4 * a * c));

    if(discriminant < 0){
        double realHalf = ((-b)/(2 * a));
        double imaginaryHalf = (sqrt(-discriminant)/(2 * a));
        printf("The two complex roots are: x1 = %.2lf + %.2lfj and x2 = %.2lf - %.2lfj\n", realHalf, imaginaryHalf, realHalf, imaginaryHalf);
    }

    else if (discriminant > 0){
        double x1 = (-b/(2 * a));
        double x2 = (-b/(2 * a));
        printf("The two roots of the equation are: x1 = %.2lf, %.2lf\n", x1, x2);
    }

    else if (discriminant == 0){
        double x1 = (-b/(2 * a));
        printf("The root of the equation is: x1 = %.2lf\n", x1);
    }

    else{  // this condition should not exist
        printf("foo\n");
    }
}

int main(){
    printf("Homework 6: Yasirul Choudhury, orb234\n\n");

    evalQuadratic(3, 2, 1);
    evalQuadratic(5, 2, -7);
    evalQuadratic(1, 2, 1);
    evalQuadratic(-1, 4, 2);
    evalQuadratic(1, -2, 4);
    evalQuadratic(2, 2, 0);

    keypress();
    return 0;
}
