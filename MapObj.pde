class MapObj{
  
  float posX = random(15000);
  float posY = random(15000);
  float size = 100;
  float angle=0;
  float code=-1;
  
  void draw(){
    imageD(floorI,posX,posY,size);
  }
}

class Wheel extends MapObj{
  
  float speedX;
  float speedY;
  
  Wheel(){
    code=0;
    size = random(30,100);
    if(random(100)<35){
      float angle=random(TWO_PI);
      float dist = size/2;
      bigMap.add(new Wheel( posX +dist*cos(angle), posY +dist*sin(angle),angle));
    }
  }
  
  Wheel(float posX,float posY, float dir){
    code=0;
    size = random(30,100);
    this.posX=posX+size/2*cos(dir);
    this.posY=posY+size/2*sin(dir);
    if(random(100)<85){
      float angle=dir+random(-HALF_PI/2,HALF_PI/2);
      float dist = size;
      bigMap.add(new Wheel( posX +dist*cos(angle), posY +dist*sin(angle),angle));
    }
  }
  Wheel(float posX,float posY, float size,boolean b){
    code=0;
    this.size=size;
    this.posX=posX;
    this.posY=posY;
  }
  
  void draw(){
    imageD(reifnI,posX,posY,size*2);
    
    if(distance(posX,posY,car.posX,car.posY)<size/2+car.size/2 && car.posZ<=0){
      float speed=(float)Math.pow(0.7,0.7+size/140)  *2*distance(0,0,car.speedX,car.speedY);
      speedX=speed*(posX-car.posX)/distance(posX,posY,car.posX,car.posY);
      speedY=speed*(posY-car.posY)/distance(posX,posY,car.posX,car.posY);
      car.speedX*=  Math.pow(0.7,0.7+size/140);
      car.speedY*=  Math.pow(0.7,0.7+size/140);
    }
    speedX*=0.995;
    speedY*=0.995;
    posX+=speedX;
    posY+=speedY;
  }
}

class Ice extends MapObj{
  
  Ice(){
    code=1;
    size = random(200,400);
  }
  Ice(float posX,float posY, float size,boolean b){
    code=1;
    this.size=size;
    this.posX=posX;
    this.posY=posY;
  }
  
  void draw(){
    imageD(iceI,posX,posY,size*2);
    
    if(distance(posX,posY,car.posX,car.posY)<size/2+car.size/2 && car.posZ<=0){
      car.drift=100;
    }
  }
}

class Stop extends MapObj{
  
  Stop(){
    code=2;
    size = random(50,200);
    deletUnderme(this.posX,this.posY,size);
    if(random(100)<35){
      float angle=random(TWO_PI);
      float dist = size/2;
      bigMap.add(new Stop( posX +dist*cos(angle), posY +dist*sin(angle),angle));
    }
  }
  
  Stop(float posX,float posY, float dir){
    code=2;
    size = random(50,200);
    this.posX=posX+size/2*cos(dir);
    this.posY=posY+size/2*sin(dir);
    deletUnderme(this.posX,this.posY,size);
    if(random(100)<80){
      float angle=dir+random(-HALF_PI/2,HALF_PI/2);
      float dist = size;
      bigMap.add(new Stop( posX +dist*cos(angle), posY +dist*sin(angle),angle));
    }
  }
  Stop(float posX,float posY, float size,boolean b){
    code=2;
    this.size=size;
    this.posX=posX;
    this.posY=posY;
  }
  
  void draw(){
    imageD(stopI,posX,posY,size*2);
    
    if(distance(posX,posY,car.posX,car.posY)<size/2+car.size/2 && car.posZ<=0){
      startGame();
    }
  }
}

class Nitro extends MapObj{
  
  Nitro(){
    code=3;
    size = 80;
  }
  Nitro(float posX,float posY, float size,boolean b){
    code=3;
    this.size=size;
    this.posX=posX;
    this.posY=posY;
  }
  
  void draw(){
    imageD(nitroI,posX,posY,size*2);
    
    if(distance(posX,posY,car.posX,car.posY)<size/2+car.size/2 && car.posZ<=0){
      car.nitro+=90;
      bigMap.remove(this);
    }
  }
}

class Trampo extends MapObj{
  
  Trampo(){
    code=4;
    size = 110;
    deletUnderme(this.posX,this.posY,size);
  }
  Trampo(float posX,float posY, float size,boolean b){
    code=4;
    this.size=size;
    this.posX=posX;
    this.posY=posY;
  }
  
  void draw(){
    imageD(trampoI,posX,posY,size*2);
    
    if(distance(posX,posY,car.posX,car.posY)<size/2+car.size/2 && car.posZ<=0){
      car.speedZ=car.currentSpeed*0.6;
    }
  }
}

class Mud extends MapObj{
  
  Mud(){
    code=5;
    size = random(300,400);
    deletUnderme(this.posX,this.posY,size);
    if(random(100)<50){
      float angle=random(TWO_PI);
      float dist = size/2;
      bigMap.add(new Mud( posX +dist*cos(angle), posY +dist*sin(angle),angle));
    }
  }
  
  Mud(float posX,float posY, float dir){
    code=5;
    size = random(50,150);
    this.posX=posX+size/2*cos(dir);
    this.posY=posY+size/2*sin(dir);
    deletUnderme(this.posX,this.posY,size);
    if(random(100)<10){
      float angle=dir+random(-HALF_PI/2,HALF_PI/2);
      float dist = size;
      bigMap.add(new Mud( posX +dist*cos(angle), posY +dist*sin(angle),angle));
    }
  }
  Mud(float posX,float posY, float size,boolean b){
    code=5;
    this.size=size;
    this.posX=posX;
    this.posY=posY;
  }
  
