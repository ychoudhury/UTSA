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

// determine if given year is a leap year
int isLeapYear (Date d){
    int leapYearFlag = 0 ; // this could be problematic if my leap year determination criteria doesn't work properly
    if ((d.year % 4 == 0 && d.year % 100 != 0) || (d.year % 400 == 0)){ // homework 7 criteria to determine leap year
        leapYearFlag = 1; // is a leap year
    }
    else{
        leapYearFlag = 0; 
    }

    return leapYearFlag;
}

// returns how many days are in a passed month
int daysInMonth (Date d){
    int daysInTheMonth;
    const int daysPerMonth[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    if(isLeapYear(d) == 1 && d.month == 2){
        daysInTheMonth = 29;
    }

    else{
        daysInTheMonth = daysPerMonth[d.month - 1];
    }

    return daysInTheMonth;
}

Date addDaysToDate(Date oldDate, int days){
    Date newDate = {oldDate.year, oldDate.month, oldDate.day}; // newdate now has a copy of olddate
    newDate.day = (oldDate.day + days); //newdate.day gets updated

    while(newDate.day > (daysInMonth(newDate))){
        newDate.day -= (daysInMonth(newDate));
        newDate.month++;
        if(newDate.month > 12){
            newDate.year++;
            newDate.month -= 12;
        }
    }

    while(newDate.day < 1) {
        newDate.month--;
        if(newDate.month < 1){
            newDate.year--;
            newDate.month += 12;
        }
        newDate.day += daysInMonth(newDate);
    }

    printf("%i/%i/%i + %i days is %i/%i/%i\n\n", oldDate.month, oldDate.day, oldDate.year, days, newDate.month, newDate.day, newDate.year);

    return newDate;

}

int main(){
    printf("Homework 11: Yasirul Choudhury, orb234\n\n");

    Date date1 = {.month = 3, .day = 1, .year = 2020};
    Date date2 = {.month = 3, .day = 1, .year = 1964};
    Date date3 = {.month = 10, .day = 1, .year = 2020};
    Date date4 = {.month = 2, .day = 1, .year = 2020};
    Date date5 = {.month = 3, .day = 17, .year = 1794};

    addDaysToDate(date1, 10);
    addDaysToDate(date2, -10);
    addDaysToDate(date3, 180);
    addDaysToDate(date4, 365);
    addDaysToDate(date5, 2000);

    keypress();
    return 0;
}
