import netP5.*;
import oscP5.*;

import processing.video.*;
Movie myMovie;

String poem = "color";

OscP5 oscP5;

boolean isDrawing = false;
float posX = 0.5;
float posY = 0.5;

PFont f;

// https://processing.org/reference/createGraphics_.html

/*
n = NetAddr("127.0.0.1", 57150);

n.sendMsg("/poem", "Hello Mei!");
n.sendMsg("/poem", "My name is Patrick!");
n.sendMsg("/poem", "Bye!");
n.sendMsg("/poem", "");

n.sendMsg("/poemPos", 0, 0.3, 0.7); // no writing
n.sendMsg("/poemPos", 1, 0.5, 0.2); // writing at  position 0.5/0.2

*/

void setup() {
  size(1440, 1080);
  myMovie = new Movie(this, "TheColor_tImelapse_v2.mov");
  myMovie.play();
  
  oscP5 = new OscP5(this,57150);
  f = createFont("BrushScriptMT", 50);
}

void draw() {
  image(myMovie, 0, 0, width, height);
  //tint(0,153,204);
  //stroke(random(100,180),random(100,180),random(100,180) ,20);
  //strokeWeight(10);
  
  fill(random(100,180),random(80,150),random(1,150));
  
  noStroke();
  
  if (isDrawing == true) {
   textFont(f);
   text(poem, posX * width, posY * height);
  }
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  m.speed(0.05);
}

void oscEvent(OscMessage theOscMessage) {
  /*
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  */
  
  if(theOscMessage.addrPattern().equals("/poem")) {
    poem = theOscMessage.get(0).stringValue();
  }
  
  if(theOscMessage.addrPattern().equals("/poemPos")) {
    isDrawing = theOscMessage.get(0).intValue() != 0;
    posX = theOscMessage.get(1).floatValue();
    posY = theOscMessage.get(2).floatValue();
  }
}
