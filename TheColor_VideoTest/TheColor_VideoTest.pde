  
import processing.video.*;
Movie myMovie;

void setup() {
  size(1440, 1080);
  myMovie = new Movie(this, "TheColor_tImelapse_v2.mov");
  myMovie.play();
}

void draw() {
  image(myMovie, 0, 0, width, height);
  //tint(0,153,204);
  //stroke(random(100,180),random(100,180),random(100,180) ,20);
  //strokeWeight(10);
  fill(#0D98DB,20);
  noStroke();
  if (mousePressed == true) {
    ellipse(mouseX, mouseY,40, 40);
   // ellipse(mouseX, mouseY, pmouseX, pmouseY);
  }
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  m.speed(0.05);
}
