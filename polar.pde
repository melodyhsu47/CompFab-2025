import processing.pdf.*;

void setup(){
  size(800,800);
  pixelDensity(1);
  noLoop();
  background(255);
}

void draw(){
  int dim = 10000;
  int num = 5;
  int dist = 130; //distance from center
  int radius = 25;
  for (int i = 0; i < num; i++){
    float xcenter = dist*cos((2*PI/num)*i) + width/2;
    float ycenter = dist*sin((2*PI/num)*i) + height/2;
    drawFlower(dim,xcenter,ycenter,radius);
  }
  drawSplat(dim,width/2,height/2,130);
  drawSplat(dim,width/2,height/2,120);
  drawSplat(dim,width/2,height/2,110);
  //polygon(width/2,height/2,70,num);
  star(width/2,height/2,5,65,5);
  //circle(width/2,height/2,20); //draw middle cutout
  
}

float[] generateXFlower(int incr, float xc, int size){
  float[] points = new float[incr];
  float base = 0.0;
  for (int i = 0; i<incr; i++){
    float theta = radians(base);
    points[i] = (1.5+pow(cos((19*theta/2)),3))*size*cos(theta) + xc;
    base += 0.5;
  }
  return points;
}

float[] generateYFlower(int incr, float yc, int size){
  float[] points = new float[incr];
  float base = 0.0;
  for (int i = 0; i<incr; i++){
    float theta = radians(base);
    points[i] = (1.5+pow(cos((19*theta/2)),3))*size*sin(theta) + yc;
    base += 0.5;
  }
  return points;
}

void drawFlower(int dim, float xcenter, float ycenter, int radius){
  float[] x = generateXFlower(dim, xcenter, radius);
  float[] y = generateYFlower(dim, ycenter, radius);
  for (int i = 0; i<x.length-1; i++){
    line(x[i],y[i],x[i+1],y[i+1]);
  }
}  

float[] generateXSplat(int incr, float xcenter, int radius){
  float[] points = new float[incr];
  float base = 0.0;
  for (int i = 0; i < incr; i++){
    float theta = radians(base);
    points[i] = (2+pow(cos((19*theta)/2),2))*radius*cos(theta) + xcenter;
    base += 0.5;
  }
  return points;
}

float[] generateYSplat(int incr, float ycenter, int radius){
  float[] points = new float[incr];
  float base = 0.0;
  for (int i = 0; i < incr; i++){
    float theta = radians(base);
    points[i] = (2+pow(cos((19*theta)/2),2))*radius*sin(theta) + ycenter;
    base += 0.5;
  }
  return points;
}

void drawSplat(int dim, float xcenter, float ycenter, int radius){
  float[] x = generateXSplat(dim, xcenter, radius);
  float[] y = generateYSplat(dim, ycenter, radius);
  for (int i = 0; i<x.length-1; i++){
    line(x[i],y[i],x[i+1],y[i+1]);
  }
}


void keyPressed(){
  if (key == 's'){
    beginRecord(PDF,"output/polar.pdf");
    setup();
    draw();
    endRecord();
    println("saved to file");
    exit();
  }
}

// polygon, star functions taken from processing documentation
void polygon(float x, float y, float radius, int npoints){
  float angle = TWO_PI/npoints;
  noFill();
  beginShape();
  for (float a = angle/2; a < TWO_PI+angle/2; a += angle){
    float sx = x + cos(a)*radius;
    float sy = y + sin(a)*radius;
    vertex(sx,sy);
  }
  endShape(CLOSE);
}

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}


  
  
  
  
  
  
  
  
  
  
  
  
  
