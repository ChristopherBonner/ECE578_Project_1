// Need G4P library
import g4p_controls.*;

station A, B, C, D;
channel W, X, Y, Z;

int tick = 0;
int scene = 0;
int frames_per_tick = 100;
int percentage=0;
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
    // Simulation speed determination
    // Negative values indicate multiple ticks per second
    if (frames_per_tick < 0) {
      int count = int(pow(10.0,float(-frames_per_tick)));
      //println(count);
      for (int i=count; i>0; i--) {
        sim_tick(scene);
      }
    } else {
      if (frameCount % frames_per_tick == 0) {
        sim_tick(scene);
      }
    }
  }
  
  draw_scene(scene);
  percentage = tick*100/sim_length;
  draw_stats(640,25);
  
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}