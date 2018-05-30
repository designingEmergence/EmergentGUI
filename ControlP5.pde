void controlp5Setup() { // Add control buttons at bottom
  
  cp5.addToggle("play")
    .setPosition(250, 750)
    .setSize(90, 25)
    .setId(0);
    
//TODO Move label to center of button
    
  cp5.addButton("Play Once")
    .setPosition(350, 750)
    .setSize(90, 25)
    .setId(4);

  cp5.addButton("reset")
    .setPosition(450, 750)
    .setSize(90, 25)
    .setValue(0)
    .setId(1);
  
  cp5.addButton("clear rules")
    .setPosition(550,750)
    .setSize(90,25)
    .setId(2);
    
  cp5.addButton("export")
    .setPosition(650,750)
    .setSize(90,25)
    .setId(3);
  
  cp5.addButton("Save Frame")
    .setPosition(750,750)
    .setSize(90,25)
    .setId(5);
    
  cp5.addSlider("changeColor", 0,260,25,850,750,190,25)
    .setId(6);
    
  
  //Add dropdown list of shapes
  shapeList = cp5.addScrollableList("shapes")
    .setPosition(1150,  50)
    .setSize(200, 500)
    .setBarHeight(20)
    .setItemHeight(20)
    .setId(2)
    .addItems(shapes);

  //Add list of modifiers
  for (String mod: modifiers){
    int i = modifiers.indexOf(mod);
    cp5.addButton(mod)
     .setPosition(1150,300+(i*30))
     .setSize(200,25)
     .setId(100 +i);
  }
}

void controlEvent(ControlEvent theEvent) { //Logic controller for modifier buttons  
  switch(theEvent.getId()) {
    case(2): form.clearRules();break;
    case(3): HET_Export.saveToOBJ(form.mesh, sketchPath(),"Form/form.obj"); break;
    case(4): play = true; playOnce = true; break;
    //case(5): saveFrame("Screenshots/Form_######.png");break;
    //case(6): c = colorFromVal(theEvent.getController.getValue());
    
    
    case(100):form.addModifier('A'); break;
    case(101):form.addModifier('C'); break;
    case(102):form.addModifier('E'); break;
    case(103):form.addModifier('H'); break;
    case(104):form.addModifier('I'); break;
    case(105):form.addModifier('L'); break;
    case(106):form.addModifier('M'); break;
    case(107):form.addModifier('P'); break;
    case(108):form.addModifier('R'); break;
    case(109):form.addModifier('S'); break;
    case(110):form.addModifier('X'); break;
    case(111):form.addModifier('Y'); break;
    case(112):form.addModifier('Z'); break;
    case(113):form.addModifier('K'); break;
    case(114):form.addModifier('F'); break;
    case(115):form.addModifier('B'); break;
  }
}

//Functions for buttons

public void changeColor(float theValue){
  c = colorFromVal(theValue);
}

public void reset() {
  Form a = new Form(creator, ruleset); 
  form = a;
  cp5.getController("play").setValue(0);
  //creator = makeCreator();  
}

public void shapes(int n) {
  println("Shape " + n);
  if (n ==0) { 
    creator = new HEC_Cylinder().setRadius(100, 100).setHeight(300).setFacets(15).setSteps(15).setCap(true, true).setZAxis(0, 1, 0);
  }
  else if (n ==1) { 
    creator = new HEC_Box().setWidth(150).setHeight(150).setDepth(150).setWidthSegments(2).setHeightSegments(2).setDepthSegments(2);
  }
  else if (n == 2) {
    creator = new HEC_Geodesic().setRadius(200);
  }
  else if (n == 3){
    creator = new HEC_Archimedes().setEdge(100).setType(8);
  }
  else if (n == 4){
    creator = new HEC_Cone().setRadius(200).setHeight(350).setFacets(25).setSteps(5).setReverse(true).setCap(true).setZAxis(0,0,1);
  }
  else if(n == 5){
    creator = new HEC_Grid().setU(10).setV(10).setUSize(200).setVSize(200);
  }
  else if(n == 6){
    int j = int(random(1,92.5));
    creator = new HEC_Johnson().setEdge(100).setType(j);
  }
  else if( n ==7){
    creator = new HEC_Octahedron().setEdge(250);
  }
  else if(n == 8){
    creator = new HEC_Torus().setRadius(50,200).setTubeFacets(10).setTorusFacets(50).setTwist(2);
  }
  else if(n == 9){
    creator = new HEC_Beethoven().setScale(5);
  }
    
  reset();
}