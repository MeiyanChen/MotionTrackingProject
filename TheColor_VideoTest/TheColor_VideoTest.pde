import netP5.*;
import oscP5.*;

import processing.video.*;
Movie myMovie;

String poem = "color";

OscP5 oscP5;

boolean isDrawing = false;
float posX = 0.5;
float posY = 0.5;
PGraphics pg;
PGraphics pg2;
PFont f;

float lastPositionActivity = 0;

//float transparency = 255;
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
  size(1440, 720, P3D);
   //myMovie = new Movie(this, "TheColor_tImelapse_v2.mov");
  myMovie = new Movie(this, "TheColor_VideoV1.mov");
 
  myMovie.play();
  myMovie.speed(2);

  pg = createGraphics(width, height, P3D);
  pg2 = createGraphics(width, height, P3D);
  
  oscP5 = new OscP5(this,57150);
  f = createFont("BrushScriptMT", 30);

}

void draw() {
  
  println(frameRate);
    //tint(0,153,204);
  //stroke(random(100,180),random(100,180),random(100,180) ,20);
  //strokeWeight(10);
  
    /*
  if (isDrawing == true) {
   textFont(f);
   text(poem, posX * width, posY * height);
  }
  */
  
  
  pg2 = createGraphics(width, height);
  pg2.beginDraw();
  pg2.tint(255,240);
  pg2.image(pg, 0, 0);
  pg2.endDraw();
  
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(255,20);
  pg.image(pg2, 0, 0);
  pg.fill(random(150,180),random(150,180),random(30));
  //pg.noStroke();
  
  /*
  if (mousePressed == true) {
    pg.textFont(f);
    pg.text(poem, mouseX, mouseY);
  }
  */
  
  if(lastPositionActivity > millis() - 200) {
    pg.textFont(f);
    pg.text(poem, posX * width, (1.0 - posY) * height);
  }
  
  pg.endDraw();
  
  image(myMovie, 0, 0, width, height);
  image(pg, 0, 0);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
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
    lastPositionActivity = millis();
    isDrawing = theOscMessage.get(0).intValue() != 0;
    posX = theOscMessage.get(1).floatValue();
    posY = theOscMessage.get(2).floatValue();
  }
  
  
  if(theOscMessage.addrPattern().equals("/poemPosTouch")) {
    lastPositionActivity = millis();
    posX = theOscMessage.get(0).floatValue();
    posY = theOscMessage.get(1).floatValue();
  }
}
