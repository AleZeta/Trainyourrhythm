import processing.sound.*;
import processing.serial.*;
SoundFile lev1song;
Sound s;
FFT fft1;

int time1, time2;
int bands = 128;
float smoothingFactor = 0.35;
float[] sum = new float[bands];
int scale = 13;
float barWidth;

int number, flag, i=0, stato=0;
//int flagTimeMs;
//final int flagDelayMs = 5000;
boolean atflagup = true;
static int flagCountNumber=5;
static float valf, prev, NOPRESS = 0.2;

Serial myPort; //Declaring serial port object
String val_in;

PVector position = new PVector(300, 30);
PVector velocity= new PVector(0, 0);
PVector acceleration= new PVector(0, 0);
PVector theforce = new PVector(0, 0);
PImage monster1;
PImage monster2;
PImage monster3;
PImage monster4;
float gravity = 0.8;

void setup() {
  size(600, 800);
  monster1= loadImage("monster1.png");
  monster2= loadImage("monster2.png");
  monster3= loadImage("monster3.png");
  monster4= loadImage("monster4.png");
  fill(150);
  int flag=0;
  lev1song = new SoundFile (this, "lev1.wav");
  s = new Sound(this);
  barWidth = width/float(bands);   // Create the FFT analyzer and connect the playing soundfile to it.
  fft1 = new FFT(this, bands);
  fft1.input(lev1song);
  // flagTimeMs = millis();
  number=flagCountNumber;
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600); // Open the port you are using at the baudrate you want:
}

void draw() {
  background(25);
  stroke(0);
  strokeWeight(2);
  if (stato==0) {
    CountDownScreen();
  }  
  if (stato==1) {
    if (flag==1) {
      delay(800);
      lev1song.play();
      flag=0;
    }
    Showaudio (lev1song, fft1);  //imm vett
    if (millis()-time1>7800) {
      stato=2;
    }
  }
  if (stato==2) {
    CountDownScreen();
  }
  if (stato==3)
  {
    if (flag==1) {
      delay(800);
      lev1song.play();
      flag=0;
    }
    stato=4;
  } else if (stato==4) {
    if (millis()-time2<8000) {

      line(0, 325, width, 325);
      apply_force(gravity); 

      // fa cadere a terra l'oggetto
      if (valf>NOPRESS && i<4) {
        apply_force(-1.8);
        i++;
      } else {
        i=0;
      }
      update();
      check_edges();
      image(monster1, position.x, position.y, 50, 50); // inizializza l'oggetto
    } else exit();      //ritorno a un altra schermata
  }
}

void CountDownScreen() {
  background(0);
  // mainsong.stop();
  lev1song.stop();

  imageMode(CENTER);

  textAlign(CENTER, CENTER);
  textSize(height/5.5);
  fill(255, 114, 16);
  if (number >0) {

    text(number, width/2, height/2-height/80);
    delay(1000);
    number--;
  } else if (number==0) {
    text("GO!", width/2, height/2);
    delay(1000);
    number=-1;
  } else if (number==-1) {
    number=flagCountNumber;  
    if (stato==0) {
      stato=1;
      flag=1;
      time1=millis();
    }
    if (stato==2) {
      stato=3;
      flag=1;
      time2=millis();
    }
    //gameScreen=5;
  }
}

// 3 funzioni per far cadere l'oggetto
void apply_force(float force) { 
  theforce.y= force;
  acceleration.add(theforce);
}

void update() {
  velocity.add(acceleration);
  position.add(velocity);
}

void check_edges() {
  if (position.y > 300) {
    acceleration.y = 0;
    velocity.y = 0;
    position.y = 300;
  }
  if (position.y < 0) {
    acceleration.y =gravity;
    velocity.y = 0;
    position.y = 0;
  }
}

void Showaudio (SoundFile sample, FFT fft) {
  background(0, 0, 0);
  fill(255, 114, 16);
  stroke(255, 114, 16);  
  if (sample.isPlaying()) {
    fft.analyze();
    for (int i = 0; i < bands; i++) {

      sum[i] += (fft.spectrum[i] - sum[i]) * smoothingFactor;


      ellipse(i*barWidth, height/2, barWidth, -sum[i]*height*scale);
      ellipse(width-i*barWidth, height/2, barWidth, -sum[i]*height*scale);
    }
  }
}

void keyPressed() {
  apply_force(-1);
}

void serialEvent(Serial myPort) { //function that is called any time a data is received on the serial port
  if (stato !=1) {
    prev= valf;
    val_in = myPort.readStringUntil('\n'); //is one of the read() method available. 
    //The method ReadStringUntil() reads from the port up to and including a particular character (in this case '\n' =blank line).
    //It returns all the data from the buffer as a String or null if there is nothing available. 
    //This method assumes the incoming characters are ASCII.  
    // 
    val_in = trim(val_in); //trim remove whitespace and formatting characters (like carriage return)
    if (val_in != null) {
      print("val_in:");
      println(val_in); //print value received on the console
      //flag=1; //advise the draw function that a new data is available
      valf= float(val_in);
      print("valf:");
      println(valf);
    }
  }
}
