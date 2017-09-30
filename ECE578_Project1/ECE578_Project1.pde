// Need G4P library
import g4p_controls.*;

station A, B, C, D;
channel W, X, Y, Z;

int tick = 0;
int scene = 0;

public void setup(){
  size(900, 900, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here
  
  // Station Initialization
  //A = new station("A", 150, 200);
  //B = new station("B", 500, 200);
  //C = new station("C", 150, 400);
  //D = new station("D", 500, 400);
  
  setup_scene_A();
  
  textSize(20);
}

public void draw(){
  background(200);
  
  draw_scene(scene);
  
  draw_stats(640,25);
  
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}