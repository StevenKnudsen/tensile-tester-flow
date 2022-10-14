#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pigpiod_if2.h>

int main(int argc, char *argv[]){
	int pi;
	pi = pigpio_start(0, 0); //connecting to the pigpio daemon
    if (pi < 0) {
        return -1; //closing program if failure to connect
    } //end if
	
	int pin = 16;
	int duty = 50;
	int freq = 2000;
	
	
	//getting input arguments
	if (argc >= 7) {
        for (int i = 1; i < (argc - 1); i++) { //skip first entry as it is the program name
            if (!strcmp(argv[i], "-p")) {
                pin = atoi(argv[i + 1]);
            } //end if
            if (!strcmp(argv[i], "-d")) {
                duty = atoi(argv[i + 1]);
            } //end if
            if (!strcmp(argv[i], "-f")) {
                freq = atoi(argv[i + 1]);
            } //end if
        } //end for
    } //end if
    
    printf("%d %d %d\n",pin,duty,freq);
    
	set_mode(pi, pin, PI_OUTPUT); //setting signal pin as output
	set_PWM_range(pi,pin,100); //set duty cycle to have a range of 0-100
	set_PWM_frequency(pi,pin,freq);
	set_PWM_dutycycle(pi,pin,duty);

	return 0;
} //end main
