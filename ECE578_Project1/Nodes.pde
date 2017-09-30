// Definition for station
class station {
 String name, backoff;
 float xpos, ypos;
 color statec = gray;
 int state = 0;
 channel bound_channel;
 
 // Constructor
 station(String iname, float ix, float iy, channel ibound){
  name = iname;
  xpos = ix;
  ypos = iy;
  bound_channel = ibound;
  backoff = "B:";
 }
 
 void set_state(int input){
  // Idle state - no packet waiting
  if (input == 0) { statec = gray; state = 0;}
  // Ready to Transmit state
  if (input == 1) { statec = yellow; state = 1;}
  // Transmit
  if (input == 2) { statec = green; state = 2;}
 }
 
 void process_tick() {
   if (state == 2) {
     attempt_transmission(bound_channel);
   }
 }
 
 void generate_traffic() {
   println("Generated Traffic for " + name);
 }
 
 void attempt_transmission(channel inch) {
   
   // If channel is busy, wait
   if (inch.state == 1) {
     println("Channel " + inch.name + " is busy");
     set_state(1);
     return;
   }
   
   // If channel is idle, attempt to send packet
   if (inch.state == 0) {
     println(name + " sending packet");
     set_state(2);
     inch.stations_using += 1;
     return;
   }
 }
 
 void display() {
   fill(statec);
   ellipse(xpos,ypos,20,20);
   fill(0);
   text(name,xpos-5,ypos-20);
   text(backoff, xpos-5, ypos+40);
 }
}








// Link definition
class channel {
  int statec = gray;
  int state = 0;
  int stations_using = 0;
  float x1,x2,y1,y2;
  String name;
  
  // Constructor
  channel(String iname, float ix1, float iy1, float ix2, float iy2) {
   name = iname;
   x1 = ix1;
   x2 = ix2;
   y1 = iy1;
   y2 = iy2;
  }
  
  void process_tick(){
    // Detect collisions
    if (stations_using > 1) {
      set_state(2);
      println("collision detected on " + name);
    }
  }
  
  void set_state(int input){
   // Idle state
   if (input == 0) { statec = gray; state = 0;}
   // Busy
   if (input == 1) { statec = green; state = 1;}
   // Collision
   if (input == 2) { statec = red; state = 2;}
  }
  
  void display() {
    stroke(statec);
    strokeWeight(4);
    line(x1,y1,x2,y2);
    stroke(0);
  }
}