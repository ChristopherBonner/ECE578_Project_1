// Definition for station
class station {
 String name;
 float xpos, ypos, xpos2, ypos2, lambda;
 color statec = gray;
 int state = 0;
 int packet_buffer = 0;
 int backoff;
 int difs;
 channel bound_channel;
 
 // Array to contain the arrival times for packets
 float[] uniform = new float[sim_length];
 int[] intervals = new int[sim_length];
 int[] arrivals = new int[sim_length];
 
 // Constructor
 station(String iname, float ix, float iy, channel ibound, float ix2, float iy2){
  name = iname;
  xpos = ix;
  ypos = iy;
  bound_channel = ibound;
  xpos2 = ix2;
  ypos2 = iy2;
  backoff = 0;
  lambda = 100;
  difs = 40;
 }
 
 void set_state(int input){
  // Idle state - no packet waiting
  if (input == 0) { statec = gray;   state = 0;}
  // Ready to Transmit state
  if (input == 1) { statec = yellow; state = 1;}
  // Transmit
  if (input == 2) { statec = green;  state = 2;}
  // Backoff
  if (input == 3) { statec = blue;   state = 3; backoff = round(random(0,CW0));}
  // DIFS
  if (input == 4) { statec = blue;   state = 4; difs = 40;}
 }
 
 void process_slot() {
   // If there's nothing to transmit, set station idle
   if (packet_buffer == 0) { set_state(0); return;}
   
   // If there are packet(s) waiting, start going through the transmit process
   else if (packet_buffer > 0) {
     
     // If we were idle, lets enter DIFS
     if (state == 0) { set_state(4); }
     
     // If the DIFS countdown is complete, enter backoff mode
     if ((state == 4)&&(difs <= 0)) {
       set_state(3);
     }
     
     
   }
 }
 
 void process_tick() {
   
   // Add any new packets to the waiting list
   if (arrivals[tick] == 1) {
     packet_buffer +=1;
   }
   
   // If we're in DIFS mode, decrement the counter for each tick
   if (state == 4) {
     difs -=1; 
   }
   
   // If in Backoff mode, decrement for any idle tick
   if ((state == 3)&&(bound_channel.state == 0)) {
     backoff -= 1;
   }
   
 }
 
 void generate_traffic() {
   println("Generated Traffic for " + name);
   
   for (int i=0; i < sim_length; i++) {
     uniform[i] = random(0.0, 1.0);
     intervals[i] = int(- (1.0/lambda) * log(1.0 - uniform[i]));
     arrivals[i] = round(random(1.0)-0.4);
     //println(i + " | " + uniform[i] + " | " + intervals[i] +" | " + arrivals[i]);
   }
 }
 
 void display() {
   fill(statec);
   ellipse(xpos,ypos,20,20);
   fill(0);
   text(name,xpos-5,ypos-20);
   text("Buff: "+packet_buffer, xpos-15, ypos+40);
   text("DIFS: "+difs, xpos-15, ypos+60);
   text("Back: "+backoff, xpos-15, ypos+80);
   
   // Display upcoming traffic
   // Put the letter on top
   fill(black);
   text(name,xpos2+2,ypos2-3);
   
   for (int disp=0; disp<100; disp++) {

     // Color each tick based on whether a packet is generated at that time.
     if (arrivals[tick+disp] == 1) {
       fill(green); 
     } else {
       fill(white);
     }
     
     strokeWeight(1);
     rect(xpos2,ypos2 + disp*7,15,6,1);
     
     if((disp % 20) == 0) {
       line(xpos2-7,ypos2 + disp*7,xpos2+25,ypos2+disp*7); 
     }
   }
 }
}








// Link definition
class channel {
  int statec = gray;
  int state = 3;
  int stations_using = 0;
  float x1,x2,y1,y2;
  String name, statestr;
  
  // Constructor
  channel(String iname, float ix1, float iy1, float ix2, float iy2) {
   name = iname;
   x1 = ix1;
   x2 = ix2;
   y1 = iy1;
   y2 = iy2;
   statestr = "IDLE";
  }
  
  void process_slot() {
    if      (stations_using > 1)  { set_state(2); }  // Collision
    else if (stations_using == 0) { set_state(0); }  // Idle
    else if (stations_using == 1) { set_state(1); }  // In use
  }
  
  void process_tick(){

  }
  
  void set_state(int input){
   // Idle state
   if (input == 0) { statec = gray; state = 0; statestr="IDLE";}
   // Busy
   if (input == 1) { statec = green; state = 1; statestr="BUSY";}
   // Collision
   if (input == 2) { statec = red; state = 2; statestr="COLLISION";}
  }
  
  void display() {
    fill(0);
    text(name,(x1+x2)/2,(y1+y2)/2-3);
    text("State: "+statestr,(x1+x2)/2-20,(y1+y2)/2+20);
    text("Using: "+stations_using,(x1+x2)/2-20,(y1+y2)/2+40);
    stroke(statec);
    strokeWeight(4);
    line(x1,y1,x2,y2);
    stroke(0);
    strokeWeight(1);
  }
}