  void draw(){
    imageD(mudI,posX,posY,size*2);
    
    if(distance(posX,posY,car.posX,car.posY)<size/2+car.size/2 && car.posZ<=0){
      car.drift=50;
      car.speed=3;
    }
  }
}

class Road extends MapObj{
  
  Road(){
    code=6;
    size = 180;
    angle=random(TWO_PI);
    if(random(100)<100){  
      float dist = 75;
      bigMap.add(new Road( posX +dist*cos(angle), posY +dist*sin(angle),angle));
    }
  }
  Road(float posX,float posY, float dir){
    code=6;
    size = 180;
    this.posX=posX+size/2*cos(dir);
    this.posY=posY+size/2*sin(dir);
    angle=dir+random(-HALF_PI/2,HALF_PI/2);
    if(random(100)<90){
      float dist = 150;
      bigMap.add(new Road( posX +dist*cos(angle), posY +dist*sin(angle),angle));
    }
  }
  Road(float posX,float posY, float size,float angle,boolean b){
    code=6;
    this.size=size;
    this.posX=posX;
    this.posY=posY;
    this.angle=angle;
  }
  
  void draw(){
    turnImgD(roadI,posX,posY,size*2,size*2,angle);
    
    if(distance(posX,posY,car.posX,car.posY)<size/2+car.size/2 && car.posZ<=0){
      car.drift=3;
    }
  }
}

class BigNitro extends MapObj{
  
  BigNitro(){
    code=7;
    size = 120;
  }
  BigNitro(float posX,float posY, float size,boolean b){
    code=7;
    this.size=size;
    this.posX=posX;
    this.posY=posY;
  }
  
  void draw(){
    imageD(bignitroI,posX,posY,size*2);
    
    if(distance(posX,posY,car.posX,car.posY)<size/2+car.size/2 && car.posZ<=0){
      car.nitro+=180;
      car.speedX*=1.1;
      car.speedY*=1.1;
      bigMap.remove(this);
    }
  }
}


class Conveyer extends MapObj{
  float speed=1.4;
  Conveyer(){
    code=8;
    size = 160;
    deletUnderme(posX,posY,size);
    if(random(100)<100){
      angle=HALF_PI*(int)random(4);
      float dist = size/2;
      bigMap.add(new Conveyer( posX +dist*cos(angle), posY +dist*sin(angle),angle));
    }
  }
  Conveyer(float posX,float posY, float dir){
    code=8;
    size = 160; 
    this.posX=posX+size/2*cos(dir);
    this.posY=posY+size/2*sin(dir);
    deletUnderme(this.posX,this.posY,size);
    this.angle=dir;
    if(random(100)<90){
      float dist = size;
      bigMap.add(new Conveyer( posX +dist*cos(angle), posY +dist*sin(angle),angle));
    }
  }
  Conveyer(float posX,float posY, float size,float angle,boolean b){
    code=8;
    this.size=size;
    this.posX=posX;
    this.posY=posY;
    this.angle=angle;
  }
  
  void draw(){
    turnImgD(converyerI,posX,posY,size*2,size*2,angle);
    
    if(car.posX<posX+size/2 && car.posX>posX-size/2 && car.posY<posY+size/2 && car.posY>posY-size/2 && car.posZ<=0){
      car.posX+=speed*cos(angle);
      car.posY+=speed*sin(angle);
    }
  }
}

class Boost extends MapObj{
  float speed=5;
  Boost(){
    code=9;
    size = 120;
    angle=random(TWO_PI);
  }
  Boost(float posX,float posY, float size,float angle,boolean b){
    code=9;
    this.size=size;
    this.posX=posX;
    this.posY=posY;
    this.angle=angle;
  }
  
  void draw(){
    turnImgD(boostI,posX,posY,size*2,size*2,angle);
    
    if(distance(posX,posY,car.posX,car.posY)<size/2+car.size/2 && car.posZ<=0){
      car.speedX+=speed*cos(angle);
      car.speedY+=speed*sin(angle);
      car.speedZ=speed*0.4;
      bigMap.remove(this);
    }
  }
}

class Polster extends MapObj{
  Polster(){
    code=10;
    size = 160;
  }
  Polster(float posX,float posY, float size,float angle,boolean b){
    code=10;
    this.size=size;
    this.posX=posX;
    this.posY=posY;
    this.angle=angle;
  }
  
  void draw(){
    turnImgD(polsterI,posX,posY,size*2,size*2,angle);
    
    if(distance(posX,posY,car.posX,car.posY)<size/2+car.size/2 && car.posZ<=0){
      float speedX=car.posX-posX;
      float speedY=car.posY-posY;
      float dis=distance(0,0,speedX,speedY);
      car.speedX+=2*car.currentSpeed*speedX/dis;
      car.speedY+=2*car.currentSpeed*speedY/dis;
      car.posX+=car.speedX;
      car.posY+=car.speedY;
      car.speedZ=car.currentSpeed*0.3;
      
      /*float CF= ((car.speedX)*(posX-car.posX)+(car.speedY)*(posY-car.posY)) / (float)(Math.pow(car.speedX,2)+Math.pow(car.speedY,2)) ;
      float bonceX=car.posX+ (car.speedX)*CF-posX;
      float bonceY=car.posY+ (car.speedY)*CF-posY;
      print(CF);
      car.speedX+=0.2*bonceX;
      car.speedY+=0.2*bonceY;
      car.posX+=car.speedX;
      car.posY+=car.speedY;
      car.speedZ=1;*/
    }
  }
}
