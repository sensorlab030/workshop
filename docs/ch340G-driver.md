# Installing the CH240G Driver
[< Back to overview](README.md)

On some machines, the CH340G USB to Serial need a driver to function properly. If so, follow the steps below (credits to [Konstantin Gredeskoul](https://kig.re/2014/12/31/how-to-use-arduino-nano-mini-pro-with-CH340G-on-mac-osx-yosemite.html) for posting his driver guide)

## Apple macOS (El Capitan and later)

To install:

* Download the [macOS driver package](https://github.com/sensorlab030/sensorbridge/releases/download/v1.2/CH34x_macOS.zip)
* Extract the contents of the zip file to a local installation directory 
* Double-click CH34x_Install.pkg 
* Install according to the installation on procedure 
* Restart after finishing installing

If you can’t find the serial port then you can follow the steps below:

1. Open terminal and type ‘ls /dev/tty*’ ande see is there device like tty.wchusbserial;
2. Open ‘System Report’->Hardware->USB, on the right side “USB Device Tree” there will be device named “Vendor-Specific Device” and check if the Current is normal. If the steps upper don’t work at all, please try to install the package again.

After the installation is completed, you will find serial device in the device list(/dev/tty.wchusbserial*), and you can access it by serial tools.

## Microsoft Windows (8 and later)

To install:

* Download the [Windows driver package](https://github.com/sensorlab030/sensorbridge/releases/download/v1.2/CH341-win.zip)
* Extract the contents of the zip file to a local installation directory 
* Run Setup.exe and follow the instructions


