// Graphic settings
final int RADIUS = 540;

// Data variables
Table data; // Table that will hold the heartbeat data

void setup(){
  
  size(1080,1080);  // Stel het formaat in op 1080x1080 pixels
  noLoop(); // We're not continuously redrawing, no no looping needed
  
  // Load the data
  data = loadTable("heartbeat-data.csv", "header");
   
}

void draw() {
  
  // Draw black background
  background(0);
  
  // Calculate how much we should rotate for each row for a complete circle
  float rotationPerRow = TWO_PI / (float) data.getRowCount();
  float currentAngle = 0;
  
  PVector firstPos = null;
  PVector previousPos = null;
  stroke(255, 255, 0);
  noFill();
  
  // Translate to center
  translate(540, 540);
  
  // Loop over all values in data
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
  
  // Save
  save("heartbeat_example_csv.png");
 
}