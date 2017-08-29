# Sensors
[< Back to overview](README.md)

## ECG (Heatbeat sensor)

![alt text](images/sensor_ecg.jpg "ECG Sensor (Heartbeat sensor)")

This is the [Pulse Sensor](https://pulsesensor.com) heartbeat sensor that can be used to visualize live heartbeats or calculate beats per minute.

### Attaching the sensor to your body

There are two common ways to attach it to your body: either use a velcro strap and attach it to one of your fingers, or clipping it to your earlobe with the  supplied clip. The latter is more prone to fall off, but is easier to use when prototyping (as it leaves your hands free for typing).

### Example data

Heartbeat data of person in rest

* [Heartbeat data in CSV format (50ms interval)](../example-data/heartbeat-50ms.csv)
* [Heartbeat data in JSON format (50ms interval)](../example-data/heartbeat-50ms.json)

### References

* [Technical information from the manufacturer](https://pulsesensor.com/pages/pulse-sensor-amped-arduino-v1dot1)

## EMG (Muscle sensor)

![alt text](images/sensor_emg.jpg "EMG Sensor (Muscle sensor)")

This EMG (electromyography) sensor can measure muscle activation via electric potential.

### Attaching the sensor to your body

1. Prepare the sensor by attaching three electrodes pads to the sensor (two on the red board, one on the short cable)
2. Determine where you want to position the electrodes, one of the electrodes on the board should be in the center of the muscle group, the other one should line up in the direction of the muscle length (see image above). The reference electrode (on the short cable) should be placed on a bony or nonadjacent muscular part of the body.
3. Thoroughly clean the skin with soap and water where you want to apply the electrodes to remove any dirt and skin oils.
4. Remove the protective plastic from the two electrodes on the board and place them on the muscle group
5. Make sure the power switch on the red board is in the "ON" position (PWR led should light up)

### Example data

#### Three slow arm flexes, then three ffast arm flexes

* [Muscle sensor data in CSV format (50ms interval)](../example-data/muscle-50ms.csv)
* [Muscle sensor data in JSON format (50ms interval)](../example-data/muscle-50ms.json)

#### Three slow arm flexes, then six fast arm flexes with Simple moving average smoothing

* [Muscle sensor data in CSV format (50ms interval, Simple Moving Average smoothing)](../example-data/muscle-50m-sma.csv)
* [Muscle sensor data in JSON format (50ms interval, Simple Moving Average smoothing)](../example-data/muscle-50ms-sma.json)

### References

* [MyoWare muscle sensor manual](https://github.com/AdvancerTechnologies/MyoWare_MuscleSensor/raw/master/Documents/AT-04-001.pdf)

## Flex sensor
