color gray = color(165,169,175);
color yellow = color(209,195,73);
color green = color(70,201,74);
color red = color(196,55,53);
color black = color(0);

void setup_scene_A() {
  A = new station("A", 150, 200);
  B = new station("B", 500, 200);
  C = new station("C", 150, 400);
  D = new station("D", 500, 400);
  W = new channel("W", 150, 200, 500, 200);
  X = new channel("X", 150, 400, 500, 400);
  
  A.generate_traffic();
  C.generate_traffic();
}

void setup_scene_B() {
  A = new station("A", 150, 200);
  B = new station("B", 400, 200);
  C = new station("C", 650, 200);
  Y = new channel("Y", 150, 200, 400, 200);
  Z = new channel("Z", 650, 200, 400, 200);
  
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

void reset_everything(){
 println("RESET EVERYTHING - TODO!!!!"); 
}

void draw_stats(int x, int y) {
 fill(0);
 int offset = 0;
 text("Tick: " + tick,x,y+offset); offset+=20;
 text("Tick: " + tick,x,y+offset); offset+=20;
}