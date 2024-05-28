class Finish{
  
  float posX = 13000;
  float posY = 13000;
  float size = 400;
  
  void clearNear(){
    for(int i=0;i<bigMap.size();i++){
      if(distance(posX,posY,bigMap.get(i).posX,bigMap.get(i).posY)<size){
        bigMap.remove(bigMap.get(i));
        i--;
      }
    }
    
    for(int i=0;i<wheels.size();i++){
      if(distance(posX,posY,wheels.get(i).posX,wheels.get(i).posY)<size){
        wheels.remove(wheels.get(i));
        i--;
      }
    }
  }
  
  void draw(){
    imageD(checkI,posX,posY,size*2);
    fill(0);
    //ellipseD(posX,posY,size);
    if(distance(car.posX,car.posY,posX,posY)<size/2 && cpReached>=3){
      gameMode=2;
      setHighscore();
    }
  }
}

class Start{
  
  float posX = 2000;
  float posY = 2000;
  float size = 600; 
  
  void clearNear(){
    for(int i=0;i<bigMap.size();i++){
      if(distance(posX,posY,bigMap.get(i).posX,bigMap.get(i).posY)<size){
        bigMap.remove(bigMap.get(i));
        i--;
      }
    }
    
    for(int i=0;i<wheels.size();i++){
      if(distance(posX,posY,wheels.get(i).posX,wheels.get(i).posY)<size){
        wheels.remove(wheels.get(i));
        i--;
      }
    }
  }
  
  void draw(){
    //imageD(floorI,posX,posY,size*2);
    fill(255);
    ellipseD(posX,posY,size);
  }
}

class CheckPoint{
  
  float posX = 2000+random(11000);
  float posY = 2000+random(11000);
  float size = 300;
  
  CheckPoint(){
  }
  
  CheckPoint(float posX, float posY){
    this.posX=posX;
    this.posY=posY;
  }
  
  void clearNear(){
    for(int i=0;i<bigMap.size();i++){
      if(distance(posX,posY,bigMap.get(i).posX,bigMap.get(i).posY)<size){
        bigMap.remove(bigMap.get(i));
        i--;
      }
    }
    
    for(int i=0;i<wheels.size();i++){
      if(distance(posX,posY,wheels.get(i).posX,wheels.get(i).posY)<size){
        wheels.remove(wheels.get(i));
        i--;
      }
    }
  }
  
  void draw(){
    imageD(checkI,posX,posY,size*2);
    fill(0);
    //ellipseD(posX,posY,size);
    if(distance(car.posX,car.posY,posX,posY)<size/2){
      cpReached++;
    }
  }
}
