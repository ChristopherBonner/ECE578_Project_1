/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void Exit_click(GButton source, GEvent event) { //_CODE_:Exit:710982:
  println("Exit - GButton >> GEvent." + event + " @ " + millis());
  exit();
} //_CODE_:Exit:710982:

public void ScenA_clicked(GOption source, GEvent event) { //_CODE_:Scenario_A:899812:
  println("Scenario_A - GOption >> GEvent." + event + " @ " + millis());
  reset_everything();
  setup_scene_A();
  
  scene = 0;
} //_CODE_:Scenario_A:899812:

public void ScenB_clicked(GOption source, GEvent event) { //_CODE_:Scenario_B:753477:
  println("Scenario_B - GOption >> GEvent." + event + " @ " + millis());
  reset_everything();
  setup_scene_B();

  scene = 1;
} //_CODE_:Scenario_B:753477:

public void coll_avoid_clicked(GOption source, GEvent event) { //_CODE_:coll_avoid:461684:
  println("coll_avoid - GOption >> GEvent." + event + " @ " + millis());
  reset_everything();
} //_CODE_:coll_avoid:461684:

public void carrier_sense_clicked(GOption source, GEvent event) { //_CODE_:carrier_sense:562831:
  println("carrier_sense - GOption >> GEvent." + event + " @ " + millis());
  reset_everything();
} //_CODE_:carrier_sense:562831:

public void Play_click(GButton source, GEvent event) { //_CODE_:Play:258134:
  println("Play - GButton >> GEvent." + event + " @ " + millis());
  play = true;
} //_CODE_:Play:258134:

public void pause_click(GButton source, GEvent event) { //_CODE_:pause:285764:
  println("pause - GButton >> GEvent." + event + " @ " + millis());
  play = false;
} //_CODE_:pause:285764:

public void reset_click(GButton source, GEvent event) { //_CODE_:reset:446879:
  println("reset - GButton >> GEvent." + event + " @ " + millis());
  reset_everything();
} //_CODE_:reset:446879:

public void fpt1_clicked(GOption source, GEvent event) { //_CODE_:fpt1:385218:
  println("tps1 - GOption >> GEvent." + event + " @ " + millis());
  frames_per_tick = 1;
} //_CODE_:fpt1:385218:

public void fpt10_clicked(GOption source, GEvent event) { //_CODE_:fpt10:291093:
  println("tps10 - GOption >> GEvent." + event + " @ " + millis());
  frames_per_tick = 10;
} //_CODE_:fpt10:291093:

public void fpt100_clicked(GOption source, GEvent event) { //_CODE_:fpt100:224268:
  println("tps100 - GOption >> GEvent." + event + " @ " + millis());
  frames_per_tick = 100;
} //_CODE_:fpt100:224268:

public void fpt_1_clicked(GOption source, GEvent event) { //_CODE_:fpt_1:666571:
  println("fpt_1 - GOption >> GEvent." + event + " @ " + millis());
  frames_per_tick = -1;
} //_CODE_:fpt_1:666571:

public void fpt_2_clicked1(GOption source, GEvent event) { //_CODE_:fpt_2:596532:
  println("fpt_2 - GOption >> GEvent." + event + " @ " + millis());
  frames_per_tick = -2;
} //_CODE_:fpt_2:596532:

public void fpt_3_clicked(GOption source, GEvent event) { //_CODE_:fpt_3:507343:
  println("fpt_3 - GOption >> GEvent." + event + " @ " + millis());
  frames_per_tick = -3;
} //_CODE_:fpt_3:507343:

public void A_50_clicked(GOption source, GEvent event) { //_CODE_:A_50:955675:
  println("A_50 - GOption >> GEvent." + event + " @ " + millis());
  lambda_A = 50;
  A.generate_traffic(lambda_A);
} //_CODE_:A_50:955675:

public void A_100_clicked(GOption source, GEvent event) { //_CODE_:A_100:295887:
  println("A_100 - GOption >> GEvent." + event + " @ " + millis());
  lambda_A = 100;
  A.generate_traffic(lambda_A);
} //_CODE_:A_100:295887:

public void A_200_clicked(GOption source, GEvent event) { //_CODE_:A_200:441133:
  println("A_200 - GOption >> GEvent." + event + " @ " + millis());
  lambda_A = 200;
  A.generate_traffic(lambda_A);
} //_CODE_:A_200:441133:

public void A_300_clicked(GOption source, GEvent event) { //_CODE_:A_300:840264:
  println("A_300 - GOption >> GEvent." + event + " @ " + millis());
  lambda_A = 300;
  A.generate_traffic(lambda_A);
} //_CODE_:A_300:840264:

public void C_50_clicked(GOption source, GEvent event) { //_CODE_:C_50:983143:
  println("C_50 - GOption >> GEvent." + event + " @ " + millis());
  lambda_C = 50;
  C.generate_traffic(lambda_C);
} //_CODE_:C_50:983143:

