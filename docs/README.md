# Sensor Bridge 

This is the 'get started' guide for the Sensor Bridge hardware and software that is used in the [Sensor Lab](http://www.sensorlab.nl) workshop. This guide will explain what it is, how it should be connected and what you can do with it.

## What is the Sensor Bridge?

The Sensor Bridge is some [Arduino](www.arduino.cc) based hardware and some macOS/Windows software that makes it easy to connect a selected set sensors to your computer and use the data from those sensors. 

The Arduino board reads the values of the connected sensors and sends those values continuously over the USB/serial connection to the computer. The Sensor Bridge client application listens on the USB/serial port for incoming data, can optionally smooth the data for a cleaner signal and can then either record the incoming data to [CSV files](software.md#using-the-application-to-capture-csv-data), [JSON files](software.md#using-the-application-to-capture-json-data) or pass the data on to another (web) application through a [WebSocket](software.md#using-the-application-to-serve-sensor-data-over-a-websocket).

## Capturing data with the Sensor Bridge

* [Connecting the hardware](hardware.md)
* [Installing and using the application](software.md)

## Available sensors

We use a number of biometric sensors to capture the activity of people; see the [sensors page](sensors.md) for specific information and example data

* [ECG (Heartbeat) sensor](sensors.md/#ecg-heatbeat-sensor)
* [Muscle sensor](sensors.md/#muscle-sensor)
* [Sound sensor](sensors.md/#sound-sensor)
* [Flex sensor](sensors.md/#flex-sensor)
* [Pressure sensor](sensors.md/#pressure-sensor)

## Examples of visualizing sensor data

### Processing examples
* [Minimal template for reading CSV data](https://github.com/sensorlab030/workshop/tree/master/examples/processing/template_csv)
* [Minimal template for reading WebSocket data](https://github.com/sensorlab030/workshop/tree/master/examples/processing/template_websocket)
* [Visualizing heartbeat from CSV data](https://github.com/sensorlab030/workshop/tree/master/examples/processing/heartbeat_example_csv)
* [Visualizing live heartbeat data using WebSockets](https://github.com/sensorlab030/workshop/tree/master/examples/processing/heartbeat_example_websocket)

## References

* [Processing website](https://processing.org/)
* [Processing language reference](https://processing.org/reference/)

## Inspiration for visualizations

* [OpenProcessing](https://www.openprocessing.org/browse#)
* [swiss in css](https://swissincss.com)
* [Rafaël Rozendaal](http://www.newrafael.com/websites/)
* [Feltron Report 2014](http://feltron.com/FAR14.html)

