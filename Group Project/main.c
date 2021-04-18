/////////////////////////////////////////////////////////////////
//
// CPE2073 Group Project
//
// Yasirul Choudhury, orb234
// Ralph Casino
//
// Depending on your compiler settings, you may need to comment out
// system() call or the printf() call, below.
//
/////////////////////////////////////////////////////////////////
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <math.h>
#ifdef _WIN32
#include <process.h>
#define keypress() system("pause")
#else
#define keypress() printf( "Press [Enter] to continue . . .\n"); getchar()
#endif

// global current state struct definition
struct _state{
    double state;
    double velocity;
    double acceleration;
    double mass;
    double fuel;
};
typedef struct _date State; // refers to struct as State instead of the entire struct

int checkThrust(int givenThrust){
    givenThrust *= 1000;
    if(givenThrust > 45000){
        printf("Error: too much thrust");
        return 0;
    }
}

int main(){
    // char choice;
    // printf("Welcome to the Lunar Lander console\nWould you like to manually control the lander?\nPress Y for yes\nPress N for no\n");
    // scanf("%s", choice);
    // while(choice != 'Y' || choice != 'y' || choice != 'N' || choice != 'n'){
    //     printf("Error: Invalid Input. You're an astronaut, you know better! Try again.\n");
    //     scanf("%s", choice);
    // }

    // printf("Success!\n");

    int thrust;
    printf("enter thrust value\n");
    scanf("%i", thrust);
    checkThrust(thrust);







    keypress();
    return 0;
}
