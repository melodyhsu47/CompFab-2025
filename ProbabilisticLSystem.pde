// This is an implementation of an L-System that extends the class 
// "BaseLSystem", which makes it easy to make new types of LSystems (e.g., probabalistic)
// without repeating lots of code.
// It assumes all input vocabulary not given a rule are constants. 
// Though you could give an explicit rule for a constant using "F" --> "F"
// It contains a StringBuffer (currentIterationBuffer) that should be used
// to handle production rules when computing the currentIteration string as part of iterate
// in order avoid wasteful creation of strings and memory problems.
// The StringBuffer is used in the iterate method of the LSystem.
// @author: @mriveralee
import java.util.HashMap;

class ProbabilisticLSystem extends BaseLSystem {
  
  // Production rules
  private HashMap<Character, String[]> rules;
  private boolean rand;

  // Constructor for making an Lsystem object
  public ProbabilisticLSystem(String axiom, HashMap<Character, String[]> rules, 
    float moveDistance, float rotateAngle, float scaleFactor, boolean randomLength) {            
    
    // Call Super Class constructor to initialize variables
    // You must always call this.
    super(axiom, moveDistance, rotateAngle, scaleFactor);
    
    // Set the Rules
    this.rules = rules;
    
    this.rand = randomLength;
    
    // Reset the state
    this.reset();
  }
  
  // runs 1 iteration, performing the rules for each character
  // on the current string. The result of the replacement is added to the currentIterationBuffer.
  public void iterate() {
    // get a copy of the current iteration string
    String current = this.getIterationString();
    
    // Now clear the current interation string
    this.clearCurrentStringBuffer();
    
    // [TODO]: Implement the procedure for using the rules to replace characters in the current string, 
    // and append them them to the currentIterationBuffer
    
    for (int i = 0; i < current.length(); i++){
      //String[] frules = {"F","F[+F]F",F[-F]F","\F","/F","Fb"}; //for reference
      char c = current.charAt(i);
      float seed = random(1);
      int r = 0;
      if (seed < 0.25){
        r = 0;
      } else if (seed < 0.4){
        r = 1;
      } else if (seed < 0.65){
        r = 2;
      } else if (seed < 0.75){
        r = 3;
      } else if (seed < 0.85) {
        r = 4;
      } else {
        r = 5;
      }
      switch (c) {
        case '[':
          currentIterationBuffer.append("[");
          break;
        case ']':
          currentIterationBuffer.append("]");
          break;
        case 'F':
          currentIterationBuffer.append(rules.get('F')[r]);
          break;
        case 'f':
          currentIterationBuffer.append(rules.get('f'));
          break;
        case '+':
          currentIterationBuffer.append(rules.get('+')[0]);
          break;
        case '-':
          currentIterationBuffer.append(rules.get('-')[0]);
          break;
        case 'L':
          currentIterationBuffer.append(rules.get('L'));
          break;
        case 'R':
          currentIterationBuffer.append(rules.get('R'));
          break;
        case 'b':
          currentIterationBuffer.append(rules.get('b')[0]);
          break;
        case '|':
          currentIterationBuffer.append(rules.get('|')[0]);
          break;
        case '/':
          currentIterationBuffer.append(rules.get('/')[0]);
          break;
      }
    }

 
    // Increment our iteration after we are done
    iterationNum += 1;
  }
  
  // This function uses the turtle to draw based on each character in the LSystem's 
  // iteration string. It also handles scaling the moveDistance (to keep the image in frame), if desired
  public void drawLSystem(Turtle t) {
    // Our turtle's move distance
    float dist = this.moveDistance;
    float angle = this.rotateAngle;
    
    // Scale the movement, if necessary, to help keep the image in frame 
    // when it gets too big
    if (scaleFactor != 0) {
      // Get the current iteration number for scaling 
      int iterationNum = this.getIterationNum();
      dist = dist / (scaleFactor * (iterationNum + 1));
    }
    
    // Get the current iteration string
    String currentIteration = this.getIterationString(); 
    
    // [TODO]: Loop through each character in the iteration string,
    // and do turtle operations based on the character
    for (int i = 0; i < currentIteration.length(); i++) {
      Character c = currentIteration.charAt(i); 
      // [TODO]: Implement different l-system vocabulary
      if (rand){
        dist = random(5,15);
        angle = random(5,30);
      }
      switch (c) {
        case '[':
          t.push();
          break;
        case ']':
          t.pop();
          break;
        case 'F':
          t.forward(dist);
          break; // The "break" exits out of the switch statement and prevents the next cases from running
        case 'f':
          t.penUp();
          t.forward(dist*iterationNum);
          t.penDown();
          break;
        case 'R':
          t.forward(dist);
          break;
        case 'L':
          t.forward(dist);
          break;
        case '+':
          // [TODO]: Implement operations for each l-system vocabulary
          t.left(angle);
          break;
        case '-':
          t.right(angle);
          break;
        case 'b':
          t.push();
          t.right(40);
          t.forward(20);
          for (int j = 0; j<20; j++){
            t.left(10);
            t.forward(0.8);
          }
          t.right(150);
          for (int j = 0; j<20; j++){
            t.left(10);
            t.forward(0.8);
          }
          t.forward(14);
          t.pop();
          break;
        case '/':
          t.right(angle*0.3);
          break;
        case '|':
          t.left(angle*0.3);
          break;
        default:
          // Throw an error if we don't have a draw operation implemented 
          throw new IllegalArgumentException("Missing a drawing operation case for character: " + c.toString());  
      }
    }
  }
}
