import wblut.core.*;
import wblut.geom.*;
import wblut.hemesh.*;
import wblut.math.*;
import wblut.nurbs.*;
import wblut.processing.*;
import controlP5.*;
import java.util.*;

//set global variables

ControlP5 cp5;
ScrollableList shapeList;

WB_Render3D render;
Form form;
HEC_Creator creator;

boolean play;
boolean playOnce;
Rule [] ruleset;
List<String> shapes = new ArrayList<String>();
List<String> modifiers = new ArrayList<String>();

float zoom = 1;
color c;

void setup() {
  //Initialize 
  background(255);
  size(1400, 787, P3D); //3d canvas
  smooth();
  c = #CE3030; //starting color
  render = new WB_Render(this);
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  creator = new HEC_Geodesic().setRadius(200); //starting shape
  
  ruleset = new Rule[2];
  ruleset[0] = new Rule("");    // user defined ruleset for shape
  ruleset[1] = new Rule("HS");  //simplify shape if too large
  form = new Form(creator, ruleset);
  play = false;
  cp5.draw();
  makeCreatorsModifiers();
  controlp5Setup();
  form.clearRules();
}

void draw() {
  background(255);
  if (play) form.run();
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(255, 255, 255, -1, -1, 1);
  directionalLight(100, 100, 100, -1, -1, -1);
  
  //localize viewing reference for transformations
  pushMatrix();
  translate(width/2, height/2);
  rotateY(map(mouseX, 0, width, -PI-1, PI+1)); //mouseX controls left and right rotation
  rotateX(map(mouseY, 0, height, -PI-1, PI+1));//mouseY controls up and down rotation
  scale(zoom);
  form.display();
  popMatrix();
  
  form.displayRules();
  delay(10);
  //saveFrame("Screenshots/Form_######.png"); // Uncomment to record each frame of interaction
  cp5.draw();
  
}

void mouseWheel(MouseEvent event) {
  //use mousewheel to scroll  
  float e = event.getCount();
  zoom = zoom + -e*.04;
  if (zoom <= 0.02) {
    zoom = 0.02;
  }
}

void keyPressed() {
  if (key == ' ') { //press spacebar to toggle iterate over rules
    if (play) {
      cp5.getController("play").setValue(0);
    } else {
      cp5.getController("play").setValue(1);
    }
  } else {
    form.run();
  }
}

void mousePressed() {
  //right click to quickly save screenshot
  if (mouseButton == RIGHT) {    
    saveFrame("Screenshots/Form_######.png");
  }
}

void makeCreatorsModifiers() {
  //list of shapes
  shapes.add("Cylinder");
  shapes.add("Cube");
  shapes.add("Geodesic");
  shapes.add("Archimedes");
  shapes.add("Cone");
  shapes.add("Grid");
  shapes.add("Johnson");
  shapes.add("Octahedron");
  shapes.add("Torus");
  shapes.add("Beethoven");
  
  //list of modifiers
  modifiers.add("Scale");
  modifiers.add("Clean");
  modifiers.add("Extrude");
  modifiers.add("Convex Hull");
  modifiers.add("Inset Extrude");
  modifiers.add("Slice");
  modifiers.add("Smooth");
  modifiers.add("Expand");
  modifiers.add("Crocodile");
  modifiers.add("Simplify");
  modifiers.add("Twist X");
  modifiers.add("Twist Y");
  modifiers.add("Twist Z");
  modifiers.add("Skew");
}

color colorFromVal(float v) {
  //use single float to create RGB color
  v*=10;
  int r = int(map(noise(.5*v), 0, 1, 50, 305));
  int g = int(map(noise(.3*v), 0, 1, 50, 305));
  int b = int(map(noise(.2*v), 0, 1, 50, 305));
  color col = color(r, g, b);
  //println(value +" " +r +" " +g+" "+b); 
  return col;
}