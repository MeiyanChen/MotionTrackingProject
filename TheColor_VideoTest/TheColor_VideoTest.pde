import netP5.*;
import oscP5.*;

import processing.video.*;
Movie myMovie;

String poem = "color";

OscP5 oscP5;

/*
n = NetAddr("127.0.0.1", 57150);

n.sendMsg("/poem", "Hello Mei!");
n.sendMsg("/poem", "My name is Patrick!");
n.sendMsg("/poem", "Bye!");
n.sendMsg("/poem", "");
*/

void setup() {
  size(1440, 1080);
  myMovie = new Movie(this, "TheColor_tImelapse_v2.mov");
  myMovie.play();
  
  oscP5 = new OscP5(this,57150);
}

void draw() {
  image(myMovie, 0, 0, width, height);
  //tint(0,153,204);
  //stroke(random(100,180),random(100,180),random(100,180) ,20);
  //strokeWeight(10);
  fill(#0D98DB,20);
  noStroke();
  if (mousePressed == true) {
   // ellipse(mouseX, mouseY,40, 40);
   // ellipse(mouseX, mouseY, pmouseX, pmouseY);
   text(poem, mouseX, mouseY);
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
}
