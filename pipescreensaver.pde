int basefill = 10;
int dim = 15;

void setup(){
  size(600,600,P3D);
  noLoop();
  background(255);
  noStroke();
  fill(220);
}

void draw(){
  lights();
  //need trackers to make sure i don't run into edges of the screen
  translate(width/2,height/2,0);
  rotateX(PI/3);
  rotateZ(PI/6);
  int segments = 50;
  int[] lengths = new int[segments];
  int[] translations = new int[segments];
  int[] flips = new int[segments];
  for (int i=0; i<lengths.length; i++){
    lengths[i] = int(random(70,130));
    translations[i] = int(random(3));
    flips[i] = random(2) < 1.3 ? -1 : 1;
    
    if (i>0){
      while (translations[i]==translations[i-1]){
        translations[i] = int(random(3));
      }
    }
    
    //below prevents pipes from doubling back on themselves
    //if (i > 0 && translations[i]==translations[i-1] 
    //&& flips[i]==-1*flips[i-1]){
    //  flips[i]*=-1;
    //}
  }
  
  for (int i=0; i<lengths.length-1; i++){
    int curr = lengths[i];
    int next = lengths[i+1];
    int nexttrans = translations[i+1];
    if (translations[i]==0){
      box(curr,dim,dim);
      translate(flips[i]*curr/2,0,0);
    } else if (translations[i]==1){
      box(dim,curr,dim);
      translate(0,flips[i]*curr/2,0);
    } else {
      box(dim,dim,curr);
      translate(0,0,flips[i]*curr/2);
    }
    sphere(1.1*(dim*sqrt(2))/2);
    
    if (nexttrans==0){ 
      translate(flips[i+1]*next/2,0,0);
    } else if (nexttrans==1){
      translate(0,flips[i+1]*next/2,0);
    } else {
      translate(0,0,flips[i+1]*next/2);
    }
  }
}
