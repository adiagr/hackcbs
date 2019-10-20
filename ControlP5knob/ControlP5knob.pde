import processing.serial.*;

/**
* ControlP5 Knob
*
*
* find a list of public methods available for the Knob Controller
* at the bottom of this sketch.
*
* by Andreas Schlegel, 2012
* www.sojamo.de/libraries/controlp5
*
*/

import controlP5.*;

Serial myPort;
ControlP5 cp5;
PImage img;

PImage img2;
int myColorBackground = color(255,255,255);
int knobValue = 100;

Knob myKnobA;
Knob myKnobB;
Slider mySlider, mySlider2;

void setup() {
  size(700,400);
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, "/dev/ttyUSB0", 9600);
  myPort.bufferUntil('\n');
  smooth();
  noStroke();
    img = loadImage("safety-belt.png");
    img2 = loadImage("cross.png");
  cp5 = new ControlP5(this);
  
  myKnobA = cp5.addKnob("knobs")
               .setRange(0,240)
               .setValue(50)
               .setPosition(100,70)
               .setRadius(50)
               .setDragDirection(Knob.VERTICAL)
               .setCaptionLabel("Speed")
               .setColorCaptionLabel(0)
    ;
                 
      mySlider =   cp5.addSlider("slider")
     .setPosition(100,225)
     .setSize(200,20)
     .setRange(0,100)
     .setValue(128)
      .setCaptionLabel("Engine Oil")
     .setColorCaptionLabel(0)
     ;       
     mySlider2 =   cp5.addSlider("slider2")
     .setPosition(100,250)
     .setSize(200,20)
     .setRange(0,100)
     .setValue(128)
      .setCaptionLabel("Coolant")
     .setColorCaptionLabel(0)
     ;
      
  //myKnobB = cp5.addKnob("knobValuess")
  //             .setRange(0,255)
  //             .setValue(220)
  //             .setPosition(100,210)
  //             .setRadius(50)
  //             .setNumberOfTickMarks(10)
  //             .setTickMarkLength(4)
  //             .snapToTickMarks(true)
  //             .setColorForeground(color(255))
  //             .setColorBackground(color(0, 160, 100))
  //             .setColorActive(color(255,255,0))
  //             .setDragDirection(Knob.HORIZONTAL)
  //             ;
}

int coolant, seatbelt, engine, speed;
void draw() {
  background(myColorBackground);
  image(img, 3*width/4, width/8-10,width/8,width/8);
  if(seatbelt==0)
  image(img2, 3*width/4+60, width/8+50,width/25,width/25);
  textSize(18);
     text("Seatbelt", 3*width/4+10, width/8+120);
     textSize(18);
  
     //text("28.7372672,77.1156302", 100, height-50);
  fill(knobValue);
  //rect(0,height/2,width,height/2);
  //fill(0,100);
  //rect(80,40,140,320);
  
}

void serialEvent (Serial myPort){
        try
        {
          String data = myPort.readString();
        JSONObject json = parseJSONObject(data);
        
        mySlider.setValue(json.getInt("engine"));
        coolant = json.getInt("coolant"); // and so on...
        seatbelt = json.getInt("seatbelt"); // and so on...
        
        if(coolant == 0)
        mySlider2.setValue(0);
        else
        mySlider2.setValue(100);
        myKnobA.setValue(json.getInt("speed"));
        }
         catch(RuntimeException e) {
    e.printStackTrace();
  }
}

void knob(int theValue) {
  myColorBackground = color(theValue);
  println("a knob event. setting background to "+theValue);
  
  
}
void requestData()
{
for(int i=0;i<100;i++)
      {
        myKnobA.setValue(i);
        delay(100);
      };
  
}

void keyPressed() {
  switch(key) {
    case('1'):  thread("requestData");
    
  break;
    case('2'):myKnobB.setConstrained(false).hideTickMarks().snapToTickMarks(false);break;
    case('3'):myKnobA.shuffle();myKnobB.shuffle();break;
  }
  
}

