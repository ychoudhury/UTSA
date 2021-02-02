////////////////////////////////////////////////////////
//
// CPE 2073 Homework 3
//
// Yasirul Choudhury, ygc239

#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <math.h>
#ifdef _WIN32
#include <process.h>
#define keypress() system("pause")
#else
#define keypress() //printf("Press [Enter] to continue . . .\n"); getchar()
#endif


// Function to convert degrees C to degrees F
double CtoF(double degreesC){
    double resultF = 0;
    resultF = ((1.8*degreesC)+32);
    return resultF;
}

// Function to convert degrees F to degrees C
double FtoC(double degreesF){
    double resultC = 0;
    resultC = ((degreesF-32)/1.8);
    return resultC;
}

// Main function
int main(){
    // Print your name and id to screen
    printf("Homework 3: Yasirul Choudhury, orb234\n\n");
    
    // Convert each of the given values as specified.
    printf("98.6 degrees F is equal to %.1lf degrees C\n", FtoC(98.6));
    printf("100 degrees C is equal to %.1lf degrees F\n", CtoF(100));
    printf("-40 degrees C is equal to %.1lf degrees F\n", CtoF(-40));
    printf("32 degrees F is equal to %.1lf degrees C\n", FtoC(32));
    printf("212 degrees C is equal to %.1lf degrees F\n", CtoF(212));
    printf("-123.7 degrees F is equal to %.1lf degrees C\n", FtoC(-123.7));
    
    keypress();
    return 0;
}
