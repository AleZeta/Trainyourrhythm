import processing.sound.*;
SoundFile mainsong;
SoundFile lev1song;
Sound s;
print('ciao')

PImage play;
PImage records;
PImage exit;
PImage settings;
PImage back;

PImage immagine1;
PImage level1;
PImage level2;
PImage level3;
PImage level4;



int gameScreen = 0;
int level;
float playX, playY, recordsX, recordsY, exitX, exitY, settingsX, settingsY, playD, smallD, levelX, level1Y, level2Y, level3Y, level4Y, levelW, levelH, levelray;
float backX , backY, backD;
boolean playOver = false;
boolean settingsOver = false;
boolean exitOver = false;
boolean recordsOver = false;
boolean level1Over = false;
boolean level2Over = false;
boolean level3Over = false;
boolean level4Over = false;
boolean backOverL = false;

static int Width = 624;
static int Height = 800;

void setup() {
  size(1560,2000);
  LoadingScreen();
  immagine = loadImage("Sfondo1.png");
  play = loadImage("primo_bottone.png");
  records = loadImage("secondo_bottone.png");
  exit = loadImage("terzo_bottone.png");
  settings = loadImage("quarto_bottone.png");
  back = loadImage("Return.png");
  playX= width/2;
  playY= height/2.5;
  playD=height/4;
  recordsX= width/4;
  recordsY= height/1.9;
  smallD=height/11.42;
  exitX=width/2;
  exitY=height/1.6;
  settingsX=width*0.75;
  settingsY=height/1.9;
  backX =height/11;
  backY=height/11;
  backD=height/16;
  immagine1= loadImage("menu_livello.png");
  level1 = loadImage("primo_livello.png");
  level2 = loadImage("secondo_livello.png");
  level3 = loadImage("terzo_livello.png");
  level4 = loadImage("quarto_livello.png");
  levelX = width/2;
  level1Y = height/9;
  level2Y = height/9+height/6.67;
  level3Y = height/9+(height/6.67)*2;
  level4Y = height/9+(height/6.67)*3;
  levelW = height/2.73; 
  levelH = height/8;
  levelray = height;
 // mainsong = new SoundFile (this, "mainsong.wav");
  // mainsong.play();
   lev1song = new SoundFile (this, "lev1.wav");
   
  s = new Sound(this);
}


void draw() {
  // Display the contents of the current screen
  if (gameScreen == 0) {
    LoadingScreen();
  } else if (gameScreen == 1) {
    InitialScreen();
  } else if (gameScreen == 2) {
    LevelScreen();
  } else if (gameScreen == 3) {
    SettingsScreen();
  } else if (gameScreen == 4) {
    CountDownScreen();
  } 
}

void LoadingScreen() {
  background(0); //colore dello sfondo
  textAlign(CENTER); //allinea al centro
  text("Click to start", width/2, height/2);
  textSize(80); //grandezza del testo
  // codes of initial screen
}

void InitialScreen() { 
update(mouseX, mouseY);
  imageMode(CORNER);
  image(immagine, 0, 0,width,height);
  imageMode(CENTER);
  image(play, playX, playY, playD, playD);
  image(records, recordsX, recordsY, smallD, smallD);
  image(exit, exitX, exitY, smallD, smallD);
  image(settings, settingsX , settingsY, smallD, smallD);
  
  // codes of game screen
  if (playOver) {
    stroke(255, 255, 0);
    strokeWeight(6);
    noFill();
    ellipse(playX, playY, playD, playD);
  } else if (recordsOver){
    stroke(255, 255, 0);
    strokeWeight(6);
    noFill();
    ellipse(recordsX, recordsY, smallD, smallD);   
  } else if (exitOver){
    stroke(255, 255, 0);
    strokeWeight(6);
    noFill();
    ellipse(exitX, exitY, smallD, smallD);  
  } else if (settingsOver){
    stroke(255, 255, 0);
    strokeWeight(6);
    noFill();
    ellipse(settingsX , settingsY, smallD, smallD);  
  } else {
  }    
}

