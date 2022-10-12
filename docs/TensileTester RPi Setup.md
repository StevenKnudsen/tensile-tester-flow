# Setting up Raspberry Pi for Tensile Tester operation
OS version : raspios bullseye

1. Follow the [usual steps](https://www.raspberrypi.com/software/) to create a RPi image and boot
2. For the following we use a terminal
3. Use `sudo raspi-config` to run the configuration;
	1.  Set the host name to `tensilepi` 
	2.  Enable ssh
4. Change the default password to something like `t3ns1le` ; i.e., use `passwd`
5. Update the system; `sudo apt update`, then `sudo apt upgrade`
	1. This may take a while
6. Install and configure `tightvncserver` to enable VNC
	1. Follow the [socketxp.com](https://www.socketxp.com/docs/guide/iot-remote-desktop-vnc-access.html#pre-requisites) guide down to the SocketXP IoT Agent installation section
7. Configure `tightvncserver` to start at boot
      `sudo vi /etc/init.d/tightvncserver`
   then insert
      ```
      #!/bin/sh
      # /etc/init.d/tightvncserver
      # Set the VNCUSER variable to the name of the user to start tightvncserver under
      VNCUSER='pi'
      case "$1" in
       start)
         su $VNCUSER -c '/usr/bin/tightvncserver :1'
         echo "Starting TightVNC server for $VNCUSER"
         ;;
       stop)
         pkill Xtightvnc
         echo "Tightvncserver stopped"
         ;;
       *)
         echo "Usage: /etc/init.d/tightvncserver {start|stop}"
         exit 1
         ;;
      esac
      exit 0
      ```
   finally, make executable and reboot
      ```
	  sudo chmod 755 /etc/init.d/tightvncserver
	  sudo update-rc.d tightvncserver defaults
	  sudo reboot
	  ```
8. An example VNC viewer configuration should rememble this one from "Chicken"
![[chicken_to_tensilepi.png]]
9. Install and configure `node-red` using this [guide](https://nodered.org/docs/getting-started/raspberrypi)
	1. 	Execute in a terminal the following
      ```
      bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
	  ```
	2. Enable node-red to start at boot
      ```
      sudo systemctl enable nodered.service
      ```
	3. Check if it's running by `ps ax | grep node` and if not, start using
      ```
      sudo systemctl enable nodered.service
	  ```
	4. Now you can bring up the node-red flow editor on a computer on the same network as the `tensilepi` by connecting to `http://tensilepi.local:1880` in a browser
10. Install the node-red dashboard and git packages
      ```
      cd ~/.node-red
      npm i node-red-dashboard
      npm i npm install node-red-contrib-git-nodes
      ```
11. Install and configure [pigpio](https://gist.github.com/tstellanova/8b1fb350a148eace6541b5fbd2c021ca)
	* `sudo systemctl enable pigpiod`
12. Restart node-red on the RPi
      ```
      node-red-restart
      ```
13. Once restarted, you can bring up the node-red dashboard on a computer on the same network as the `tensilepi` by connecting to `http://tensilepi.local:1880/ui` in a browser.
    * changes made in the flow editor will be reflected in the UI once they are "deployed"
14. The flow editor can be accessed by connecting to `http://tensilepi.local:1880`
  