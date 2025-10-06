import Turtle.*;

Turtle t;

void setup(){
  size(700,700);
  background(255);
  stroke(0);
  t = new Turtle(this);
  //frameRate(1);
  noLoop();
}

void draw(){
  reset(t,width*0.25,height/2);
  drawletter(t,1);
  
  reset(t,width*0.4,height/2);
  drawletter(t,2);
  
  reset(t,width*0.5,height/2);
  drawShape(t,3,20);
  
  reset(t,width*0.6,height/2);
  drawShape(t,5,30);
  
  reset(t,width*0.8,height/2); //approximation of circle
  drawShape(t,100,4);
}

void drawletter(Turtle t,int shape){
  t.push();
  t.right(180);
  t.forward(30);
  t.pop();
  t.penUp();
  t.left(90);
  t.forward(10);
  t.right(180);
  t.push();
  t.penDown();
  t.forward(20);
  t.pop();
  if (shape == 1){
    t.penUp();
    t.right(90);
    t.forward(30);
    t.left(90);
    t.penDown();
    t.forward(20);
  }
}

void drawShape(Turtle t, int sides, float sidelength){
  t.left(90);
  for (int i = 0; i<sides; i++){
    t.forward(sidelength);
    float angle = 180-(((float(sides)-2)/sides)*180); //weird float division
    t.left(angle);
  }
}

void reset(Turtle t, float nextx, float nexty){
  t.penUp();
  t.goToPoint(nextx,nexty);
  t.setHeading(0);
  t.penDown();
}
