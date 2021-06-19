/////////////////////////////////////////////////////////////////
//
// CPE2073 Homework 8
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

double findMean(double weatherArray[], int size){
    double sum = 0;

    for(int i = 0; i < size; i++){
        sum += weatherArray[i];
    }

    double mean = sum/size;
    return mean;

}

int main(){
    printf("Homework 8: Yasirul Choudhury, orb234\n\n");

    double lowTemps[] = {38.6, 42.4, 49.9, 56.9, 65.5, 71.6, 74.0, 73.6, 68.8, 59.4, 48.6, 40.8};
    double highTemps[] = {62.1, 67.1, 74.3, 80.4, 86.0, 91.4, 94.6, 94.7, 90.0, 82.0, 71.4, 64.0};
    double monthPrecipitation[] = {1.66, 1.75, 1.89, 2.60, 4.72, 4.30, 2.03, 2.57, 3.00, 3.86, 2.58, 1.96};

    printf("Average Low: %.2lf\n", findMean(lowTemps, (sizeof(lowTemps)/sizeof(double))));
    printf("Average High: %.2lf\n", findMean(highTemps, (sizeof(highTemps)/sizeof(double))));
    printf("Average Precipitation: %.2lf\n\n", findMean(monthPrecipitation, (sizeof(monthPrecipitation)/sizeof(double))));

    keypress();
    return 0;
}
