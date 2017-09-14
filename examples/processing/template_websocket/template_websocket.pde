import websockets.*;

/**
 * Small example that shows how to use live data gathered from the Sensor Bridge in
 * Processing using live data over a WebSocket. Make sure you have installed the Processing
 * websockets library from Lasse Steenbock Vestergaard (Sketch > Add libraries)!
 */

WebsocketClient websocket;

float sensor1Value;
float sensor2Value;
float sensor3Value;

void setup(){
  size(1080, 1080);  // Set the output format to 1080x1080px
  smooth();
  
  // Initialize the WebSocket client to connect to the SensorBridge websocket.
  // Make sure the Setup of the SensorBridge (port) match 
  websocket = new WebsocketClient(this, "ws://localhost:9001");
  
}

void draw() {
  
  println("Sensor values: " + sensor1Value + " " + sensor2Value + " " + sensor3Value);
  
}

// Handle incoming message from the WebSocket server
void webSocketEvent(String msg) {
  println("Received a new websocket message!");
  
  // Parse the String value to JSON
  JSONObject json = parseJSONObject(msg);

  // Fetch sensor values from the message, and store them
  // in variables so we can use them in the draw loop
  sensor1Value = json.getFloat("sensor_1");
  sensor2Value = json.getFloat("sensor_2");
  sensor3Value = json.getFloat("sensor_3");

}

// Save a PNG of the canvas whenever space is pressed
void keyPressed() {
  if (key == ' ') {
    save(hour() + "-" + minute()+ "-" + second() + ".png");
  }
}