# Plat-GUI

### Overview
Plat-GUI is a device driver that I wrote to automate the electroplating of custom neural sensors. To handle the program output to the hardware I used PsychToolbox library. This code was written in 2015 as part of a research internship with UC Santa Cruz Institute of Particle Physics.

### PLATGUI.m
This function creates a Matlab GUI that prompts the user to input the parameters for that particular electroplating session. The first field is which sensor channels should be plated, with inputs of either the channel number (0 - 63) or '411' for all channels. The second field is the current for the channels, which will range between 0 - 500nA. The final field is for the electroplating time.

### inputCMD.m
This function takes the parameters entered in the GUI and parses them into the appropriate commands for our hardware. These commands are then returned as strings of binary to the PLATGUI function, which handles the actual output to the hardware.

### bufferCLK.m
This function accepts a time (in seconds) and outputs clock cycles to the hardware for the given time. The hardware requires a commandless clock cycle as a buffer for further input.

### de2bi.m
This function is part of a standard Matlab library, but was corrupted on my personal machine. The code in the file is taken from the Matlab source and converts a decimal to a binary array.
