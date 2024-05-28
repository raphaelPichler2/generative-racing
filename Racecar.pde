class Racecar{
  float posX = 2000;
  float posY = 2000;
  float size = 30;
  float speedX;
  float speedY;
  float speed=0;
  float beschln = 1;
  float drift;
  float grip;
  float nitro;
  float angle;
  float turnSpeed = 0.035;
  float angleChange;
  float speedZ;
  float posZ;
  float currentSpeed;
  float convMode=-1;
  
  void draw(){
    if(keys[6] && nitro>0){
      //speed*=2;
      nitro--;
      beschln+=25.0/120*(3-beschln);
    }
    if(nitro>0){
      fill(#D7FF5F);
      rect(50,1030+(-nitro)/2,40,nitro);
    }
    if(posZ<=0) drive2();
    else turnImgD(carI,posX,posY-posZ*0.65,size*2,size*2,HALF_PI+angle);
    if(distance(0,0,speedX,speedY)>1){
      if(keys[1])angle-=turnSpeed;
      if(keys[3])angle+=turnSpeed;
    }
    if(cpReached==0){
      turnImgD(arrowFinI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,cp1.posX,cp1.posY));
    }
    if(cpReached==1){
      turnImgD(arrowFinI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,cp2.posX,cp2.posY));
    }
    if(cpReached==2){
      turnImgD(arrowFinI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,cp3.posX,cp3.posY));
    }
    if(cpReached==3){
      turnImgD(arrowFinI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,fin.posX,fin.posY));
    }


    posX=posX+speedX;
    posY=posY+speedY;
    speedZ-=10.0/120;
    posZ=posZ+speedZ;
    if(posZ<0){
      posZ=0;
      speedZ=0;
    }
    
    baseStat();
  }
  
  void drive1(){
    if(keys[0] || keys[12]){
      float dist = distance(mouseX+camX,mouseY+camY, posX,posY);
      speedX = (speedX*drift + beschln*speed*(mouseX+camX-posX)/dist )/(drift+1);
      speedY = (speedY*drift + beschln*speed*(mouseY+camY-posY)/dist )/(drift+1);
      if(distance(0,0,speedX,speedY)>0.95*speed*beschln) beschln+=0.1/120;
      else beschln=1;
      turnImgD(carI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,mouseX+camX,mouseY+camY));
    }else{
      turnImgD(carI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,mouseX+camX,mouseY+camY));
      speedX=speedX*grip;
      speedY=speedY*grip;
    }
    if(keys[2] || keys[13]){
      speedX=speedX*0.95;
      speedY=speedY*0.95;
    }
  }
  
  void drive2(){
    currentSpeed=distance(0,0,speedX,speedY);
    if(keys[0] || keys[12]){
      /*float angMouse = (angle(posX,posY,mouseX+camX,mouseY+camY)+TWO_PI)%TWO_PI;
      textC(""+angMouse,960, 600, 30, 0);
      textC(""+angle,960, 700, 30, 0);
      if(Math.abs(angMouse-angle) <= turnSpeed )angle=angMouse;
      else if(Math.abs(angMouse-angle) < Math.abs(TWO_PI-(angMouse-angle)))angle+=turnSpeed;
      else angle-=turnSpeed;
      angle=(angle+TWO_PI)%TWO_PI; */
      
      speedX = (speedX*(currentSpeed+drift) + beschln*speed*cos(angle) )/(drift+currentSpeed+1);
      speedY = (speedY*(currentSpeed+drift) + beschln*speed*sin(angle) )/(drift+currentSpeed+1);
      if( distance(0,0,speedX,speedY)>0.95*speed*beschln) beschln+=0.3/120*(2-beschln);
      else beschln-=0.3;
      if(beschln<1)beschln=1;
      turnImgD(carI,posX,posY,size*2,size*2,HALF_PI+angle);
    }else{
      turnImgD(carI,posX,posY,size*2,size*2,HALF_PI+angle);
      speedX = (speedX*(currentSpeed+drift) + grip*currentSpeed*cos(angle) )/(drift+currentSpeed+1);
      speedY = (speedY*(currentSpeed+drift) + grip*currentSpeed*sin(angle) )/(drift+currentSpeed+1);
    }
    if(keys[2] || keys[13]){
      speedX = (speedX*drift)/(drift+1);
      speedY = (speedY*drift)/(drift+1);
      if(distance(0,0,speedX,speedY)>0.95*speed*beschln) beschln+=0.1/120;
      else beschln=1;
    }
  }
  
  void baseStat(){
    if(startTimer<=0)speed=3.5;
    else speed=0;
    drift = 16;
    grip = 0.95;
  }
}
