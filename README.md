Emergent GUI - http://www.designingemergence.com/portfolio/emergent-gui/

Emergence is the process by which simple rules can lead to complex forms. We see emergence in action everyday, from weather patterns to butterfly wings. I wanted to replicate this process by creating a tool that creates 3 Dimensional forms based on iterating over a list of simple rules.

Requirements:

  - Processing
  - Libraries for Processing:
    ControlP5 http://www.sojamo.de/libraries/controlP5/
    HE_Mesh https://github.com/wblut/HE_Mesh
  - 3d viewer to view saves .obj files (optional)
  
Files: 

  - Form: Folder containing exported .Obj files
  - Screenshots: Folder containing exported screenshots
  - EmergentHeMeshController.pde: Main project file
  - ControlP5.pde: File containing GUI for application
  - Form.pde: Class of 3d forms
  - Rule.pde: Class of rules used by form
  - RulesDiscovered.pde: Interesting rules discovered
  - variables.txt: Defining which letters correspond with which rules.
  
Method:

  - Open the EmergentHemeshController.pde file in processing
  - You will see a sphere with a set of modifiers on the right
  - Click on a modifier to alter the form of the object
  - As you click, the list of modifiers used appears on the left
  - Press space bar to iterate through the list and watch the object be modified continuously with the same modifiers. 
  - If the object gets too complex, the app will simplify it to ensure things run smoothly
  - use the scroll wheel to zoom in and out 
  - You can save the form/screenshot using the controls at the bottom or by right clicking. 
