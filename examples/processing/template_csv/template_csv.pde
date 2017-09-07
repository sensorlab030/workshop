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
  data = loadTable("heartbeat-50ms.csv", "header"); // Load the data
     
}

void draw() {
  
  background(0);
  
  // Loop over all values in data
  for (int i = 0; i < data.getRowCount(); i++) {
    
    // Get current heartbeat value
    long timestamp = data.getLong(i, "timestamp");
    float sensor1Value = data.getFloat(i, "sensor_1");
    float sensor2Value = data.getFloat(i, "sensor_2");
    float sensor3Value = data.getFloat(i, "sensor_3");
    
    println("Sensor values at " + timestamp + ": " + sensor1Value + " " + sensor2Value + " " + sensor3Value);
    
  }
  
  // Save the PNG image
  save("template_csv_output.png");
 
}