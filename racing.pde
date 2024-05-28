boolean firstFrameClick=true;
Boolean[] keys= new Boolean[14];
Table table;

int gameMode = 0;
float camX=0;
float camY=0;

float time;
Racecar car;
Finish fin;
CheckPoint cp1;
CheckPoint cp2;
CheckPoint cp3;
int cpReached;
Start start;
float startTimer;
float highscore1=0;String scoreHolder1="-";
float highscore2=0;String scoreHolder2="-";
float highscore3=0;String scoreHolder3="-";
String name="";
boolean carMode;

ArrayList<MapObj> bigMap = new ArrayList<MapObj>();
ArrayList<Wheel> wheels = new ArrayList<Wheel>();

void setup(){
  fullScreen(P2D);
  smooth(8);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  frameRate(120);
  imageMode(CENTER);
  loadImg();
  //table= loadTable("new.csv","header,csv");
  
  for(int i=0;i<keys.length;i++){
    keys[i]=false;
  }
  
  nameGen();
}

void draw(){
  background(255);
  if(gameMode==0){
    textC("name: "+name,960, 250, 30, 0);
    namePad();
    fill(200);
    rect(960, 350, 400, 100);
    textC("start",960, 350, 30, 0);
    if(buttonPressed(960, 350, 400, 100))startGame();
    fill(200);
    rect(960, 450, 400, 100);
    textC("generate map",960, 450, 30, 0);
    if(buttonPressed(960, 500, 450, 100))newMap();
    fill(200);
    rect(960, 550, 400, 100);
    textC("route 66",960, 550, 30, 0);
    if(buttonPressed(960, 550, 400, 100))startRoute66();
    fill(200);
    rect(960, 650, 400, 100);
    textC("death race",960, 650, 30, 0);
    if(buttonPressed(960, 650, 400, 100))startDeathRace();
    fill(200);
    rect(960, 750, 400, 100);
    textC("map creator",960, 750, 30, 0);
    if(buttonPressed(960, 750, 400, 100))startMapCreator();
    fill(200);
    rect(960, 850, 400, 100);
    textC("exit",960, 850, 30, 0);
    if(buttonPressed(960, 850, 400, 100))exit();
  }
  
  if(gameMode==1){
    time++;
    fin.draw();
    start.draw();
    if(cpReached==0){
      cp1.draw();
    }
    if(cpReached==1){
      cp2.draw();
    }
    if(cpReached==2){
      cp3.draw();
    }
    for(int i=0;i<bigMap.size();i++){
      bigMap.get(i).draw();
    }
    for(int i=0;i<wheels.size();i++){
      wheels.get(i).draw();
    }
    
    car.draw();
    float camSpeed=distance(0,0,car.speedX,car.speedY)/5;
    if(camSpeed<1)camSpeed=1;
    camX=(camX*43+car.posX-960+(car.speedX/camSpeed*60))/44;
    camY=(camY*43+car.posY-540+(car.speedY/camSpeed*100))/44;
    if(startTimer>0){
      startTimer--;
      textC(""+(int)(1+startTimer/120),960, 500, 30, 0);
    }
  }
  
  if(gameMode==2){
    String timeString =""+time/120;
    if(timeString.length()>6) timeString=timeString.substring(0,5)+"s";
    String hsString1 =""+highscore1/120;
    if(hsString1.length()>6)hsString1=hsString1.substring(0,5)+"s";
    String hsString2 =""+highscore2/120;
    if(hsString2.length()>6)hsString2=hsString2.substring(0,5)+"s";
    String hsString3 =""+highscore3/120;
    if(hsString3.length()>6)hsString3=hsString3.substring(0,5)+"s";
    textC("time: " + timeString,960, 200, 30, 0);
    textC(scoreHolder1+": " + hsString1,360, 200, 30, 0);
    textC(scoreHolder2+": " + hsString2,360, 240, 30, 0);
    textC(scoreHolder3+": " + hsString3,360, 280, 30, 0);
    fill(200);
    rect(960, 450, 400, 100);
    textC("restart",960, 450, 30, 0);
    if(buttonPressed(960, 450, 400, 100))startGame();
    fill(200);
    rect(960, 600, 400, 100);
    textC("back",960, 600, 30, 0);
    if(buttonPressed(960, 600, 400, 100))gameMode=0;
  }
  
  if(gameMode==5){
    
    mapCreator();
  }
  
  if (!keyPressed && !mousePressed)firstFrameClick=true;
  if (keyPressed || mousePressed )firstFrameClick=false;
}


void startGame(){
  gameMode=1;
  time=0;
  cpReached=1;
  carMode=true;
  
  loadMap();
  car=new Racecar();
  camX=car.posX-960;
  camY=car.posY-540;
  fin=new Finish();
  start=new Start();
  startTimer=3*120;
}

void startRoute66(){
  gameMode=3;
  time=0;
  cpReached=1;
  
  loadMap();
  car=new Racecar();
  camX=car.posX-960;
  camY=car.posY-540;
  fin=new Finish();
  start=new Start();
  startTimer=3*120;
}

