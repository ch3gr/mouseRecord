import java.awt.MouseInfo;
import java.awt.Point;
import java.util.*; 
 


PrintWriter output;
PGraphics Trail;

float WinScale = 0.4;
boolean PressedOnce = false;

boolean StoreInFile = true;
Sample LastSample;
int counter;

class Sample {
  int x;
  int y;
  long time;

  
  Sample( int ix, int iy, long iTime ) {
    x = ix;
    y = iy;
    time = iTime;
  }
}

void setup() {
  
  size(int(1920*2*WinScale), int(1200*WinScale));
  colorMode( RGB, 1);
  frameRate(30);
  
  Trail = createGraphics( width, height );
  Trail.beginDraw();
  Trail.colorMode( RGB, 1);
  Trail.blendMode(ADD);
  Trail.endDraw();
  
  Date d = new Date();
  long t = d.getTime();
  String fileName=(new Long(t)).toString();
  fileName = "out/" + fileName + ".txt";

  if( StoreInFile ) {
    println( "Saving Output : " + fileName);
    output = createWriter(fileName);
  }
  
  LastSample = new Sample(0,0,t);
  counter = 0;
}




void draw() {
  background(0);
  
  Point mouse;
  mouse = MouseInfo.getPointerInfo().getLocation();
  
  
  Date d = new Date();
  long t = d.getTime();
  String tStr=(new Long(t)).toString();
 
  
  
  

  
    
  Sample sample = new Sample(mouse.x, mouse.y, t);
  if( LastSample.x != sample.x || LastSample.y != sample.y ) {

    Trail.beginDraw();
    Trail.stroke(0.1);
    Trail.line( sample.x*WinScale, sample.y*WinScale, LastSample.x*WinScale, LastSample.y*WinScale);
    Trail.endDraw();
    
    if( StoreInFile ) {
      output.println(mouse.x + " " + mouse.y + " " + t);
      counter ++;
    }
      


  }
  
  image( Trail, 0, 0 );
  LastSample = sample;

  
  fill(1,0,0);
  text( mouse.x, 10, 20 );
  text( mouse.y, 50, 20 );
  text( tStr, 100, 20 );
  text( frameRate, width-50, 20 );
  text( counter, 10, height-20 );
}

void saveImg() {
    Date d = new Date();
    long t = d.getTime();
    String filename=(new Long(t)).toString();
    filename = "out/"+ filename + ".jpg";
    Trail.save(filename);
}

void keyPressed(){
  
  if (key=='s'){
    saveImg();
  }
  
  if (key=='q'){
    if( StoreInFile ){
      output.flush(); // Write the remaining data
      output.close(); // Finish the file
      println( "Closing output and quiting" );
    }
    saveImg();
    exit(); // Stop the program
  }
}

    
