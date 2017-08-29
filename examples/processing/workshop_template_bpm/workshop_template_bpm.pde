import websockets.*;  // Nodig voor binnenhalen sensordata

WebsocketClient wsc;  // Nodig voor binnenhalen sensordata
float sensorData;     // Nodig voor binnenhalen sensordata: dit is de variabele die je in je sketch kunt gebruiken
long BPM;             // Deze variabele wordt gebruikt om de gemeten hartslag in op te slaan

void setup() {
  size(1080, 1080);
  wsc = new WebsocketClient(this, "ws://localhost:9010");
}

void draw() {
  println("signaal: " + sensorData);  // Print de variabele 'sensorData' naar de console, zodat je kunt zien of het werkt.
  println("hartslag: " + BPM);        // Print de hartslag naar de console, zodat je kunt zien of het werkt. Deze regels mag je weghalen als je wil.
}

// Deze functie is voor het binnenhalen van de sensordata
void webSocketEvent(String msg) {
  JSONObject json = parseJSONObject(msg);
  sensorData = json.getFloat("sensor_0");
  heartBeat();
}

// Deze functie zorgt ervoor dat er een screenshot wordt gemaakt als je op een toets drukt
// De screenshot kun je terugvinden in de map waar je sketch in is opgeslagen
void keyPressed() {
  save(hour() + "-" + minute()+ "-" + second() + ".png");
}