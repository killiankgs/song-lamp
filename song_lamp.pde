import processing.svg.*;



boolean record;

import processing.sound.*;
SoundFile file;
Amplitude amp;
ArrayList<Float> volhistory = new ArrayList<Float>();


void setup() {
  size(360, 360);
    
  
  file = new SoundFile(this, "aifol.mp3");
  file.play();
  amp = new Amplitude(this);
  amp.input(file);
}      

void draw() {
  if(record){
    beginRecord(SVG, "frame-####.svg");
  }
  
  background(255);
  float vol = (amp.analyze());
  volhistory.add(vol);
  
  stroke(0);
  noFill();
  translate(width/2, height/2);
  beginShape();
  for (int i = 0; i < volhistory.size(); i++) {
    float angle = map(i, 0, volhistory.size(), 0, TWO_PI);  // Map i to angle from 0 to 2*PI
    int r = (int) map(volhistory.get(i), 0, 1, 10, 100);
    float x = r * cos(angle);
    float y = r * sin(angle);
    vertex(x, y);
  }
  endShape();

  if(volhistory.size() > 360){
    volhistory.remove(0);
  }
  
  if (record) {
    endRecord();
  record = false;
  }

}

void mousePressed() {
  record = true;
  
}
