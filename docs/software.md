# Using the Sensor Bridge software

Make sure you already have the Sensor Bridge hardware connected (See [Connecting the hardware](hardware)).

## Installing the application

### Installing on Apple macOS

* Download the SensorBridge.dmg image from the [latest release on GitHub](https://github.com/sensorlab030/sensorbridge-client/releases/latest)
* Double click the image to reveal the contents
* Drag the Sensor Bridge icon to the applications folder
* Run the Sensor Bridge application

### Installing on Microsoft Windows

* Download the SensorBridge.zip archive from the [latest release on GitHub](https://github.com/sensorlab030/sensorbridge-client/releases/latest)
* Extract the contents to a suitable location
* Run the SensorBridge.exe 

## Configuring the serial port

Select the serial port that the Sensor Bridge is connected to using the dropdown menu at the bottom left of the screen. The application only scans for ports at startup, so if the Sensor Bridge is connected while the application is running, you need to restart the application for the Serial Bridge to show up.

For macOS users, the port will be named "cu.usbmodem"

For Windows users, the port will be named "COM# (USB-Serial CH340)"

## Reading the values

Once the serial port is configured correctly, the application will show the data for the connected sensors in the graph. You can use these graphs for troubleshooting the data while making a visualization because it will always show the raw sensor data. The values are always mapped from 0.0 to 1.0 (as they will be in the output).

## Applying smoothing on the sensor data

If the data is erratic, it might be useful to apply some smoothing to the data, before it is recorded to CSV or sent to another application. To do so, select one of smoothing types (other than 'None') from the dropdown menu below the sensor's graph. The slider next to the dropdown menu can be used to control how much smoothing will be applied to the data (all the way to the left for no smoothing, all the way to the right for maximum smoothing). 

In the graph there will be a blue line for the smoothed data (which will be capture or sent over WebSocket) and a grey line for the raw, unsmoothed data.

These are the smoothing options;

* None: No smoothing on the data
* SMA: [Simple Moving Average smoothing](https://en.wikipedia.org/wiki/Moving_average#Simple_moving_average)
* EXP: [Single/Basic Exponential smoothing](https://en.wikipedia.org/wiki/Exponential_smoothing#Basic_exponential_smoothing)

## Using the application to capture CSV data

To start capturing CSV data, click the "Setup" button at the bottom right of the screen. Choose "CSV file" as the output, set the capture interval (time between data points) to the interval you want and the capture directory to the folder you want the CSV files to be stored. Click "Ok" to save the changes. At the bottom of the screen you will see a description of your output settings. Click "Start capture" to start capturing the data to a CSV file. Clicking "Stop capture" will stop the capture.

## CSV file data format

The capture CSV file will have the following format:

* The first line is a header line 
* The first column has the timestamp, formatted as [Unix Timestamp](https://en.wikipedia.org/wiki/Unix_time) in milliseconds
* After the timestamp there are three value columns for the three sensors.
* The field separator is a comma (,)
* The line ending is a newline character (\n)

Example CSV file:

```text
timestamp,SERIAL_0,SERIAL_1,SERIAL_2
12312321,12,12,12
```

## Using the application to send sensor data over a WebSocket 

Example Websocket message:

```javascript
{
  "sensor_0": 0.232132,
  "sensor_1": 0.232132,
  "sensor_2": 0.232132
}
```