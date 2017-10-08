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
int transmission_rate = 750000; // 6 Mbps = 750,000 bytes/sec
int CWmax = 1024;

// 10 seconds * 1,000,000 microseconds/second
int sim_length = 10 * 1000000;

// Ticks are microseconds, slots are 20 microseconds
int slot = 0, old_slot = 0;

void setup_scene_A() {
  W = new channel("W", 150, 300, 500, 300);
  X = new channel("X", 150, 450, 500, 450);
  A = new station("A", 150, 300, X, 800, 120);
  B = new station("B", 500, 300, X, 830, 120);
  C = new station("C", 150, 600, X, 890, 120);
  D = new station("D", 500, 600, X, 920, 120);
  
  A.generate_traffic(lambda_A);
  C.generate_traffic(lambda_C);
}

void setup_scene_B() {
  Y = new channel("Y", 100, 300, 350, 300);
  Z = new channel("Z", 700, 300, 350, 300);
  A = new station("A", 100, 300, Y, 840, 120);
  B = new station("B", 400, 300, Y, 870, 120);  // TODO: Must be double channel bound!!!
  C = new station("C", 700, 300, Z, 900, 120);

  A.generate_traffic(lambda_A);
  C.generate_traffic(lambda_C);
}

void draw_scene(int mode) {
 
  // Scenario A
 if (mode == 0) {
   //W.display();//
   X.display();
   A.display(0);
   B.display(1);
   C.display(0);
   D.display(1);

 }
 
 // Scenario B
 else if (mode == 1) {
   Y.display();
   Z.display();
   A.display(0);
   B.display(1);
   C.display(0);

 }
}

void sim_tick(int mode) {
  //println("Sim Tick " + tick);
  tick +=1;
  
  if (tick % slot_duration == 0) {
    slot +=1;  
  }
  
  // Scenario A
  if (mode == 0) {
    A.process_tick();
    //B.process_tick();
    C.process_tick();
    //D.process_tick();
    W.process_tick();
    X.process_tick();
    if (tick % slot_duration == 0) {
      A.process_slot();
      C.process_slot();
      W.process_slot();
      X.process_slot();
      A.process_slot(); // Have to repeat the process twice to see if collision or success occurred that slot
      C.process_slot(); // Have to repeat the process twice to see if collision or success occurred that slot
    }
  }
  // Scenario B
  else if (mode == 1) {
    A.process_tick();
    B.process_tick();
    C.process_tick();
    //Y.process_tick();
    //Z.process_tick();
  }
}

void reset_everything(int scene){
 println("RESET EVERYTHING");
 tick = 0;
 slot = 0;
 
 if (scene == 0) {
   A.reset();
   B.reset();
   C.reset();
   D.reset();
   X.reset();
 } else if (scene == 1) {
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