// ExampleLSystemDesigns - contains helper methods to create and 
// initialize an LSystem
// to set up parameters and init the LSystem (from the main file)

import java.util.*;

// [TODO]: create your own L-System initialization methods
// and use/test in the setup() method of L1LSystemAssignment file. 
// See example for Square Lsystem below.

// Square Lsystem initialization 
// This method returns an Lsystem object that uses
// The rules and axioms for a square based system
LSystem initSquare() {
  // initialize turtle variables
  float moveDist = 10;
  float rotateAngle = 90;
  float scaleFactor = 1;
  
  // The intial axiom / input string
  String axiom = "F+F+F+F";
  
  // Create any production rules
  HashMap<Character, String> rules = new HashMap<>();
  rules.put('F', "F+F-F-FF+F+F-F");
  rules.put('+',"+");
  rules.put('-',"-");
    
  // Create and return the Lsystem
  return new LSystem(axiom, rules, moveDist, rotateAngle, scaleFactor);
}

LSystem initGarden(){
  float moveDist = 10;
  float rotateAngle = 45;
  float scaleFactor = 1;
  
  String axiom = "-L";
  
  HashMap<Character, String> rules = new HashMap<>();
  rules.put('F',"F");
  rules.put('L',"++R-F-LFL-F-R++");
  rules.put('R',"--L+F+RFR+F+L--");
  rules.put('+',"+");
  rules.put('-',"-");
  
  return new LSystem(axiom, rules, moveDist, rotateAngle, scaleFactor);
}

LSystem initTile(){
  float moveDist = 60;
  float rotateAngle = 30;
  float scaleFactor = 1;
  
  String axiom = "F++F++F++F++F++F";
  
  HashMap<Character, String> rules = new HashMap<>();
  rules.put('F',"fF++F++F++F++F++Ff++");
  rules.put('f',"f");
  rules.put('+',"+");
  rules.put('-',"-");
  rules.put('[',"[");
  rules.put(']',"]");
  return new LSystem(axiom, rules, moveDist, rotateAngle, scaleFactor);
}

LSystem tile2(){
  float moveDist = 30;
  float rotateAngle = 90;
  float scaleFactor = 2;
  
  String axiom = "L";
  HashMap<Character, String> rules = new HashMap<>();
  
  rules.put('L',"+RFRFRF-LFLFLF-LFLF-LF-RF+RF+LFLF+RFRFR");
  rules.put('R',"-LFLFLF+RFRFRF+RFRF+RF+LF-LF-RFRF-LFLFL");
  
  rules.put('+',"+");
  rules.put('-',"-");
  rules.put('F',"F");
  
  return new LSystem(axiom, rules, moveDist, rotateAngle, scaleFactor);
}

ProbabilisticLSystem plant(boolean randomLength){
  float moveDist = 40;
  float rotateAngle = 30;
  float scaleFactor = 0.8;
  
  String axiom = "F";
  
  HashMap<Character, String[]> rules = new HashMap<>();
  String[] frules = {"FF","F[+F]F","F[-F]F","F|F","F/F","Fb"};
  String[] plus = {"+"};
  String[] minus = {"-"};
  String[] pop = {"["};
  String[] push = {"]"};
  String[] berry = {"b"};
  String[] slightleft = {"|"};
  String[] slightright = {"/"};
  rules.put('F',frules);
  rules.put('+',plus);
  rules.put('-',minus);
  rules.put('[',pop);
  rules.put(']',push);
  rules.put('b',berry);
  rules.put('|',slightleft);
  rules.put('/',slightright);
  return new ProbabilisticLSystem(axiom, rules, moveDist, rotateAngle, 
  scaleFactor, randomLength);
}
