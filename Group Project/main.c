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
#include <string.h>
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

int chooseMode(char input[1]){
    if(strcmp(input, "Y") == 0 || strcmp(input, "y") == 0){
        printf("Selected: Game Mode\n");
        return 1;
    }
    else if(strcmp(input, "N") == 0 || strcmp(input, "n") == 0){
        printf("Selected: Autopilot\n");
        return 0;
    }
}

int validateInput(char input[1]){ // returns 1 if valid Y/N input is provided by user
    printf("Welcome to the Lunar Lander console\nWould you like to manually control the lander?\nPress Y for yes\nPress N for no\n");
    scanf("%s", input);
    while(strcmp(input, "Y") != 0 && strcmp(input, "y") != 0 && strcmp(input, "N") != 0 && strcmp(input, "n") != 0){
        printf("Error: Invalid Input. You're an astronaut, you know better! Try again.\n");
        scanf("%s", input);
    }
    return 1;
}


int checkThrust(int givenThrust){
    givenThrust *= 1000;
    if(givenThrust > 45000){
        printf("Error: too much thrust");
        return 0;
    }
}

int main(){
    char choice[1]; 
    // passes 1 character (+ null terminator) string to check for valid Y/N input
    validateInput(&choice[1]);
    // now that string is sanitized, pass it and determine which mode is chosen
    chooseMode(&choice[1]);
    FILE* output = fopen("output.csv", "wt");

    keypress();
    return 0;
}