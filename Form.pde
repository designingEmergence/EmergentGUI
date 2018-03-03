class Form{
  
  HE_Mesh mesh;
  PShape shape;
  int numFaces;
  HEC_Creator creator;
  Rule [] ruleset;
  String todo;
  String command;
  WB_Point [] meshPoints;
  String text;
  
  int limit = 5000;
  
  int s = 0;
  int curState = 0;
  int prevState = 0;
  
  
  Form(HEC_Creator c, Rule[] r){
    creator = c;
    ruleset = r;
    mesh = creator.create();
    command = "Shape: Geodesic";
    text = "none";
    todo = ruleset[0].getB();
  }
  
  void display(){
    noStroke();
    fill(c);
    render.drawFaces(mesh);
  }
  
  void displayRules(){
    //println(todo.length());
    calculate();
    for (int i=1; i<todo.length(); i++){
      char c = todo.charAt(i);
      if ( c == 'A'){text = "Scale";}
      else if (c == 'C'){text = "Clean";}
      else if (c == 'R'){text = "Crocodile";}
      else if (c == 'E'){text = "Extrude";}
      else if (c == 'I'){text = "Inset Extrude";}
      else if (c == 'P'){text = "Expand";}
      else if (c == 'X'){text = "Twist X";}
      else if (c == 'Y'){text = "Twist Y";}
      else if (c == 'Z'){text = "Twist Z";}
      else if (c == 'M'){text = "Smooth";}
      else if (c == 'S'){text = "Simplify";}
      else if (c == 'L'){text = "Slice";}
      else if (c == 'H'){text = "Convex Hull";} 
      else if (c == 'K'){text = "Skew";}
      else if (c == 'B'){text = "Bend";}
      if(i == s){fill(#B70F0F);}
      else {fill(#767575);}
      textSize(12);
      text(text,50,100+(i*15));
    }
  }
  
  void clearRules(){
    ruleset[0].b = "";
  }
  
  void addModifier(char c){
    ruleset[0].b += c;
    modify(c);
    calculate();
    s = todo.length()-1;
  }   
  
  void calculate(){    
      numFaces = mesh.getNumberOfFaces();
      prevState = curState;
      if(numFaces>limit){
        todo = ruleset[1].getB();
        curState = 1;
      }else{
        todo = ruleset[0].getB();
        curState = 0;
      }      
      if(curState - prevState != 0){
        s =0;
        if(playOnce && curState == 0){
          play = false;
          playOnce = false;
        }
      }
      println(s + ", "+ todo.length()); 
  }
  
  void run(){
    if(todo.length()>0){
      char c = todo.charAt(s);
      modify(c);
      delay(100);
      s += 1;    
      if(s >= todo.length()){
        s = 0;
        if(playOnce){
          play = false;
          playOnce = false;
        }
      }
    }
  }
      
  
  void modify(char c){
    
    if (c == 'A'){
      println("scale");
      command = "Modifier: Scale";
      mesh.scale(1.3);
    }
      
    else if (c == 'C'){
      println("clean");
      command = "Modifier: Clean";
      HEM_Clean clean = new HEM_Clean();
      mesh.modify(clean);
    }
    else if(c =='R'){
      println("crocodile");
      command = "Modifier: Crocodile";
      HEM_Crocodile croc = new HEM_Crocodile().setDistance(30).setChamfer(0.25);
      mesh.modify(croc);
    }
     else if(c == 'E'){
      println("Extrude");
      command = "Modifier: Extrude";
      HEM_Extrude extrude = new HEM_Extrude().setDistance(50).setRelative(true);
      mesh.modify(extrude);      
    }   
    else if(c == 'I'){
      println("Inset Extrude");
      command = "Modifier: Inset Extrude";
      HEM_Extrude extrude = new HEM_Extrude().setChamfer(10).setDistance(10).setRelative(false);
      mesh.modify(extrude);
      HE_Selection sel = extrude.extruded;
      extrude = new HEM_Extrude().setDistance(-40);
      mesh.modifySelected(extrude, sel);      
    }
    else if(c == 'I'){
      println("extrude");
      command = "Modifier: Extrude";
      HEM_Extrude extrude = new HEM_Extrude().setChamfer(10).setDistance(10).setRelative(false);
      mesh.modify(extrude);
      HE_Selection sel = extrude.extruded;
      extrude = new HEM_Extrude().setDistance(-40);
      mesh.modifySelected(extrude, sel);
      
    }
    else if(c == 'P'){
      command = "Modifier: Expand";
      println("expand");
      HEM_VertexExpand ve = new HEM_VertexExpand().setDistance(60);
      mesh.modify(ve);
    }
    else if(c == 'X'){
      println("twistX");
      command = "Modifier: Twist X";
      WB_Point p1 = new WB_Point(.1, 0, 0);
      WB_Point p2 = new WB_Point(-.1, 0, 0);
      WB_Line l = new WB_Line(p1, p2);
      HEM_Twist twistX = new HEM_Twist().setTwistAxis(l).setAngleFactor(.5);
      mesh.modify(twistX);
    }
    else if(c == 'Y'){
      println("twistY");
      command = "Modifier: Twist Y";
      WB_Point p1 = new WB_Point(0, .1, 0);
      WB_Point p2 = new WB_Point(0, -.1, 0);
      WB_Line l = new WB_Line(p1, p2);
      HEM_Twist twistY = new HEM_Twist().setTwistAxis(l).setAngleFactor(.5);
      mesh.modify(twistY);
    }
    else if(c == 'Z'){
      println("twistZ");
      command = "Modifier: Twist Z";
      WB_Point p1 = new WB_Point(0, 0, .1);
      WB_Point p2 = new WB_Point(0,0, -.1);
      WB_Line l = new WB_Line(p1, p2);
      HEM_Twist twistZ = new HEM_Twist().setTwistAxis(l).setAngleFactor(.5);
      mesh.modify(twistZ);
    }
    else if(c =='M'){
      println("smooth");
      command = "Modifier: Smooth";
      HEM_Smooth sm = new HEM_Smooth();
      for (int i =0; i<10; i++){
        mesh.modify(sm);
      }
    }
    else if(c == 'S'){
      println("simplify");
      command = "Modifier: Simplify";
      mesh.simplify(new HES_TriDec().setGoal(limit/4));
    }
    else if(c == 'L'){
      println("slice");
      command = "Modifier: Slice";
      HEM_Slice slice = new HEM_Slice();
      slice.setPlane(0,0,0,0,1,0);
      slice.setOffset(0);
      slice.setCap(true);
      slice.setKeepCenter(false);
      slice.setReverse(false);
      mesh.modify(slice);
      mesh.triangulate();
    }

    else if(c == 'H'){
      println("ConvexHull");
      command = "Simplify: Convex Hull";
      meshPoints = mesh.getVerticesAsNewPoint();
      HEC_ConvexHull cHull = new HEC_ConvexHull();
      cHull.setPoints(meshPoints);
      cHull.setN(5);
      mesh = new HE_Mesh(cHull);
      println(numFaces);
    }          
   else if(c=='K'){
     println("Skew");
     command = "Modifier: Skew";
     WB_Plane P = new WB_Plane(0,0,0,0,0,1);
     WB_Vector V = new WB_Vector(1,1,0);
     HEM_Skew skew = new HEM_Skew().setGroundPlane(P).setSkewDirection(V).setSkewFactor(1).setPosOnly(false);
     mesh.modify(skew);
   }
  }    
}