/*
a list of all methods available for the Knob Controller
use ControlP5.printPublicMethodsFor(Knob.class);
to print the following list into the console.

You can find further details about class Knob in the javadoc.

Format:
ClassName : returnType methodName(parameter type)


controlP5.Controller : CColor getColor() 
controlP5.Controller : ControlBehavior getBehavior() 
controlP5.Controller : ControlWindow getControlWindow() 
controlP5.Controller : ControlWindow getWindow() 
controlP5.Controller : ControllerProperty getProperty(String) 
controlP5.Controller : ControllerProperty getProperty(String, String) 
controlP5.Controller : ControllerView getView() 
controlP5.Controller : Knob addCallback(CallbackListener) 
controlP5.Controller : Knob addListener(ControlListener) 
controlP5.Controller : Knob addListenerFor(int, CallbackListener) 
controlP5.Controller : Knob align(int, int, int, int) 
controlP5.Controller : Knob bringToFront() 
controlP5.Controller : Knob bringToFront(ControllerInterface) 
controlP5.Controller : Knob hide() 
controlP5.Controller : Knob linebreak() 
controlP5.Controller : Knob listen(boolean) 
controlP5.Controller : Knob lock() 
controlP5.Controller : Knob onChange(CallbackListener) 
controlP5.Controller : Knob onClick(CallbackListener) 
controlP5.Controller : Knob onDoublePress(CallbackListener) 
controlP5.Controller : Knob onDrag(CallbackListener) 
controlP5.Controller : Knob onDraw(ControllerView) 
controlP5.Controller : Knob onEndDrag(CallbackListener) 
controlP5.Controller : Knob onEnter(CallbackListener) 
controlP5.Controller : Knob onLeave(CallbackListener) 
controlP5.Controller : Knob onMove(CallbackListener) 
controlP5.Controller : Knob onPress(CallbackListener) 
controlP5.Controller : Knob onRelease(CallbackListener) 
controlP5.Controller : Knob onReleaseOutside(CallbackListener) 
controlP5.Controller : Knob onStartDrag(CallbackListener) 
controlP5.Controller : Knob onWheel(CallbackListener) 
controlP5.Controller : Knob plugTo(Object) 
controlP5.Controller : Knob plugTo(Object, String) 
controlP5.Controller : Knob plugTo(Object[]) 
controlP5.Controller : Knob plugTo(Object[], String) 
controlP5.Controller : Knob registerProperty(String) 
controlP5.Controller : Knob registerProperty(String, String) 
controlP5.Controller : Knob registerTooltip(String) 
controlP5.Controller : Knob removeBehavior() 
controlP5.Controller : Knob removeCallback() 
controlP5.Controller : Knob removeCallback(CallbackListener) 
controlP5.Controller : Knob removeListener(ControlListener) 
controlP5.Controller : Knob removeListenerFor(int, CallbackListener) 
controlP5.Controller : Knob removeListenersFor(int) 
controlP5.Controller : Knob removeProperty(String) 
controlP5.Controller : Knob removeProperty(String, String) 
controlP5.Controller : Knob setArrayValue(float[]) 
controlP5.Controller : Knob setArrayValue(int, float) 
controlP5.Controller : Knob setBehavior(ControlBehavior) 
controlP5.Controller : Knob setBroadcast(boolean) 
controlP5.Controller : Knob setCaptionLabel(String) 
controlP5.Controller : Knob setColor(CColor) 
controlP5.Controller : Knob setColorActive(int) 
controlP5.Controller : Knob setColorBackground(int) 
controlP5.Controller : Knob setColorCaptionLabel(int) 
controlP5.Controller : Knob setColorForeground(int) 
controlP5.Controller : Knob setColorLabel(int) 
controlP5.Controller : Knob setColorValue(int) 
controlP5.Controller : Knob setColorValueLabel(int) 
controlP5.Controller : Knob setDecimalPrecision(int) 
controlP5.Controller : Knob setDefaultValue(float) 
controlP5.Controller : Knob setHeight(int) 
controlP5.Controller : Knob setId(int) 
controlP5.Controller : Knob setImage(PImage) 
controlP5.Controller : Knob setImage(PImage, int) 
controlP5.Controller : Knob setImages(PImage, PImage, PImage) 
controlP5.Controller : Knob setImages(PImage, PImage, PImage, PImage) 
controlP5.Controller : Knob setLabel(String) 
controlP5.Controller : Knob setLabelVisible(boolean) 
controlP5.Controller : Knob setLock(boolean) 
controlP5.Controller : Knob setMax(float) 
controlP5.Controller : Knob setMin(float) 
controlP5.Controller : Knob setMouseOver(boolean) 
controlP5.Controller : Knob setMoveable(boolean) 
controlP5.Controller : Knob setPosition(float, float) 
controlP5.Controller : Knob setPosition(float[]) 
controlP5.Controller : Knob setSize(PImage) 
controlP5.Controller : Knob setSize(int, int) 
controlP5.Controller : Knob setStringValue(String) 
controlP5.Controller : Knob setUpdate(boolean) 
controlP5.Controller : Knob setValue(float) 
controlP5.Controller : Knob setValueLabel(String) 
controlP5.Controller : Knob setValueSelf(float) 
controlP5.Controller : Knob setView(ControllerView) 
controlP5.Controller : Knob setVisible(boolean) 
controlP5.Controller : Knob setWidth(int) 
controlP5.Controller : Knob show() 
controlP5.Controller : Knob unlock() 
controlP5.Controller : Knob unplugFrom(Object) 
controlP5.Controller : Knob unplugFrom(Object[]) 
controlP5.Controller : Knob unregisterTooltip() 
controlP5.Controller : Knob update() 
controlP5.Controller : Knob updateSize() 
controlP5.Controller : Label getCaptionLabel() 
controlP5.Controller : Label getValueLabel() 
controlP5.Controller : List getControllerPlugList() 
controlP5.Controller : Pointer getPointer() 
controlP5.Controller : String getAddress() 
controlP5.Controller : String getInfo() 
controlP5.Controller : String getName() 
controlP5.Controller : String getStringValue() 
controlP5.Controller : String toString() 
controlP5.Controller : Tab getTab() 
controlP5.Controller : boolean isActive() 
controlP5.Controller : boolean isBroadcast() 
controlP5.Controller : boolean isInside() 
controlP5.Controller : boolean isLabelVisible() 
controlP5.Controller : boolean isListening() 
controlP5.Controller : boolean isLock() 
controlP5.Controller : boolean isMouseOver() 
controlP5.Controller : boolean isMousePressed() 
controlP5.Controller : boolean isMoveable() 
controlP5.Controller : boolean isUpdate() 
controlP5.Controller : boolean isVisible() 
controlP5.Controller : float getArrayValue(int) 
controlP5.Controller : float getDefaultValue() 
controlP5.Controller : float getMax() 
controlP5.Controller : float getMin() 
controlP5.Controller : float getValue() 
controlP5.Controller : float[] getAbsolutePosition() 
controlP5.Controller : float[] getArrayValue() 
controlP5.Controller : float[] getPosition() 
controlP5.Controller : int getDecimalPrecision() 
controlP5.Controller : int getHeight() 
controlP5.Controller : int getId() 
controlP5.Controller : int getWidth() 
controlP5.Controller : int listenerSize() 
controlP5.Controller : void remove() 
controlP5.Controller : void setView(ControllerView, int) 
controlP5.Knob : Knob hideTickMarks() 
controlP5.Knob : Knob setAngleRange(float) 
controlP5.Knob : Knob setConstrained(boolean) 
controlP5.Knob : Knob setDragDirection(int) 
controlP5.Knob : Knob setMax(float) 
controlP5.Knob : Knob setMin(float) 
controlP5.Knob : Knob setNumberOfTickMarks(int) 
controlP5.Knob : Knob setRadius(float) 
controlP5.Knob : Knob setRange(float, float) 
controlP5.Knob : Knob setResolution(float) 
controlP5.Knob : Knob setScrollSensitivity(float) 
controlP5.Knob : Knob setShowAngleRange(boolean) 
controlP5.Knob : Knob setSize(int, int) 
controlP5.Knob : Knob setStartAngle(float) 
controlP5.Knob : Knob setTickMarkLength(int) 
controlP5.Knob : Knob setTickMarkWeight(float) 
controlP5.Knob : Knob setValue(float) 
controlP5.Knob : Knob setViewStyle(int) 
controlP5.Knob : Knob showTickMarks() 
controlP5.Knob : Knob shuffle() 
controlP5.Knob : Knob snapToTickMarks(boolean) 
controlP5.Knob : boolean isConstrained() 
controlP5.Knob : boolean isShowAngleRange() 
controlP5.Knob : boolean isShowTickMarks() 
controlP5.Knob : float getAngle() 
controlP5.Knob : float getAngleRange() 
controlP5.Knob : float getRadius() 
controlP5.Knob : float getResolution() 
controlP5.Knob : float getStartAngle() 
controlP5.Knob : float getTickMarkWeight() 
controlP5.Knob : float getValue() 
controlP5.Knob : int getDragDirection() 
controlP5.Knob : int getNumberOfTickMarks() 
controlP5.Knob : int getTickMarkLength() 
controlP5.Knob : int getViewStyle() 
java.lang.Object : String toString() 
java.lang.Object : boolean equals(Object) 

created: 2015/03/24 12:21:10

*/
