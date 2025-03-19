#!/bin/sh
gcc -Wall -pthread -o moves moves.c -lpigpiod_if2 -lrt
gcc -Wall -pthread -o zero zero.c -lpigpiod_if2 -lrt
gcc -Wall -pthread -o pwm pwm.c -lpigpiod_if2 -lrt
