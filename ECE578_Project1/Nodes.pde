// Definition for station
class station {
 String name, backoff;
 float xpos, ypos;
 color state = gray;
 
 // Constructor
 station(String iname, float ix, float iy){
  name = iname;
  xpos = ix;
  ypos = iy;
  backoff = "B:";
 }
 
 void set_state(int input){
  // Idle state - no packet waiting
  if (input == 0) { state = gray; }
  // Ready to Transmit state
  if (input == 1) { state = yellow; }
  // Transmit
  if (input == 2) { state = green; }
 }
 
 void generate_traffic() {println("Generated Traffic for " + name);}
 
 void display() {
   fill(state);
   ellipse(xpos,ypos,20,20);
   fill(0);
   text(name,xpos-5,ypos-20);
   text(backoff, xpos-5, ypos+40);
 }
}

// Link definition
class channel {
  int state = gray;
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
  
  void set_state(int input){
   // Idle state
   if (input == 0) { state = gray; }
   // Busy
   if (input == 1) { state = green; }
   // Collision
   if (input == 2) { state = red; }
  }
  
  void display() {
    stroke(state);
    strokeWeight(4);
    line(x1,y1,x2,y2);
    stroke(0);
  }
}