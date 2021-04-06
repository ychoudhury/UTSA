/////////////////////////////////////////////////////////////////
//
// CPE2073 Homework 13
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

struct _complexRepresentation{
    double realPart;
    double imaginaryPart;
};
typedef struct _complexRepresentation Complex;

// initializes complex value from two given integers
// e.g. 2, 5 is 2 + 5i
Complex complexInit(double real, double imaginary){
    Complex z = {real, imaginary};
    return z;
}

// prints given tuple of numbers in complex form
Complex Print(Complex x){
    printf("Result: %.2lf + %.2lfi\n", x.realPart, x.imaginaryPart);
}

// adds real parts of two complex numbers 
// and returns them in complex form
Complex realAddition(Complex x, Complex y){
    Complex realNumber = {x.realPart, y.realPart};

    return realNumber;
}

// same as realaddition, but imaginary
Complex imaginaryAddition(Complex x, Complex y){
    Complex imaginaryNumber = {x.imaginaryPart, y.imaginaryPart};

    return imaginaryNumber;
}
// adds both real and imaginary components of passed numbers
Complex Addition(Complex x, Complex y){
    Complex Sum = {Sum.realPart, Sum.imaginaryPart};
    Sum.realPart = (x.realPart + y.realPart);
    Sum.imaginaryPart = (x.imaginaryPart + y.imaginaryPart);

    return Sum;
}
// multiplies complex value with given scalar in form
// c(a + bi) = ca + cbi
Complex scalarMultiplication(double scalar, Complex x){
    Complex scalarProduct = {scalarProduct.realPart, scalarProduct.imaginaryPart};
    scalarProduct.realPart = (scalar * x.realPart);
    scalarProduct.imaginaryPart = (scalar * x.imaginaryPart);

    return scalarProduct;
}

// (a+bi)/c = a/c + b/c(i)
Complex scalarDivision(Complex x, double scalar){
    Complex scalarQuotient = {scalarQuotient.realPart, scalarQuotient.imaginaryPart};
    scalarQuotient.realPart = (x.realPart / scalar);
    scalarQuotient.imaginaryPart = (x.imaginaryPart / scalar);

    return scalarQuotient;
}

// (a + bi)(c + di) = (ac - bd) + (ad + bc)i
Complex complexMultiplication(Complex x, Complex y){
    Complex complexProduct = {complexProduct.realPart, complexProduct.imaginaryPart};
    complexProduct.realPart = ((x.realPart * y.realPart) - (x.imaginaryPart * y.imaginaryPart));
    complexProduct.imaginaryPart = ((x.realPart * y.imaginaryPart) + (x.imaginaryPart * y.realPart));
    
    return complexProduct;
}

// (a + bi) = (a - bi)
Complex complexConjugate(Complex x){
    Complex complexConjugate = {complexConjugate.realPart, complexConjugate.imaginaryPart};
    complexConjugate.realPart = x.realPart;
    complexConjugate.imaginaryPart = (-x.imaginaryPart);

    return complexConjugate;
}

Complex complexQuotient(Complex x, Complex y){
    Complex complexQuotient = {complexQuotient.realPart, complexQuotient.imaginaryPart};
    Complex conjugateY = complexConjugate(y);
    Complex numerator = complexMultiplication(x, conjugateY);

    return scalarDivision(numerator, (y.realPart * y.realPart) + (y.imaginaryPart * y.imaginaryPart));
}


int main(){
    printf("Homework 13: Yasirul Choudhury, orb234\n\n");

    Complex z, x, y, w;

    // add the real components of numbers
    x = complexInit(3, 4);
    y = complexInit(2, 3);
    Print(Addition(x, y));

    x = complexInit(1, 1);
    y = complexInit(3, 2);
    w = scalarMultiplication(-1, y);
    Print(Addition(w, y));

    x = complexInit(4, 5);
    Print(scalarMultiplication(3, x));

    x = complexInit(1, 2);
    Print(scalarDivision(x, 5));

    x = complexInit(-2, 2);
    y = complexInit(2, -3);
    Print(complexMultiplication(x, y));

    x = complexInit(2, 4);
    y = complexInit(-3, 2);
    Print(complexQuotient(x, y));


    keypress();
    return 0;
}
