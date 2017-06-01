/**
 * Small example that shows how to use CSV data gathered from the Sensor Bridge in
 * Processing. This sketch takes one column of data that is read from a heartbeat
 * sensor and produces a radial line chart from the data.
 */

final int RADIUS = 540; // Radius of the circular heartbeat graph 
Table data; // Table that will hold the heartbeat data

void setup(){
  
  size(1080, 1080);  // Set the output format to 1080x1080px
  noLoop();         // We're not continuously redrawing, so no looping needed
  data = loadTable("heartbeat-data.csv", "header"); // Load the data
   
}

void draw() {
  
  // Draw black background
  background(0);
  
  // Calculate how much we should rotate for each row for a complete circle
  float rotationPerRow = TWO_PI / (float) data.getRowCount();
  float currentAngle = 0;
  

  
  // Translate to center
  translate(540, 540);
  
  // Loop over all values in data
  PVector firstPos = null;
  PVector previousPos = null;
  stroke(255, 255, 0);
  noFill();
  for (int i = 0; i < data.getRowCount(); i++) {
    
    // Get current heartbeat value
    float heartbeatValue = data.getFloat(i, "SERIAL_0");
    
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
        
    if (i == data.getRowCount() - 1) {
      // Draw last line (connecting back to first point)
      line (newPos.x, newPos.y, firstPos.x, firstPos.y);
    } 
    
    // Save current pos as new pos
    previousPos = newPos;
    
    // Update current angle
    currentAngle += rotationPerRow;
    
  }
  
  // Save the PNG image
  save("heartbeat_example_csv.png");
 
}