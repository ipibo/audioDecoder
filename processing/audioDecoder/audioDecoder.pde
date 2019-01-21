import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

color backgroundColor = color(0, 0, 0);
int screenWidth = 200;
int screenHeight = 200;
color[] pixx = new color[screenWidth*screenHeight];

float r, g, b, posX, posY = 0;

int size = 5;

void setup() {
  size(1000,1000);
  background(0);
  frameRate(20);
  oscP5 = new OscP5(this, 6969);
  myRemoteLocation = new NetAddress("192.168.8.102", 6969);
  noCursor();

}

void changeColor() {
  backgroundColor = color(r, g, b);

 /* 
  if(posX == 0 && posY == 0){
    clearTheScreen(); 
  }
 */ 

  int loc = int(screenWidth * posX + posY);
  pixx[loc] = backgroundColor;

}

void draw() {
  background(0); 

  for (int i = 0; i < pixx.length; i++) {
    if (pixx[i] != 0) {
      int x = i/200;
      int y = i%screenWidth;
      stroke(pixx[i]);
      noStroke();
      fill(pixx[i]);
      rect(x*size, y*size, size, size);
    }
  }
}


void keyPressed(){

  if(key == 'r'){
    clearTheScreen();
  }  

}

void clearTheScreen(){
  for(int i = 0 ; i < pixx.length; i++){
    pixx[i] = color(0);
    int x = i/200;
    int y = i%200;
    stroke(0);
    fill(0);
    rect(x*size, y*size, size, size);
  }
}

// --------------------------------------------------- The OSC Event Stuff ----------------------------------------------------------------------

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/r") == true) {
    r = theOscMessage.get(0).floatValue();
  }

  if (theOscMessage.checkAddrPattern("/g") == true) {
    g = theOscMessage.get(0).floatValue();
  }

  if (theOscMessage.checkAddrPattern("/b") == true) {
    b = theOscMessage.get(0).floatValue();
  }

  if (theOscMessage.checkAddrPattern("/posY") == true) {
    posY= theOscMessage.get(0).floatValue();
  }

  if (theOscMessage.checkAddrPattern("/posX") == true) {
    posX = theOscMessage.get(0).floatValue();
    changeColor();
  }
 }
