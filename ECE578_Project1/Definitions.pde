color gray = color(165,169,175);
color yellow = color(209,195,73);
color green = color(38,102,34);
color red = color(196,55,53);
color black = color(0);
color white = color(255);
color blue = color(53,124,196);

// SIMULATION PARAMETERS
int data_frame_size = 1500;    // bytes
int slot_duration = 20;        // microseconds
int SIFS_duration = 10;        // microseconds
int CW0 = 4;                   // slots
int lambda_A = 50;
int lambda_C = 50;
int ACK_size = 30;             // bytes
int RTS_size = 30;
int CTS_size = 30;
int DIFS_Duration = 40; //microseconds
int transmission_rate = 750000; // 6 Mbps = 750,000 bytes/sec
int CWmax = 1024;

// 10 seconds * 1,000,000 microseconds/second
int sim_length = 10 * 1000000;

// Ticks are microseconds, slots are 20 microseconds
int slot = 0, old_slot = 0;

void setup_scenario_A() {
  W = new channel("W", 150, 300, 500, 300, A, B);
  X = new channel("X", 150, 600, 500, 600, C, D);
  A = new station("A", 150, 300, W, X, 800, 120, C);
  B = new station("B", 500, 300, W, X, 830, 120, C);
  C = new station("C", 150, 600, X, W, 890, 120, A);
  D = new station("D", 500, 600, X, W, 920, 120, A);
  
  A.generate_traffic(lambda_A);
  C.generate_traffic(lambda_C);
}

void setup_scenario_B() {
  Y = new channel("Y", 100, 300, 400, 300, A, C);
  Z = new channel("Z", 700, 300, 400, 300, A, C);
  A = new station("A", 100, 300, Y, Z, 840, 120, C);
  B = new station("B", 400, 300, Y, Z, 870, 120, C);  // TODO: Must be double channel bound!!!
  C = new station("C", 700, 300, Z, Y, 900, 120, A);

  A.generate_traffic(lambda_A);
  C.generate_traffic(lambda_C);
}

void draw_scene(char mode) {
 
  // Scenario A
 if (mode == 'A') {
   W.display();//
   X.display();
   A.display(protocol,0);
   B.display(protocol,1);
   C.display(protocol,0);
   D.display(protocol,1);

 }
 
 // Scenario B
 else if (mode == 'B') {
   Y.display();
   Z.display();
   A.display(protocol,0);
   B.display(protocol,1);
   C.display(protocol,0);

 }
}

void sim_tick(char scenario) {

  tick +=1;
  
  if (tick % slot_duration == 0) {
    slot +=1;  
  }
  
  if (scenario == 'A') {
    A.tick(protocol);
    C.tick(protocol);
    W.process_tick();
    X.process_tick();
  }
  else if (scenario == 'B') {
    A.tick(protocol);
    C.tick(protocol);
    Y.process_tick();
    Z.process_tick();
  }
}

void reset_everything(char scene){
 println("RESET EVERYTHING");
 tick = 0;
 slot = 0;
 
 if (scene == 'A') {
   A.reset();
   B.reset();
   C.reset();
   D.reset();
   X.reset();
 } else if (scene == 'B') {
   A.reset();
   B.reset();
   C.reset();
   Y.reset();
   Z.reset();
 }
 

}

void draw_stats(int x, int y) {
 fill(0);
 int offset = 0;
 text("Framerate: " + (int)frameRate      ,x,y+offset); offset+=20;
 text("     Tick: " +tick+" ("+percentage+"%)" ,x,y+offset); offset+=20;
 text("     Slot: " +slot                      ,x,y+offset); offset+=20;
 
}

void draw_boxes() {
  noFill();
  rect(9,40,94,60); // Scenario
  rect(117,40,158,60); // Strategy
  rect(295,40,131,160); // Simspeed
  rect(460,40,90,100); // Simspeed 
  rect(565,40,90,100); // Simspeed 
}

void print_statistics() {
  
  // Fixes a stupid off-by-one error
  A.sent += 1;
  C.sent += 1;
  
  // Calculate throughput
  // (Frames sent * framesize_in_bytes * 8bits/byte) / (10 seconds * 1000)
  int throughput_A = (A.sent * data_frame_size * 8) / (10 * 1000);
  int throughput_C = (C.sent * data_frame_size * 8) / (10 * 1000);
  
  float fairness_A = float(A.time_use) / float(C.time_use);
  //float fairness_C = C.time_use / A.time_use;
  
  println("=============================================================================================");
  println("Node A sent " + A.sent + " of " + A.packet_count + " generated with lambda = " + lambda_A + "   T = " + throughput_A + " Kbps");
  println("A fairness vs C : " + fairness_A );
  println("Node C sent " + C.sent + " of " + C.packet_count + " generated with lambda = " + lambda_C + "   T = " + throughput_C + " Kbps");

  if (scenario == 'A') {
    println("Collisions X = " + X.collisions);
  } else {
    println("Collisions Y = " + Y.collisions);
  }
  println("=============================================================================================");
}