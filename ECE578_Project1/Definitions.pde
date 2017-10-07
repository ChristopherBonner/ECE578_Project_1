color gray = color(165,169,175);
color yellow = color(209,195,73);
color green = color(38,102,34);
color red = color(196,55,53);
color black = color(0);
color white = color(255);
color blue = color(53,124,196);

int CW0 = 80; // 4 slots * 20 microseconds/slot

// 10 seconds * 1,000,000 microseconds/second
int sim_length = 10 * 1000000;

// Ticks are microseconds, slots are 20 microseconds
int slot = 0, old_slot = 0;

void setup_scene_A() {
  W = new channel("W", 150, 300, 500, 300);
  X = new channel("X", 150, 450, 500, 450);
  A = new station("A", 150, 300, X, 700, 100);
  B = new station("B", 500, 300, X, 730, 100);
  C = new station("C", 150, 600, X, 790, 100);
  D = new station("D", 500, 600, X, 820, 100);
  
  A.generate_traffic();
  C.generate_traffic();
}

void setup_scene_B() {
  Y = new channel("Y", 100, 300, 350, 300);
  Z = new channel("Z", 600, 300, 350, 300);
  A = new station("A", 100, 300, Y, 700, 100);
  B = new station("B", 350, 300, Y, 730, 100);  // TODO: Must be double channel bound!!!
  C = new station("C", 600, 300, Z, 760, 100);

  A.generate_traffic();
  C.generate_traffic();
}

void draw_scene(int mode) {
 
  // Scenario A
 if (mode == 0) {
   //W.display();//
   X.display();
   A.display();
   B.display();
   C.display();
   D.display();

 }
 
 // Scenario B
 else if (mode == 1) {
   Y.display();
   Z.display();
   A.display();
   B.display();
   C.display();

 }
}

void sim_tick(int mode) {
  //println("Sim Tick " + tick);
  tick +=1;
  
  if (tick % 20 == 0) {
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
    if (tick % 20 == 0) {
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

void reset_everything(){
 println("RESET EVERYTHING - TODO!!!!");
 tick = 0;
 slot = 0;
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
  rect(9,40,94,42); // Scenario
  rect(117,40,158,42); // Strategy
  rect(295,40,131,120); // Simspeed 
}