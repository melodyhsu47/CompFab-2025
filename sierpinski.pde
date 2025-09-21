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


// curveboolean

/*
- units = mm
- distance, basepoint = start measurement
- on easier one: printcolor (see guide)
- on harder laser cutter:
  - printwidth hairline engraves; select everything to engrave (0.25-0.3)
  - properties - check settings on printer doc
  - make sure it's 40x28 size in properties
  - click print to send print
- scale command, select object, select base point
- type 25 millimeters
- ctrl p to open up print
- uncheck everything under visibility
- set window, do NOT touch corners of box, click center to move box
- turn on cutter
- settings -> material (hardwood -> plywood)
- measure thickness of material, hit apply, OK
- relocate view (4 arrows button), button to the left is to position laser
- turn on fan, green button
- turn off fan after cut is done
*/ 