void startDeathRace(){
  gameMode=4;
  time=0;
  cpReached=1;
  
  loadMap();
  car=new Racecar();
  camX=car.posX-960;
  camY=car.posY-540;
  fin=new Finish();
  start=new Start();
  startTimer=3*120;
}


void newMap(){
  bigMap.clear();
  wheels.clear();
  highscore1=0;scoreHolder1="-";
  highscore2=0;scoreHolder2="-";
  highscore3=0;scoreHolder3="-";
  int r=(int)random(160);
  
  for(int i=0;i<1500;i++){
    bigMap.add(new MapObj());
  }
  
  r=(int)random(260);
  for(int i=0;i<r;i++){
    bigMap.add(new Ice());
  }
  r=(int)random(150);
  for(int i=0;i<r;i++){
    bigMap.add(new Mud());
  }
  r=(int)random(70);
  for(int i=0;i<r;i++){
    bigMap.add(new Road());
  }
  
  r=(int)random(50);
  for(int i=0;i<r;i++){
    bigMap.add(new Conveyer());
  }
  
  
  r=(int)random(150);
  for(int i=0;i<r;i++){
    bigMap.add(new Polster());
  }
  
  r=(int)random(300);
  for(int i=0;i<r;i++){
    bigMap.add(new Trampo());
  }
  
  r=150+(int)random(400);
  for(int i=0;i<r;i++){
    bigMap.add(new Stop());
  }
  
  r=25+(int)random(40);
  for(int i=0;i<r;i++){
    bigMap.add(new Nitro());
  }
  r=10+(int)random(20);
  for(int i=0;i<r;i++){
    bigMap.add(new BigNitro());
  }
  
  r=10+(int)random(35);
  for(int i=0;i<r;i++){
    bigMap.add(new Boost());
  }
  
  r=160+(int)random(600);
  for(int i=0;i<r;i++){
    wheels.add(new Wheel());
  }
  
  fin.clearNear();
  start.clearNear();
  //cp1=new CheckPoint();
  cp2=new CheckPoint();
  cp3=new CheckPoint();
  //cp1.clearNear();
  cp2.clearNear();
  cp3.clearNear();
  save();
}

void setHighscore(){
  if(time<highscore1 || highscore1==0){
    highscore3=highscore2;
    scoreHolder3=scoreHolder2;
    highscore2=highscore1;
    scoreHolder2=scoreHolder1;
    highscore1=time;
    scoreHolder1=name;
  }else{
    if(time<highscore2 || highscore2==0){
      highscore3=highscore2;
      scoreHolder3=scoreHolder2;
      highscore2=time;
      scoreHolder2=name;
    }else{
      if(time<highscore3 || highscore3==0){
        highscore3=time;
        scoreHolder3=name;
      }
    }
  }
  saveHighscores();
}

void deletUnderme(float posX,float posY,float size){
  
  for(int i=0;i<bigMap.size();i++){
    if(distance(posX,posY,bigMap.get(i).posX,bigMap.get(i).posY)<size/2+bigMap.get(i).size/2){
      bigMap.remove(bigMap.get(i));
      i--;
    }
  }
}

void namePad(){
  if(keyPressed && firstFrameClick){
    if(key=='a' || key=='A')name = name+"A";
    if(key=='b' || key=='B')name = name+"B";
    if(key=='c' || key=='C')name = name+"C";
    if(key=='d' || key=='D')name = name+"D";
    if(key=='e' || key=='E')name = name+"E";
    if(key=='f' || key=='F')name = name+"F";
    if(key=='g' || key=='G')name = name+"G";
    if(key=='h' || key=='H')name = name+"H";
    if(key=='i' || key=='I')name = name+"I";
    if(key=='j' || key=='J')name = name+"J";
    if(key=='k' || key=='K')name = name+"K";
    if(key=='l' || key=='L')name = name+"L";
    if(key=='m' || key=='M')name = name+"M";
    if(key=='n' || key=='N')name = name+"N";
    if(key=='o' || key=='O')name = name+"O";
    if(key=='p' || key=='P')name = name+"P";
    if(key=='q' || key=='Q')name = name+"Q";
    if(key=='r' || key=='R')name = name+"R";
    if(key=='s' || key=='S')name = name+"S";
    if(key=='t' || key=='T')name = name+"T";
    if(key=='u' || key=='U')name = name+"U";
    if(key=='v' || key=='V')name = name+"V";
    if(key=='w' || key=='W')name = name+"W";
    if(key=='x' || key=='X')name = name+"X";
    if(key=='y' || key=='Y')name = name+"Y";
    if(key=='z' || key=='Z')name = name+"Z";
    if(key==' ')name = name+" ";
    if(key=='-')name = name+"-";
    if(key==BACKSPACE && name.length()>0)name = name.substring(0,name.length()-1);
    if(name.length()>12)name = name.substring(0,12);
  }
}
