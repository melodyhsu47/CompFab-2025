//Sierpinski carpet - cutouts
import processing.pdf.*;
String folder = "output";
String fileName = folder + "/" + "sierpinski.pdf";

void setup(){

  size(810,810);
  pixelDensity(1);
  noLoop();
  background(0);
  noStroke();
  fill(255);
}

void draw(){
  sier(5);
}

void sier(int level){
  float x_0 = width/3;
  float y_0 = height/3;
  float dim = width/3;
  for (int i = 0; i < level; i++){
    float x_new = x_0;
    for (int j = 0; j < pow(3,i); j++){
      float y_new = y_0;
      square(x_new,y_0,dim);
      for (int k = 0; k < pow(3,i); k++){
        square(x_new,y_new,dim);
        y_new += 3*dim;
      }
      x_new += 3*dim;
    }
    x_0 /= 3;
    y_0 /= 3;
    dim /= 3;
  }
}

void keyPressed(){
  if (key=='s'){
    beginRecord(PDF,fileName);
    setup();
    draw();
    endRecord();
    println("Saved to file");
  }
}
