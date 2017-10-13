// Definition for station
class station {
 String name;
 float xpos, ypos, xpos2, ypos2, lambda;
 color statec = white;
 int state = 0;
 String statestr = "IDLE";
 int packet_buffer = 0;
 int backoff, difs, transmit_time, sent, rts;
 channel channel_1, channel_2;
 int k_coll = 0; // # of sequential collisions
 int packet_count = 0;
 int time_use;
 int defer = 0;
 boolean start_trans = false, intent = false;
 station partner;
 
 // Array to contain the arrival times for packets
 int[] arrivals = new int[sim_length];
 
 // Constructor
 station(String iname, float ix, float iy, channel ibound1, channel ibound2, float ix2, float iy2, station ipartner){
  name = iname;
  xpos = ix;
  ypos = iy;
  channel_1 = ibound1;
  channel_2 = ibound2;
  xpos2 = ix2;
  ypos2 = iy2;
  backoff = 0;
  difs = 0;
  sent = 0;
  rts = 0;
  partner = ipartner;
 }
 
 void reset() {
   sent = 0;
   packet_buffer = 0;
   set_state(0);
   //collisions = 0;
 }
 
 void set_state(int input){
   
   switch(input)
   {
     case 0: // IDLE
       state = 0; statec = white; statestr = "IDLE"; break;
       
     case 1: // DIFS
       state = 1; statec = blue; statestr = "DIFS"; break;
       
     case 2: // BACKOFF
       state = 2; statec = yellow; statestr = "BACKOFF"; break;
       
     case 3: // ATTEMPT
       state = 3; statec = green; statestr = "ATTEMPT"; break;
       
     case 4: // DEFER
       state = 4; statec = blue; statestr = "DEFER"; break;
     
     case 5: // RTS-CTS
       state = 5; statec = blue; statestr = "RTS-CTS"; break;
   }
 }
 
 void tick(String mode) {
   if (mode == "CA") {
     tick_CSMA_CA();
   } else if (mode == "VCS") {
     tick_CSMA_VCS();
   }
 }
 
 void tick_CSMA_CA() {
   
   // Add any new packets to the waiting list
   // Includes array overflow protection
   if ((tick<sim_length)&&(arrivals[tick] == 1)) {
     packet_buffer +=1;
   }
   
   switch(state)
   {
     case 0: // IDLE
       // If there's nothing to transmit, do nothing
       if (packet_buffer == 0) { }
       // If packet(s) ready, set the DIFS time and switch to DIFS
       else if (packet_buffer > 0) { set_state(1); difs = DIFS_Duration;}
       break;
       
     case 1: // DIFS
       // Decrement the difs counter
       if (difs > 0) { difs -= 1; }
       // When difs time runs out, choose a backoff time and go to BACKOFF
       if (difs <= 0) {
         backoff = round(random(0,(CW0-1)*slot_duration));
         set_state(2);
       }
       break;
       
     case 2: // BACKOFF
       // Decrement the backoff counter if the channel is not busy
       if ((backoff > 0)&&(channel_1.state==0)&&(channel_2.state==0)) { backoff -= 1; }
       // If the backoff timer expires, go to ATTEMPT
       if (backoff <= 0) {
         // Calculate transmit time needed
         int data_trans = (data_frame_size * 1000000) / transmission_rate;  // time in microseconds to transmit data frame
         int ACK_trans = (ACK_size * 1000000) / transmission_rate;          // time in microseconds to transmit ACK
         transmit_time = data_trans + SIFS_duration + ACK_trans;
         set_state(3);
       }
       break;
       
     case 3: // ATTEMPT
       // Indicate intent to use channels
       if (intent == false) { channel_1.using += 1; channel_2.using += 1; intent = true;}
       
       // Collision detection & transmission start can only occur on a slot boundary
       if (tick % slot_duration == 0) {
         // If either channel already in collision mode, collision has occurred
         if ((channel_1.state==2)||(channel_2.state==2)) {
           k_coll += 1;
           int CW = constrain(int(pow(2, k_coll)*(CW0-1)),0,CWmax);
           backoff = round(random(0, CW * slot_duration     )); //println("B: "+backoff+" K: "+k_coll);
           channel_1.using = 0; channel_2.using = 0;
           channel_1.collisions += 1; channel_2.collisions += 1;
           set_state(2);
         } // Can start transmission
         else {
            start_trans = true;
         }
       }
       
       // Free to transmit
       if (start_trans == true) { transmit_time -=1; time_use += 1;}
       
       // Transmission complete
       if (transmit_time <= 0) {
         sent += 1;
         packet_buffer -=1;
         start_trans = false;
         intent = false;
         channel_1.using = 0; channel_2.using = 0;
         set_state(0);
         k_coll = 0;
       }
       
       break;
   }
 }
 
