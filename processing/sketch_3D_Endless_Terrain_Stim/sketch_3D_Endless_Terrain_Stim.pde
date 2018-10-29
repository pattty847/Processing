import peasy.*;
import ddf.minim.*;


int cols, rows;
int scl = 20;
int w = 2000;
int h = 1600;
float flying = 0;
float[][] terrain;

PeasyCam camera;

Minim minim;
AudioPlayer song;

void setup() {
  size(1200, 800, P3D);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
  camera = new PeasyCam(this, 500);
}

void draw() {

  flying -= 0.005;

  float yoff = flying;
  for (int y = 0; y < rows; y++) 
  {
    float xoff = 0;
    for (int x = 0; x < cols; x++) 
    {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, 0, 600);
      xoff += 0.03;
    }
    yoff += 0.03;
  }
  
  background(0);
  stroke(255);
  noFill();
  translate(width/2, height/2+50);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  sphere(200);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      fill(color(66, 128, 244));
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
  print(frameRate+"\n");
}