public void C_100_clicked(GOption source, GEvent event) { //_CODE_:C_100:247137:
  println("C_100 - GOption >> GEvent." + event + " @ " + millis());
  lambda_C = 100;
  C.generate_traffic(lambda_C);
} //_CODE_:C_100:247137:

public void C_200_clicked(GOption source, GEvent event) { //_CODE_:C_200:804391:
  println("C_200 - GOption >> GEvent." + event + " @ " + millis());
  lambda_C = 200;
  C.generate_traffic(lambda_C);
} //_CODE_:C_200:804391:

public void C_300_clicked(GOption source, GEvent event) { //_CODE_:C_300:803181:
  println("C_300 - GOption >> GEvent." + event + " @ " + millis());
  lambda_C = 300;
  C.generate_traffic(lambda_C);
} //_CODE_:C_300:803181:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  Exit = new GButton(this, 0, 0, 80, 30);
  Exit.setText("EXIT");
  Exit.setTextBold();
  Exit.addEventHandler(this, "Exit_click");
  Scenario = new GToggleGroup();
  Scenario_A = new GOption(this, 10, 60, 100, 20);
  Scenario_A.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Scenario_A.setText("Concurrent");
  Scenario_A.setTextBold();
  Scenario_A.setOpaque(false);
  Scenario_A.addEventHandler(this, "ScenA_clicked");
  Scenario_B = new GOption(this, 10, 80, 100, 20);
  Scenario_B.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Scenario_B.setText("Hidden");
  Scenario_B.setTextBold();
  Scenario_B.setOpaque(false);
  Scenario_B.addEventHandler(this, "ScenB_clicked");
  Scenario.addControl(Scenario_A);
  Scenario_A.setSelected(true);
  Scenario.addControl(Scenario_B);
  Protocol = new GToggleGroup();
  coll_avoid = new GOption(this, 120, 60, 160, 20);
  coll_avoid.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  coll_avoid.setText("Collision Avoidance");
  coll_avoid.setTextBold();
  coll_avoid.setOpaque(false);
  coll_avoid.addEventHandler(this, "coll_avoid_clicked");
  carrier_sense = new GOption(this, 120, 80, 160, 20);
  carrier_sense.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  carrier_sense.setText("Virtual Carrier Sensing");
  carrier_sense.setTextBold();
  carrier_sense.setOpaque(false);
  carrier_sense.addEventHandler(this, "carrier_sense_clicked");
  Protocol.addControl(coll_avoid);
  coll_avoid.setSelected(true);
  Protocol.addControl(carrier_sense);
  Play = new GButton(this, 160, 0, 80, 30);
  Play.setText("PLAY");
  Play.setTextBold();
  Play.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  Play.addEventHandler(this, "Play_click");
  pause = new GButton(this, 240, 0, 80, 30);
  pause.setText("PAUSE");
  pause.setTextBold();
  pause.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  pause.addEventHandler(this, "pause_click");
  reset = new GButton(this, 320, 0, 80, 30);
  reset.setText("RESET");
  reset.setTextBold();
  reset.setLocalColorScheme(GCScheme.RED_SCHEME);
  reset.addEventHandler(this, "reset_click");
  Playback_Speed = new GToggleGroup();
  fpt1 = new GOption(this, 300, 120, 120, 20);
  fpt1.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  fpt1.setText("1 frame/tick");
  fpt1.setTextBold();
  fpt1.setOpaque(false);
  fpt1.addEventHandler(this, "fpt1_clicked");
  fpt10 = new GOption(this, 300, 140, 120, 20);
  fpt10.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  fpt10.setText("10 frames/tick");
  fpt10.setTextBold();
  fpt10.setOpaque(false);
  fpt10.addEventHandler(this, "fpt10_clicked");
  fpt100 = new GOption(this, 300, 160, 120, 20);
  fpt100.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  fpt100.setText("100 frames/tick");
  fpt100.setTextBold();
  fpt100.setOpaque(false);
  fpt100.addEventHandler(this, "fpt100_clicked");
  fpt_1 = new GOption(this, 300, 100, 120, 20);
  fpt_1.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  fpt_1.setText("1 frame/10 ticks");
  fpt_1.setTextBold();
  fpt_1.setOpaque(false);
  fpt_1.addEventHandler(this, "fpt_1_clicked");
  fpt_2 = new GOption(this, 300, 80, 120, 20);
  fpt_2.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  fpt_2.setText("1 frame/100 ticks");
  fpt_2.setTextBold();
  fpt_2.setOpaque(false);
  fpt_2.addEventHandler(this, "fpt_2_clicked1");
  fpt_3 = new GOption(this, 300, 60, 140, 20);
  fpt_3.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  fpt_3.setText("1 frame/1000 ticks");
  fpt_3.setTextBold();
  fpt_3.setOpaque(false);
  fpt_3.addEventHandler(this, "fpt_3_clicked");
  Playback_Speed.addControl(fpt1);
  Playback_Speed.addControl(fpt10);
  Playback_Speed.addControl(fpt100);
  fpt100.setSelected(true);
  Playback_Speed.addControl(fpt_1);
  Playback_Speed.addControl(fpt_2);
  Playback_Speed.addControl(fpt_3);
  A_speed = new GToggleGroup();
  A_50 = new GOption(this, 470, 60, 70, 20);
  A_50.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  A_50.setText("50 f/s");
  A_50.setTextBold();
  A_50.setOpaque(false);
  A_50.addEventHandler(this, "A_50_clicked");
  A_100 = new GOption(this, 470, 80, 70, 20);
  A_100.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  A_100.setText("100 f/s");
  A_100.setTextBold();
  A_100.setOpaque(false);
  A_100.addEventHandler(this, "A_100_clicked");
  A_200 = new GOption(this, 470, 100, 70, 20);
  A_200.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  A_200.setText("200 f/s");
  A_200.setTextBold();
  A_200.setOpaque(false);
  A_200.addEventHandler(this, "A_200_clicked");
  A_300 = new GOption(this, 470, 120, 70, 20);
  A_300.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  A_300.setText("300 f/s");
  A_300.setTextBold();
  A_300.setOpaque(false);
  A_300.addEventHandler(this, "A_300_clicked");
  A_speed.addControl(A_50);
  A_50.setSelected(true);
  A_speed.addControl(A_100);
  A_speed.addControl(A_200);
  A_speed.addControl(A_300);
  label_topo = new GLabel(this, 20, 40, 80, 20);
  label_topo.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label_topo.setText("Topology");
  label_topo.setTextBold();
  label_topo.setTextItalic();
  label_topo.setOpaque(false);
  proto_label = new GLabel(this, 160, 40, 80, 20);
  proto_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  proto_label.setText("Protocol");
  proto_label.setTextBold();
  proto_label.setTextItalic();
  proto_label.setOpaque(false);
  label1 = new GLabel(this, 310, 40, 120, 20);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("Simulation Speed");
  label1.setTextBold();
  label1.setTextItalic();
  label1.setOpaque(false);
  C_speed = new GToggleGroup();
  C_50 = new GOption(this, 580, 60, 70, 20);
  C_50.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  C_50.setText("50 f/s");
  C_50.setTextBold();
  C_50.setOpaque(false);
  C_50.addEventHandler(this, "C_50_clicked");
  C_100 = new GOption(this, 580, 80, 70, 20);
  C_100.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  C_100.setText("100 f/s");
  C_100.setTextBold();
  C_100.setOpaque(false);
  C_100.addEventHandler(this, "C_100_clicked");
  C_200 = new GOption(this, 580, 100, 70, 20);
  C_200.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  C_200.setText("200 f/s");
  C_200.setTextBold();
  C_200.setOpaque(false);
  C_200.addEventHandler(this, "C_200_clicked");
  C_300 = new GOption(this, 580, 120, 70, 20);
  C_300.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  C_300.setText("300 f/s");
  C_300.setTextBold();
  C_300.setOpaque(false);
  C_300.addEventHandler(this, "C_300_clicked");
  C_speed.addControl(C_50);
  C_50.setSelected(true);
  C_speed.addControl(C_100);
  C_speed.addControl(C_200);
  C_speed.addControl(C_300);
  A_arrive = new GLabel(this, 460, 40, 100, 20);
  A_arrive.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  A_arrive.setText("A (frame/sec)");
  A_arrive.setTextBold();
  A_arrive.setOpaque(false);
  C_label = new GLabel(this, 560, 40, 100, 20);
  C_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  C_label.setText("C (frame/sec)");
  C_label.setTextBold();
  C_label.setOpaque(false);
}

// Variable declarations 
// autogenerated do not edit
GButton Exit; 
GToggleGroup Scenario; 
GOption Scenario_A; 
GOption Scenario_B; 
GToggleGroup Protocol; 
GOption coll_avoid; 
GOption carrier_sense; 
GButton Play; 
GButton pause; 
GButton reset; 
GToggleGroup Playback_Speed; 
GOption fpt1; 
GOption fpt10; 
GOption fpt100; 
GOption fpt_1; 
GOption fpt_2; 
GOption fpt_3; 
GToggleGroup A_speed; 
GOption A_50; 
GOption A_100; 
GOption A_200; 
GOption A_300; 
GLabel label_topo; 
GLabel proto_label; 
GLabel label1; 
GToggleGroup C_speed; 
GOption C_50; 
GOption C_100; 
GOption C_200; 
GOption C_300; 
GLabel A_arrive; 
GLabel C_label; 