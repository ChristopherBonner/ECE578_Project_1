// Definition for station
class station {
 String name;
 float xpos, ypos, xpos2, ypos2, lambda;
 color statec = gray;
 int state = 0;
 int packet_buffer = 0;
 int backoff, difs, transmit_time, sent;
 channel bound_channel;
 int k_coll = 0; // # of sequential collisions
 
 // Array to contain the arrival times for packets
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
  difs = 40;
  sent = 0;
 }
 
 void reset() {
   sent = 0;
   packet_buffer = 0;
   set_state(0);
 }
 
 void set_state(int input){
  // Idle state - no packet waiting
  if (input == 0) { statec = gray;   state = 0;}
  // Ready to Transmit state
  if (input == 1) { statec = yellow; state = 1;}
  // Transmit
  if (input == 2) { statec = green;  state = 2;}
  // Backoff
  if (input == 3) { statec = yellow;   state = 3; }
  // DIFS
  if (input == 4) { statec = blue;   state = 4; }
 }
 
 void process_slot() {
   
   // If there's nothing to transmit, set station idle
   if (packet_buffer == 0) { set_state(0); return;}
   
   // If there are packet(s) waiting, start going through the transmit process
   else if (packet_buffer > 0) {
     
     // If we were idle, lets enter DIFS
     if (state == 0) { set_state(4); difs = 40;}
     
     // If the DIFS countdown is complete, enter backoff mode
     if ((state == 4)&&(difs <= 0)) {
       backoff = round(random(0,(CW0-1)*slot_duration));
       set_state(3);
     }
     
     // If the backoff counter runs out, attempt transmission
     if ((state == 3)&&(backoff <=0)) {
       set_state(1);
       bound_channel.stations_using += 1;
     }
     
     // Collision !!!
     if ((state == 1)&&(bound_channel.state == 2)) {
       k_coll += 1;
       int CW = constrain(int(pow(2, k_coll)*(CW0-1)),0,CWmax);
       backoff = round(random(0, CW * slot_duration     ));
       println(name + " " + k_coll + " CW: "+CW+" B: "+backoff);
       bound_channel.stations_using = 0;
       set_state(3);
     }
     
     // Success - we got the channel
     if ((state == 1)&&(bound_channel.state == 1)) {
       set_state(2);
       int data_trans = (data_frame_size * 1000000) / transmission_rate;  // time in microseconds to transmit data frame
       int ACK_trans = (ACK_size * 1000000) / transmission_rate;          // time in microseconds to transmit ACK
       
       transmit_time = data_trans + SIFS_duration + ACK_trans;
       
       k_coll = 0;
     }
     
     // Transmission complete
     if ((state == 2)&&(transmit_time <= 0)) {
       sent += 1;
       packet_buffer -=1;
       bound_channel.set_state(0);
       bound_channel.stations_using = 0;
       set_state(0);
     }
   }
 }
 
 void process_tick() {
   
   // Add any new packets to the waiting list
   // Includes array overflow protection
   if ((tick<sim_length)&&(arrivals[tick] == 1)) {
     packet_buffer +=1;
   }
   
   // If we're in DIFS mode, decrement the counter for each tick
   if (state == 4) {
     difs -=1; 
   }
   
   // If in Backoff mode, decrement for any idle tick
   // Note that the bound channel collision state is also valid for backoff
   if ((state == 3)&&((bound_channel.state == 0)||(bound_channel.state == 2))) {
     if(backoff > 0) {
       backoff -= 1;
     }
   }
   
   // If in transmit mode, decrement the counter
   if ((state == 2)&&(transmit_time>0)) {
     transmit_time -= 1;
   }
   
 }
 
 void generate_traffic(int fps) {
   
   // Reset the output array
   for (int i = 0; i < sim_length; i++) {
     arrivals[i] = 0;
   }   
   
   // Generate an array of values between 0.0 and 1.0
   // Doing 5000 count since we shouldn't need more than that many packets
   int num_packets = 5000;
   float[] uniform = new float[num_packets];
   for (int i=0; i < num_packets; i++) {
     uniform[i] = random(0.0, 1.0);
   }

   // Generate a series of X exponentially distributed values
   // These end up being the time distance between each successive packet
   float[] intervals = new float[num_packets];
   for (int i=0; i < num_packets; i++) {
     intervals[i] = (- (1.0/float(fps)) * log(1.0 - uniform[i]));
   }
   
   // Convert these floating point fractions-of-seconds to integer microsecond ticks
   int[] micro_intervals = new int[num_packets];
   for (int i=0; i < num_packets; i++) {
     micro_intervals[i] = int(intervals[i]*1000000);
   }

   // Insert the packets into the full length microsecond array
   int j = 0;
   for (int i = 0; i < sim_length; i++) {
     
     arrivals[i] = 1;
     i += micro_intervals[j] - 1;
     j += 1;
   }
   
   // Sanity check that we generated the correct amount of packets
   int packet_count = 0;
   for (int i = 0; i < sim_length; i++) {
     if (arrivals[i] == 1) {packet_count +=1;}
   }
   
   println("Generated "+packet_count+" packets for " + name + " with lambda = " + fps);
 }
 
 void display(int display_mode) {
   fill(statec);
   ellipse(xpos,ypos,30,30);
   fill(0);
   text(name,xpos-6,ypos+7);
   
   if (display_mode == 0) {
       text("Buff: "+packet_buffer, xpos-25, ypos-30);
       text("DIFS: "+difs,          xpos-25, ypos+40);
       text("Back: "+backoff,       xpos-25, ypos+60);
       text("Tran: "+transmit_time, xpos-25, ypos+80);
    
       fill(green);
       text("Sent: "+sent,          xpos-25, ypos-50);
       
       
       // Display upcoming traffic
       // Put the letter on top
       fill(black);
       text(name,xpos2+2,ypos2-3);
       
       for (int disp=0; disp<100; disp++) {
    
         // Array overrun protection
         if ((tick+disp) > (sim_length-2)) {
           fill(gray);
           
         } else {
         
           // Color each tick based on whether a packet is generated at that time.
           if (arrivals[tick+disp] == 1) {
             fill(green); 
           } else {
             fill(white);
           }
         }
         
         strokeWeight(1);
         rect(xpos2,ypos2 + disp*7,15,6,1);
         
         if((disp % slot_duration) == 0) {
           line(xpos2-7,ypos2 + disp*7,xpos2+25,ypos2+disp*7); 
         }
       }
   }
 }
}








// Link definition
class channel {
  int statec = gray;
  int state = 3;
  int stations_using = 0;
  int collisions=0;
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
  
  void reset() {
    collisions = 0;
    stations_using = 0;
    set_state(0);
  }
  
  void process_slot() {
    // Collision detected
    if (stations_using > 1)  {
      set_state(2);
      collisions += 1;
      //stations_using = 0;
    }
    else if (stations_using == 0) { set_state(0); }  // Idle
    else if (stations_using == 1) { set_state(1); }  // In use

  }
  
  void process_tick(){
    
    // Have to reset to idle after a collision otherwise backoff countdowns won't work
    //if (state == 2) { set_state(0); }
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
    fill(statec);
    text(name,(x1+x2)/2,(y1+y2)/2-3);
    text("State: "+statestr,(x1+x2)/2-36,(y1+y2)/2+20);
    //text("Using: "+stations_using,(x1+x2)/2-20,(y1+y2)/2+40);
    fill(red);
    text("Collisions: "+collisions,(x1+x2)/2-45,(y1+y2)/2+40);
    stroke(statec);
    strokeWeight(4);
    line(x1,y1,x2,y2);
    stroke(0);
    strokeWeight(1);
  }
}