/////////////////////////////////////////////////////////////////
//
// CPE2073 Homework 11
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

// global Date struct definition
struct _date{
    int year;
    int month;
    int day;
};
typedef struct _date Date; // refers to struct as Date instead of the entire struct

void PrintDate(Date* d){
    printf("Date: %i %i, %i\n", d->month, d->day, d->year);  
}

void SwapDates(Date* a, Date* b){
    Date tmp = {a->year, a->month, a->day};
    *a = *b;
    *b = tmp;
}

int CompareDates(Date* a, Date* b){ //compare members of each structure before moving on to the next, and return 0 if both structures are equal
    if(a->year < b->year){
        return -1;
    }
    else if(a->year > b->year){
        return 1;
    }

    else if(a->month < b->month){
        return -1;
    }
    else if(a->month > b->month){
        return 1;
    }

    else if(a->day < b->day){
        return -1;
    }
    else if(a->day > b->day){
        return 1;
    }
    
    else{
        return 0;
    }
}

int main(){
    printf("Homework 14: Yasirul Choudhury, orb234\n\n");
    
    Date d1 = { 2021,4,2 }, d2 = { 1983,12,31 };
    printf("Compare dates and print the earliest one first:\n");
    PrintDate(&d1);
    PrintDate(&d2);

    if (CompareDates(&d1, &d2) > 0){
        SwapDates(&d1, &d2);
    }

    printf("\nAfter compare and swap:\n");
    PrintDate(&d1);
    PrintDate(&d2);


    keypress();
    return 0;
}
