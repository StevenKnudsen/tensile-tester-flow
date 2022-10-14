#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pigpiod_if2.h>

#define DIR 22
#define ENABLE 27
#define MOTOR 17
#define SWITCH 26


int main(int argc, char *argv[]) {
	int pi,frequency;
	int success = 1;
	
	frequency = 1300;
	pi = pigpio_start(0, 0); //connecting to the pigpio daemon
    if (pi < 0) {
        return -1; //closing program if failure to connect
    }
    
    //setting output pins
    set_mode(pi, DIR, PI_OUTPUT);
    set_mode(pi, ENABLE, PI_OUTPUT);
    set_mode(pi, MOTOR, PI_OUTPUT);
	set_mode(pi, SWITCH, PI_INPUT);
	
	if (argc >= 3) {
        for (int i = 1; i < (argc - 1); i++) { //skip first entry as it is the program name
            if (!strcmp(argv[i], "-f")) {
                frequency = atoi(argv[i + 1]);
            }
        }
    }
    
    
    wave_add_generic(pi, 2, (gpioPulse_t[])
                {{1 << MOTOR, 0, 250000 / frequency}, //convert given frequency to microseconds
                 {0, 1 << MOTOR, 250000 / frequency}});
    char wid = wave_create(pi); // generate one pulse at the given frequency
    
    char control[] = {255, 0, wid, 255, 1, 28800 & 255, 28800 >> 8}; // create control string for full revolution
    char move5[] = {255, 0, wid, 255, 1, 400 & 255, 400 >> 8}; // create control string for 5 degree movement
        
    
    if (gpio_read(pi,SWITCH)){
		gpio_write(pi,DIR,1); //ensure motor moves backward
		 wave_chain(pi,move5,7);
	 }
    while (wave_tx_busy(pi)) time_sleep(0.01); //wait until wave is transmitted
    
    gpio_write(pi,DIR,0); //ensure motor moves forward
    wave_chain(pi,control,7);
    
    while (wave_tx_busy(pi)){
		//watch switch and when pressed stop motion
		if (gpio_read(pi,SWITCH)){
			wave_tx_stop(pi); 
			printf("Zero Successful\n");
			success=0;
		}	
	}
	
	if(success) printf("Zero Unsuccessful\n");
	
	wave_delete(pi,wid);
	pigpio_stop(pi);
	return success;
}
