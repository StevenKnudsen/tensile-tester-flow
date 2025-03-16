# Setting up Raspberry Pi for Tensile Tester operation
OS version : raspios bullseye

1. Follow the [usual steps](https://www.raspberrypi.com/software/) to create a RPi image and boot
	1. It is easiest to use the dedicated application, *Raspberry Pi Imager*, that creates the SD card for your RPi
	2. Choose to customize the installed image
	3. Set the hostname to `tensilepi` 
	4. Set the username to `tensile` and the password to `t3ns1le`
	5. You can try to set the wireless nework to UWS and your password, but usually this doesn't work because UWS is, well, UWS :-(
	6. Set the wireless LAN country to CA
	7. Set the locale to Edmonton and leave the keyboard a US
	8. Change to the Services section and enable SSH. Select "Use password authentication"
	9. Save and say yes to using the custom settings, then yes to start formating the image
2. When the Imager is finished, pop the SD card into the RPi and boot
3. The very first boot will take some time as the OS configures itself.
4. Connect to Wifi
	1. It appears that UWS at the UofA will not work
	2. An option is to tether to a cellphone, which does work well.
5. Update the system via the terminal; `sudo apt update`, then `sudo apt upgrade`
	1. This may take a while
6. Enable VNC
	1. `sudo raspi-config`
	2. Navigate to Interface Option and hit enter
	3. Navigate to VNC and hit enter
	4. Set the VNC server to be yes, hit enter
	5. exit `raspi-config`
	6. reboot
7.  Test the VNC connection using your laptop
	1.  On a Mac, install `tigervnc-viewer`, for example
	2.  Get the RPi IP address
	3.  Connect using the VNC viewer
8. Install and configure `node-red` using this [guide](https://nodered.org/docs/getting-started/raspberrypi) 
	1. Execute in a terminal the following
     
	  ```
	  bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
	  ```
	  * Install the RPi specific nodes
	  * Don't set up user security
	  * Don't set up the Projects feature
	  * Name the flows file `flows_tensilepi.json`
	  * Use `t3ns1le` for the catchphrase
	  * Choose the default colour scheme
	  * Select the default font, monaco
	  * Allow Function nodes to load external modules

	2. Enable node-red to start at boot
      ```
      sudo systemctl enable nodered.service
      ```
	3. Check if it's running by `ps ax | grep node` and if not, start using
      ```
      sudo systemctl start nodered.service
	  ```
	4. Now you can bring up the node-red flow editor on a computer on the same network as the `tensilepi` by connecting to `http://tensilepi.local:1880` in a browser
10. Install the node-red dashboard and git packages
      ```
      cd ~/.node-red
      npm i node-red-dashboard
      npm i npm install node-red-contrib-git-nodes
      ```
11. Install and configure [pigpio](https://gist.github.com/tstellanova/8b1fb350a148eace6541b5fbd2c021ca)
           ```
		   
		   sudo systemctl enable pigpiod
		   ```
12. Restart node-red on the RPi
      ```
      node-red-restart
      ```
13. Once restarted, you can bring up the node-red dashboard on a computer on the same network as the `tensilepi` by connecting to `http://tensilepi.local:1880/ui` in a browser.
    * changes made in the flow editor will be reflected in the UI once they are "deployed"
14. The flow editor can be accessed by connecting to `http://tensilepi.local:1880`
  