 void tick_CSMA_VCS() {
   
   // Add any new packets to the waiting list
   // Includes array overflow protection
   if ((tick<sim_length)&&(arrivals[tick] == 1)) {
     packet_buffer +=1;
   }
   
   switch(state)
   {
     case 0: // IDLE
       // If we hear a CTS, go to DEFER
       
       // If there's nothing to transmit, do nothing
       if (packet_buffer == 0) { }
       // If packet(s) ready, set the RTS time and switch to RTS
       else if (packet_buffer > 0) {
         rts = ((RTS_size+CTS_size) * 1000000) / transmission_rate;
         set_state(5);
       }
       break;
       
     case 2: // BACKOFF
       // Decrement the backoff counter if the channel is not busy
       if ((backoff > 0)&&(channel_1.state==0)&&(channel_2.state==0)) { backoff -= 1; }
       // If the backoff timer expires, go to ATTEMPT
       if (backoff <= 0) {
         rts = ((RTS_size+CTS_size) * 1000000) / transmission_rate;
         set_state(5);
       }
       break;
       
     case 3: // ATTEMPT
       // Free to transmit
       if (start_trans == true) { transmit_time -=1; time_use += 1;}
       
       // Transmission complete
       if (transmit_time <= 0) {
         sent += 1;
         packet_buffer -=1;
         start_trans = false;
         intent = false;
         channel_1.using = 0; channel_2.using = 0;
         set_state(0);
         k_coll = 0;
       }
       break;
       
     case 4: // DEFER
       if (defer > 0) { defer -= 1; }
       
       if (defer <= 0) { set_state(0); }
       break;
     
     case 5: // RTS-CTS
       // Indicate intent to use the channels
       if (intent == false) { channel_1.using += 1; channel_2.using += 1; intent = true;}
       // Decrement the difs counter
       if (rts > 0) { rts -= 1; }
       // If we reach the end of the RTS count, lets see if a collision occurred
       if ((rts <= 0)&&(tick % slot_duration == 0)) {
         // If either channel already in collision mode, collision has occurred
         if ((channel_1.state==2)||(channel_2.state==2)) {
           k_coll += 1;
           int CW = constrain(int(pow(2, k_coll)*(CW0-1)),0,CWmax);
           backoff = round(random(0, CW * slot_duration     ));
           channel_1.using = 0; channel_2.using = 0;
           channel_1.collisions += 1; channel_2.collisions += 1;
           set_state(2);
         } // or we're ready to transmit!
         else {
           start_trans = true;
           // Calculate transmit time needed
           int data_trans = (data_frame_size * 1000000) / transmission_rate;  // time in microseconds to transmit data frame
           int ACK_trans = (ACK_size * 1000000) / transmission_rate;          // time in microseconds to transmit ACK
           transmit_time = data_trans + SIFS_duration + ACK_trans;
           
           if (name == "A") {
             C.defer = transmit_time;
             C.set_state(4);
           } else {
             A.defer = transmit_time;
             A.set_state(4);
           }
           set_state(3);
         }
       }
       
       break;
   }
   
 }
  
 
 void generate_traffic(int fps) {
   
   // Reset the output array
   for (int i = 0; i < sim_length; i++) {
     arrivals[i] = 0;
   }   
   
   // Generate an array of values between 0.0 and 1.0
   // Doing 5000 count since we shouldn't need more than that many packets
   int num_packets = 10000;
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
   packet_count = 0;
   for (int i = 0; i < sim_length; i++) {
     if (arrivals[i] == 1) {packet_count +=1;}
   }
   
   println("Generated "+packet_count+" packets for " + name + " with lambda = " + fps);
 }
 
 void display(String display_mode, int simple) {
   fill(statec);
   ellipse(xpos,ypos,30,30);
   fill(0);
   text(name,xpos-5,ypos+7);
   
   if (simple == 1) { return; }
   
   if (display_mode == "CA") {   
     text("DIFS: "+difs,          xpos-25, ypos+40);
   } else if (display_mode == "VCS") {
     text(" RTS: "+rts, xpos-25,ypos+40);
     text("DEFR: "+defer, xpos-25,ypos+100);
   }
   
   text("Buff: "+packet_buffer, xpos-25, ypos-30);
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








// Link definition
class channel {
  int statec = gray;
  int state = 0;
  int using = 0;
  int collisions=0;
  float x1,x2,y1,y2;
  String name, statestr;
  station stat_1, stat_2;
  
  // Constructor
  channel(String iname, float ix1, float iy1, float ix2, float iy2, station st1, station st2) {
   name = iname;
   x1 = ix1;
   x2 = ix2;
   y1 = iy1;
   y2 = iy2;
   statestr = "IDLE";
   stat_1 = st1;
   stat_2 = st2;
  }
  
  void reset() {
    collisions = 0;
    using = 0;
    set_state(0);
  } //<>//
  
  void process_tick(){
    
    if (using == 0)  { set_state(0); } // IDLE
    if (using == 1)  { set_state(1); } // BUSY
    if (using >  1)  { set_state(2); } // COLLISION
  }
  
  void set_state(int input){
   // Idle state
   if (input == 0) { statec = gray; state = 0; statestr="IDLE";}
   // Busy
   if (input == 1) { statec = green; state = 1; statestr="BUSY";}
   // Collision
   if (input == 2) { statec = red; state = 2; statestr="COLLISION";}
   // RTS
   if (input == 3) { statec = blue; state = 3; statestr="RTS";}
  }
  
  void display() {
    fill(statec);
    text(name,(x1+x2)/2,(y1+y2)/2-3);
    fill(black);
    text("State: "+statestr,(x1+x2)/2-36,(y1+y2)/2+20);
    text("Using: "+using,(x1+x2)/2-20,(y1+y2)/2+60);
    fill(red);
    text("Collisions: "+collisions,(x1+x2)/2-45,(y1+y2)/2+40);
    stroke(statec);
    strokeWeight(4);
    line(x1,y1,x2,y2);
    stroke(0);
    strokeWeight(1);
  }
}