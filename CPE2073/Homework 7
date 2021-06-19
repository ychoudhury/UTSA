/////////////////////////////////////////////////////////////////
//
// CPE2073 Homework 7
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

int isEvenlyDivisible(int num1, int num2){
    int result = (num1 % num2);
    if(result != 0){
        return 0; // result is not evenly divisible
    }

    else if(result == 0){
        return 1; // result is evenly divisible
    }
    
    else{
        printf("Error - unexpected behavior\n");
    }
}

int isLeapYear(int year){
    if(isEvenlyDivisible(year, 4) == 0){
        printf("The year %i is not a leap year\n", year);
        return 0;
    }
    
    else if(isEvenlyDivisible(year, 100) == 0){
        printf("The year %i is a leap year\n", year);
        return 1;
    }

    else if(isEvenlyDivisible(year, 400) == 0){
        printf("The year %i is not a leap year\n", year);
        return 0;
    }

    else{
        printf("The year %i is a leap year\n", year);
        return 1;
    }

    return 0;
}

int main(){
    printf("Homework 7: Yasirul Choudhury, orb234\n\n");

    isLeapYear(1776);
    isLeapYear(1860);
    isLeapYear(1900);
    isLeapYear(1943);
    isLeapYear(2000);
    isLeapYear(2076);

    keypress();
    return 0;
}
