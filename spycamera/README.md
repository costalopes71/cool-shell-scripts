# What's spycam?
It's a shell script that you can use to take a picture of the person trying to turn on or boot your PC and receive it by e-mail.

# How does it works?
The first script (spycam.sh) can be located anywhere you want, this script is the code responsible for taking a picture with you webcam and saving it on the ```/tmp``` directory.
In order to this work at your machine startup we add a crontab for your root user to execute it at startup/reboot.

The second script (spycam) is placed at ```/etc/network/if-up.d```, this directory contains shell scritps that should be run as soon as your computer has internet connectivity, and the code in this script is responsible for sending the e-mail with the picture to you! :D

# How to install (tested on Ubuntu 22.04)

- on your terminal install the following dependencies using sudo:
```
sudo apt install fswebcam
sudo apt install mailutils ssmtp
```
- Follow [this instructions](https://learnubuntu.com/send-emails-from-server/) to configure your e-mail on your machine (so you will be able to send emails via your terminal)
- on my machine the following configuration worked:
```
root=myemail@gmail.com

mailhub=smtp.gmail.com:465

AuthUser=myemail@gmail.com
AuthPass=<password_generated_in_the_above_documentation>
UseTLS=YES
UseSTARTTLS=NO

FromLineOverride=YES
```
- Pick a location to place the script **spycam.sh** (e.g. /home/myuser/spycam.sh)
- Give execution permission to it: `sudo chmod +x spycam.sh`
- Add a new crontab to your root user:
```
sudo crontab -e
# at the end of the file add the line below
@reboot sh <full_path_to>/spycam.sh
```
- test if first script is working:
  - reeboot your PC
  - a photo should have been taken during your PC boot and should be saved under `/tmp/spypic-<yyyy-mm-dd-timestamp>.jpeg`
  - in case it does not work it might be because your webcamera is in other device location, let's debug it:
    - execute: `ls /dev/video*`
    - try to execute `mvp /dev/video<number>`, it should open your webcamera, if it does not try the other listed device. One of this video devices will be your camera, when you find it replace it at `spycam.sh` script with the correct one (the script is hardcoded with device `/dev/video0`).
    - reboot and test again
- Now, for the e-mail to be sent as soon as the PC get internet connectivity, add `spycam` script to `/etc/network/if-up.d`
- Be sure that the file added is owned by root user
- Input the e-mail you want to receive the alert on the script at the last line of the script replacing TYPE_HERE_THE_EMAIL_YOU_WANT_TO_RECEIVE_THIS_MESSAGE with the e-mail you want.
- Give execution permission to the script: `sudo chmod +x spycam`
- test:
  - reebot yout PC
  - a new image should have been created at `tmp` directory
  - an e-mail should have been sent with the subject loginattempt and a photo attached
