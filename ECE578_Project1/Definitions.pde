color gray = color(165,169,175);
color yellow = color(209,195,73);
color green = color(70,201,74);
color red = color(196,55,53);
color black = color(0);
color white = color(255);

// 10 seconds * 1,000,000 microseconds/second
int sim_length = 200;// * 1000000;

void setup_scene_A() {
  W = new channel("W", 150, 200, 500, 200);
  X = new channel("X", 150, 400, 500, 400);
  A = new station("A", 150, 200, W, 700, 100);
  B = new station("B", 500, 200, W, 730, 100);
  C = new station("C", 150, 400, X, 790, 100);
  D = new station("D", 500, 400, X, 820, 100);
  
  A.generate_traffic();
  C.generate_traffic();
}

void setup_scene_B() {
  Y = new channel("Y", 150, 200, 400, 200);
  Z = new channel("Z", 650, 200, 400, 200);
  A = new station("A", 150, 200, Y, 700, 100);
  B = new station("B", 400, 200, Y, 730, 100);  // TODO: Must be double channel bound!!!
  C = new station("C", 650, 200, Z, 760, 100);

  A.generate_traffic();
  C.generate_traffic();
}

void draw_scene(int mode) {
 
  // Scenario A
 if (mode == 0) {
   W.display();
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
  println("Sim Tick " + tick);
  tick +=1;
  // Scenario A
  if (mode == 0) {
    A.process_tick();
    B.process_tick();
    C.process_tick();
    D.process_tick();
    W.process_tick();
    X.process_tick();
  }
  // Scenario B
  else if (mode == 1) {
    A.process_tick();
    B.process_tick();
    C.process_tick();
    Y.process_tick();
    Z.process_tick();
  }
}

void reset_everything(){
 println("RESET EVERYTHING - TODO!!!!");
 tick = 0;
}

void draw_stats(int x, int y) {
 fill(0);
 int offset = 0;
 text("Framerate: " + (int)frameRate,x,y+offset); offset+=20;
 text("Tick: " + tick,x,y+offset); offset+=20;
}