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

struct _point{
    double x;
    double y;
};
typedef struct _point Point;

struct _line{
    double m;
    double b;
};
typedef struct _line Line;

Point Mean(Point p[], int count){
    double xSum = 0;
    double ySum = 0;
    Point returnedMean = {returnedMean.x, returnedMean.y};

    for(int i = 0; i < count; i++){
        xSum += p[i].x;
        ySum += p[i].y;
    }
   returnedMean.x = xSum/count;
   returnedMean.y = ySum/count;

   return returnedMean;

}

Line FitLine(Point p[], int count){
    Line newPoints = {newPoints.m, newPoints.b};
    Point avg = Mean(p, count);
    double tempx = 0; // temporary registers to hold values before dividing to obtain newPoints.m
    double tempy = 0;


    for(int i = 0; i < count; i++){
        
        tempx += (p[i].x - avg.x) * (p[i].y - avg.y);
        tempy +=  (pow(p[i].x - avg.x, 2));
        newPoints.m = tempx/tempy;
    }

    newPoints.b = (avg.y) - (newPoints.m * avg.x);

    return newPoints;
}

int main(){
    printf("Homework 12: Yasirul Choudhury, orb234\n\n");

    // Code to read the .csv file
    Point data[100];
    FILE* inputFile = fopen("points.csv", "rt");
    if (!inputFile){
        printf("Unable to open file.\n");
        return 1;
    }
    int count = 0;

    while (!feof(inputFile)){
        fscanf(inputFile, "%lf,%lf\n", &data[count].x, &data[count].y);
        count++;
    }

    fclose(inputFile);
    
    // Call your FitLine() function and print the results here
    printf("slope: %lf\n\n", FitLine(data, count).m);
    printf("y-intercept: %lf\n\n", FitLine(data, count).b);

    keypress();
    return 0;
}
