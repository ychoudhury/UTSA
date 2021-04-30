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
    double altitude;
    double velocity;
    double fuel;
    double mass;
};
typedef struct _state State; // refers to struct as State instead of the entire struct

// Moon's gravity
const double gravity = -1.6;

int validateInput(char input[1]){ // returns 1 if valid Y/N input is provided by user
    printf("Welcome to the Lunar Lander console\nWould you like to engage autopilot?\nPress Y for yes\nPress N for no\n");
    scanf("%s", input);
    while(strcmp(input, "Y") != 0 && strcmp(input, "y") != 0 && strcmp(input, "N") != 0 && strcmp(input, "n") != 0){
        printf("Error: Invalid Input. You're an astronaut, you know better! Try again.\n");
        scanf("%s", input);
    }
    return 1;
}

int chooseMode(char input[1]){
    if(strcmp(input, "Y") == 0 || strcmp(input, "y") == 0){
        printf("Selected: Autopilot\n");
        return 1;
    }
    else if(strcmp(input, "N") == 0 || strcmp(input, "n") == 0){
        printf("Selected: Game Mode\n");
        return 0;
    }
}

double maxThrust(double fuel){
    double max = (fuel * 3000);
    if(max > 45000){
        return 45000;
    }

    else if(max < 0){
        return 0;
    }

    return max;
}

double limitAutoThrust(double thrust){
    if(thrust > 45000){
        return 45000;
    }

    else if(thrust < 0){
        return 0;
    }
    else{
        return thrust;
    }
}

void updateState(State* s, double thrust){

    double newAcceleration = ((thrust / s->mass) + gravity);

    s->mass -= (thrust / 3000);
    s->fuel -= (thrust / 3000);

    s->velocity += newAcceleration;
    s->altitude += s->velocity;
}

double Autopilot(State s){

    double vf = -0.9;
    double Hf = 5;

    if(s.velocity > 0){ // do nothing if velocity is positive to avoid flying away
        return 0;
    }

    else if(s.altitude > Hf){
        double ad = (((s.velocity * s.velocity) - (vf * vf)) / (2 * (s.altitude - Hf)));
        return limitAutoThrust(s.mass * (ad - gravity));
    }

    else{
        return limitAutoThrust(-s.mass * gravity * (s.velocity / vf));
    }
}

int main(){
    char choice[1];
    int isAuto;
    int time = 0;
    double thrust = 0;


    FILE* output = fopen("output.csv", "wt");

    State s = {15000, -325, 1800, 9000}; // initial state init

    validateInput(choice);

    if(chooseMode(choice) == 1){
        isAuto = 1;
    }
    else{
        isAuto = 0;
    }

    // display initial struct state
    printf("Altitude: %5.0lf    Velocity: %6.1lf    Mass: %6.1lf    Fuel: %.2lf\n", s.altitude, s.velocity, s.mass, s.fuel);
    fprintf(output, "%d,%.0lf,%.1lf,%.1lf\n", time++, thrust, s.altitude, (s.velocity * -100));

    while(s.altitude > 0){
        int input;

        // N indicates autopilot mode has been chosen
        if(isAuto == 1){
            thrust = Autopilot(s);
        }
        else{
                        
            printf("Enter thrust in kN: ");
            scanf("%i", &input);
            thrust = ((double)input * 1000);


            double max = maxThrust(s.fuel);
            if(thrust > max){
                thrust = max;
            }
            else if(thrust < 0){
                thrust = 0;
            }
        }

        updateState(&s, thrust);
        printf("Thrust: %5.0lf  Altitude: %5.1lf    Velocity: %6.1lf    Mass: %6.1lf    Fuel: %.2lf\n", thrust, s.altitude, s.velocity, s.mass, s.fuel);
        fprintf(output, "%d,%.0lf,%.1lf,%.1lf\n", time++, thrust, s.altitude, (s.velocity * -100));
    }

    printf("\n");

    if(s.velocity >= -1 && s.velocity <= 0){
        printf("Touchdown!\n");
    }

    else{
        printf("Crash\n");
    }

    fclose(output);
    keypress();
    return 0;
}