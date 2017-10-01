// Definition for station
class station {
 String name, backoff;
 float xpos, ypos, xpos2, ypos2, lambda;
 color statec = gray;
 int state = 0;
 int packet_buffer = 0;
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
  backoff = "B:";
  lambda = 100;
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
   // Add any new packets to the waiting list
   if (arrivals[tick] == 1) {
     packet_buffer +=1;
   }
   
   if (packet_buffer == 0) {
     // Nothing to send
     set_state(0);
   } else if (packet_buffer > 0) {
     // Ready to transmit
     set_state(1);
     attempt_transmission(bound_channel);
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
   text("Wait: "+packet_buffer, xpos-5, ypos+40);
   
   // Display upcoming traffic
   for (int disp=0; disp<100; disp++) {
     // Put the letter on top
     fill(black);
     text(name,xpos2+2,ypos2-3);
     
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
    // Active line
    else if (stations_using == 1) {
      set_state(1);
      println("line active " + name);
    }
    // Idle line
    else if (stations_using == 0) {
      set_state(0);
      //println("line idle " + name);
    }
    
    // Done processing the line state. Clear the counter
    stations_using = 0;
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
    fill(0);
    text(name,(x1+x2)/2,(y1+y2)/2-3);
    stroke(statec);
    strokeWeight(4);
    line(x1,y1,x2,y2);
    stroke(0);
    strokeWeight(1);
  }
}