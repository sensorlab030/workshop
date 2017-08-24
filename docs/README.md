# Sensor Bridge 

This is the 'get started' guide for the Sensor Bridge hardware and software that is used in the [Sensor Lab](http://www.sensorlab.nl) workshop. This guide will explain what it is, how it should be connected and what you can do with it.

## What is the Sensor Bridge?

The Sensor Bridge is some [Arduino](www.arduino.cc) based hardware and some macOS/Windows software that makes it easier to connect a selected set sensors to your computer and use the data from those sensors. 

The Arduino board reads the values of the connected sensors and sends those values continuously over the USB/serial connection to the computer. The Sensor Bridge client application listens on the USB/serial port for incoming data, can optionally smooth the data for a cleaner signal and can then either record the incoming data to [CSV files](https://en.wikipedia.org/wiki/Comma-separated_values) or pass the data on to another (web) application through a [websocket](https://en.wikipedia.org/wiki/WebSocket).

## Capturing data with the Sensor Bridge

* [Connecting the hardware](hardware.md)
* [Installing and using the application](software.md)

## Examples of visualizing sensor data

* Visualizing captured CSV data using RAW Graphs

## Inspiration for visualizations
