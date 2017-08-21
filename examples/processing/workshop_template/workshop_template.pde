import websockets.*;

WebsocketClient wsc;
float sensorData;

void setup(){
  //resolutie om op te leveren
  size(1080, 1080);
  wsc = new WebsocketClient(this, "ws://localhost:9001");
}

void draw(){
  //print de binnengekomen data naar de console
  println(sensorData);
}

void webSocketEvent(String msg){
  //haalt de data binnen vanuit websockets
  JSONObject json = parseJSONObject(msg);
  sensorData = json.getFloat("sensor_0");
}

void keyPressed() {
  //druk op een toets om je visualisatie op te slaan
  save(hour() + "-" + minute() + "-" + second() + ".png");
}