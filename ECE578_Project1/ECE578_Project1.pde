// Need G4P library
import g4p_controls.*;

station A, B, C, D;
channel W, X, Y, Z;

int tick = 0;
int scene = 0;
boolean play = false;

public void setup(){
  size(900, 900, JAVA2D);
  createGUI();
  customGUI();
  
  // Place your setup code here 
  setup_scene_A();
  
  textSize(20);
}

public void draw(){
  background(200);
  
  if (play == true) {
    sim_tick(scene);
  }
  
  draw_scene(scene);
  draw_stats(640,25);
  
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}