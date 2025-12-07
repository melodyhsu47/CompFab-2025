import java.io.*;
import java.util.*;
import processing.pdf.*;

String[] pointlines;
String[] path;

void setup(){
  size(800,500);
  pixelDensity(1);
  background(255);
  stroke(0);
  pointlines = loadStrings("points.csv");
  path = loadStrings("path.csv");
  noLoop();
}

void draw(){
  int i = 0;
  int[] order = new int[path.length];
  
  while (i < path.length){
    order[i] = int(path[i]);
    i++;
  }
  
  i = 0;
  
  
  while (i < pointlines.length-1){ 
    String[] p1 = split(pointlines[order[i]],',');
    String[] p2 = split(pointlines[order[i+1]],',');

    float x1 = map(float(p1[0]),0,300,0,width);
    float y1 = map(270-float(p1[1]),0,270,0,height);
    float x2 = map(float(p2[0]),0,300,0,width);
    float y2 = map(270-float(p2[1]),0,270,0,height);
    line(x1,y1,x2,y2);
    i++;
    //System.out.println(line);
  }
}

void keyPressed(){
  if (key=='s'){
    beginRecord(PDF,"output.pdf");
    setup();
    draw();
    endRecord();
    println("Saved to file");
  }
}




// each line contains x,y,counter\n
