// Need G4P library
import g4p_controls.*;

station A, B, C, D;
channel W, X, Y, Z;

PFont font;

int tick = 0;
int scene = 0;
int frames_per_tick = 100;
float percentage=0.0;
boolean play = false;

public void setup(){
  size(1000, 900, JAVA2D);
  createGUI();
  customGUI();
  
  // Place your setup code here 
  setup_scene_A();
  
  // Setup font
  font = loadFont("Consolas-Bold-20.vlw");
  textFont(font,20);
  textSize(20);
}

public void draw(){
  background(200);
  
  if (play == true) {
    
    if (tick >= sim_length) {
     play = false;
    }
    
    // Simulation speed determination
    // Negative values indicate multiple ticks per second
    if (frames_per_tick < 0) {
      // Here we scale the ticks/frame speed by 10^fpt
      int count = int(pow(10.0,float(-frames_per_tick)));

      for (int i=count; i>0; i--) {
        sim_tick(scene);
      }
    } else {
      // Positive values of frame_per_tick lead to a slow sim speed
      if (frameCount % frames_per_tick == 0) {
        sim_tick(scene);
      }
    }
  }
  
  draw_scene(scene);
  percentage = tick*100.0/sim_length;
  draw_stats(640,25);
  draw_boxes();
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}