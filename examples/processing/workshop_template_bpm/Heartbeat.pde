float sensorDataM;
long IBI = 600;
boolean pulse = false;
long[] rate = new long[10];
long sampleCounter = 0;
long lastBeatTime = 0;
float peak = 800;
float trough = 500;
float threshold = 800;
float P = peak;
float T = trough;
float thresh = threshold;
float amp = 0;
boolean firstBeat = true;
boolean secondBeat = false;
long previousMillis = 0;
long interval = 20;

void heartBeat() {
  sensorDataM = map(sensorData, 0, 1, 0, 1023);
  long currentMillis = millis();
  interval = currentMillis - previousMillis;
  previousMillis = currentMillis;


  sampleCounter += interval;
  long N = sampleCounter - lastBeatTime;

  if (sensorDataM < thresh && N > (IBI/5)*3 && sensorDataM < T) {
    T = sensorDataM;
  }

  if (sensorDataM > thresh && sensorDataM > P) {
    P = sensorDataM;
  }

  if (N > 250 && sensorDataM > thresh && pulse == false && N > (IBI/5)*3) {
    pulse = true;
    IBI = sampleCounter - lastBeatTime;
    lastBeatTime = sampleCounter;

    if (secondBeat) {
      secondBeat = false;
      for (int i=0; i<=9; i++) {
        rate[i] = IBI;
      }
    }

    if (firstBeat) {
      firstBeat = false;
      secondBeat = true;
      return;
    }

    long runningTotal = 0;

    for (int i=0; i<=8; i++) {
      rate[i] = rate[i+1];
      runningTotal += rate[i];
    }

    rate[9] = IBI;
    runningTotal += rate[9];
    runningTotal /= 10;
    BPM = 60000/runningTotal;
  }

  if (sensorDataM < thresh && pulse == true) {
    pulse = false;
    amp = P - T;
    thresh = amp/2 + T;
    P = thresh;
    T = thresh;
  }

  if (N > 2500) {
    thresh = threshold;
    P = peak;
    T = trough;
    lastBeatTime = sampleCounter;
    firstBeat = true;
    secondBeat = false;
  }
}