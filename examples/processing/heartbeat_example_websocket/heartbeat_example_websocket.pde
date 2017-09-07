import websockets.*;

/**
 * Small example that shows how to use live data gathered from the Sensor Bridge in
 * Processing using live data over a WebSocket. Make sure you have installed the Processing
 * websockets library from Lasse Steenbock Vestergaard (Sketch > Add libraries)!
 */

final int RADIUS = 540; // Radius of the circular heartbeat graph 
final int MAX_DATAPOINTS = 2000;

WebsocketClient websocket;
BpmCalculator bpmCalculator = new BpmCalculator();
ArrayList<Float> heartbeatValues = new ArrayList<Float>(MAX_DATAPOINTS);

void setup(){
  size(1080, 1080);  // Set the output format to 1080x1080px
  smooth();
  websocket = new WebsocketClient(this, "ws://localhost:9010"); // Connect to the SensorBridge websocket (make sure the Setup options match)
  
  // Fill the heartbeatValues list with initial values
  for (int i = 0; i < MAX_DATAPOINTS; i++) {
    heartbeatValues.add(0.5);
  }
    
}

void draw() {
  
  // Draw black background
  background(0);
  translate(width / 2, height / 2); // Translate to center
  rotate(-HALF_PI); // Rotate 90 degress counter clockwise, to the start is at the top
  
  // Calculate how much we should rotate for each row for a complete circle
  float rotationPerDataPoint = TWO_PI / (float) heartbeatValues.size();
  float currentAngle = 0;
    
  // Loop over all values in data
  PVector firstPos = null;
  PVector previousPos = null;
  stroke(255, 255, 0);
  noFill();
  
  for (int i = 0; i < heartbeatValues.size(); i++) {
    
    // Get current heartbeat value
    float heartbeatValue = heartbeatValues.get(i);
    
    // Calculate new pos
    float heartbeatRadius = heartbeatValue * RADIUS;
    PVector newPos = new PVector(
      cos(currentAngle) * heartbeatRadius, // X-coordinate
      sin(currentAngle) * heartbeatRadius // Y-coordinate
    );
      
    if (previousPos != null) {
      // Draw line from previous pos to current pos
      line (previousPos.x, previousPos.y, newPos.x, newPos.y);
    } else {
      firstPos = newPos;
    }
        
    if (i == heartbeatValues.size() - 1) {
      // Draw last line (connecting back to first point)
      line (newPos.x, newPos.y, firstPos.x, firstPos.y);
    } 
    
    // Save current pos as new pos
    previousPos = newPos;
    
    // Update current angle
    currentAngle += rotationPerDataPoint;
    
  }
  
  rotate(HALF_PI);
  fill(255);
  textSize(40);
  textAlign(CENTER, CENTER);
  text(String.valueOf(Math.round(bpmCalculator.getBpm())) + " BPM", 0, 0);
    
}

// Handle incoming message from the WebSocket server
void webSocketEvent(String msg) {
  
  // Parse the String value to JSON
  JSONObject json = parseJSONObject(msg);
  
  // Fetch sensor 1 value from the message
  float heartbeatValue = json.getFloat("sensor_1");
  
  // Add new value
  heartbeatValues.add(heartbeatValue);
  
  // Remove old values to keep the list to MAX_DATAPOINTS in size
  while (heartbeatValues.size() > MAX_DATAPOINTS) {
    heartbeatValues.remove(0);
  }
  
  // Add value to BPM calculator
  bpmCalculator.addValue(heartbeatValue, millis());
  
  
}

// Save a PNG of the canvas whenever space is pressed
void keyPressed() {
  if (key == ' ') {
    save(hour() + "-" + minute()+ "-" + second() + ".png");
  }
}