void LevelScreen(){ 
  update(mouseX, mouseY);
    imageMode(CORNER);
    image(immagine1, 0, 0,width,height);
    imageMode(CENTER);
    image(level1, levelX, level1Y, levelW, levelH);
    image(level2, levelX, level2Y, levelW, levelH);
    image(level3, levelX, level3Y, levelW, levelH);
    image(level4, levelX, level4Y, levelW, levelH);
    image(back, backX , backY, backD, backD);
  if (level1Over) {
    stroke(255, 255, 0);
    strokeWeight(6);
    noFill();
    rectMode(CENTER);
    rect(levelX, level1Y, levelW, levelH, levelray);
  } else if (level2Over){
    stroke(255, 255, 0);
    strokeWeight(6);
    noFill();
    rectMode(CENTER);
    rect(levelX, level2Y, levelW, levelH, levelray);   
  } else if (level3Over){
    stroke(255, 255, 0);
    strokeWeight(6);
    noFill();
    rectMode(CENTER);
    rect(levelX, level3Y, levelW, levelH, levelray);  
  } else if (level4Over){
    stroke(255, 255, 0);
    strokeWeight(6);
    noFill();
    rectMode(CENTER);
    rect(levelX, level4Y, levelW, levelH, levelray);  
  } else if (backOverL){
    stroke(255, 255, 0);
    strokeWeight(6);
    noFill();
    ellipse(backX , backY, backD, backD);  
  } else {
  }    
}

void SettingsScreen(){
    imageMode(CORNER);
    image(immagine1, 0, 0,width,height);
    image(back, backX , backY, backD, backD);
    
    float amplitude = map(mouseX, width/3, width/1.5, 0, 1);
    
    print(amplitude);
    s.volume(amplitude);
    
    if (backOverL){
    stroke(255, 255, 0);
    strokeWeight(6);
    noFill();
    ellipse(backX , backY, backD, backD);  
    }
}

void CountDownScreen(){
  background(255);
 
 // mainsong.stop();
}
  


public void mousePressed() {
  // if we are on the initial screen when clicked, start the game
  if (gameScreen==0) {
    gameScreen=1;
  } 
  if (playOver) {
    gameScreen=2;
  } 
  if (settingsOver){
    gameScreen=3;
  } 
  if (exitOver){
      exit();
  } 
  if (level1Over){
    gameScreen=4;
    level=1;
    lev1song.play();
    
  } 
  if (level2Over){
    gameScreen=4;
    level=2;
  }
  if (level3Over){
    gameScreen=4;
    level=3;
  } 
  if (level4Over){
    gameScreen=4;
    level=4;
  } 
  if (backOverL){
    gameScreen=1;
    backOverL = false;
  }
  
}


void update(float x, float y) {
  if (gameScreen==1){
  if (overCircle(playX, playY, playD)) {
    playOver = true;
    recordsOver = false;
    exitOver = false;
    settingsOver = false;
  } else if (overCircle(recordsX, recordsY, smallD)) {
    playOver = false;
    recordsOver = true;
    exitOver = false;
    settingsOver = false;
  } else if (overCircle(exitX, exitY, smallD)) {
    playOver = false;
    recordsOver = false;
    exitOver = true;
    settingsOver = false;
  } else if (overCircle(settingsX, settingsY, smallD)) {
    playOver = false;
    recordsOver = false;
    exitOver = false;
    settingsOver = true;
  } else {
    playOver = recordsOver = exitOver = settingsOver = false;
  } 
  }
  if (gameScreen==2){
  if (overRect(levelX, level1Y, levelW, levelH)) {
    level1Over = true;
    level2Over = false;
    level3Over = false;
    level4Over = false;
    backOverL = false;
  } else if (overRect(levelX, level2Y, levelW, levelH)) {
    level1Over = false;
    level2Over = true;
    level3Over = false;
    level4Over = false;
    backOverL = false;
  } else if (overRect(levelX, level3Y, levelW, levelH)) {
    level1Over = false;
    level2Over = false;
    level3Over = true;
    level4Over = false;
    backOverL = false;
  } else if (overRect(levelX, level4Y, levelW, levelH)) {
    level1Over = false;
    level2Over = false;
    level3Over = false;
    level4Over = true;
    backOverL = false;
  } else if (overCircle(backX , backY, backD)) {
    playOver = false;
    recordsOver = false;
    exitOver = false;
    settingsOver = false;
    backOverL =true;
  } else {
    level1Over = level2Over = level3Over = level4Over = backOverL = false;
  } 
  }
  if (gameScreen==3){
    if (overCircle(backX , backY, backD)) {
    playOver = false;
    recordsOver = false;
    exitOver = false;
    settingsOver = false;
    backOverL =true;
  } }
}

boolean overCircle(float x, float y, float diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

boolean overRect(float x, float y, float w, float h)  {
  if (mouseX >= x-w/2 && mouseX <= x+w/2 && 
      mouseY >= y && mouseY <= y+h) {
    return true;
  } else {
    return false;
  }
}
