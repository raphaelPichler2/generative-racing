void startMapCreator(){
  gameMode=5;
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


int obstacleHolding=-1;
float mousePrevX;
float mousePrevY;
float mouseDir;
CheckPoint cHold;

void mapCreator(){
    fin.draw();
    start.draw();
    //cp1.draw();textC("1",cp1.posX-camX,cp1.posY-camY+50,30,0);
    cp2.draw();textC("1",cp2.posX-camX,cp2.posY-camY+50,30,0);
    cp3.draw();textC("2",cp3.posX-camX,cp3.posY-camY+50,30,0);
    if(mousePressed && firstFrameClick &&cHold==null && obstacleHolding==-1){
      if(distance(cp2.posX,cp2.posY,mouseX+camX,mouseY+camY)<cp2.size/2)cHold=cp2;
      if(distance(cp3.posX,cp3.posY,mouseX+camX,mouseY+camY)<cp3.size/2)cHold=cp3;
    }
    if(cHold != null){
      cHold.posX=mouseX+camX;
      cHold.posY=mouseY+camY;
      if(!mousePressed)cHold=null;
    }
    for(int i=0;i<bigMap.size();i++){
      bigMap.get(i).draw();
    }
    for(int i=0;i<wheels.size();i++){
      wheels.get(i).draw();
    }
    
    if(keys[5] && firstFrameClick){
      save();
      highscore1=0;scoreHolder1="-";
      highscore2=0;scoreHolder2="-";
      highscore3=0;scoreHolder3="-";
      startGame();
    }
    if (keys[0])camY-=8;
    if (keys[1])camX-=8;
    if (keys[2])camY+=8;
    if (keys[3])camX+=8;
    
    fill(#CCC9FF,100);
    rect(1920/2,1080,1920,500);//1080-250=750+80=830;
    if(keys[13])obstacleHolding=-1;
    //wheels
    if(obstacleButton(reifnI,80,910))obstacleHolding=0;
    boolean noWheelsUnder=true;
    for(int i=0;i<wheels.size();i++){
      if(distance(mouseX+camX,mouseY+camY,wheels.get(i).posX,wheels.get(i).posY)<wheels.get(i).size)noWheelsUnder=false;
    }
    if(obstacleHolding==0)image(reifnI,mouseX,mouseY,140,140);
    if(obstacleHolding==0 && mouseY<830 && keys[12] && noWheelsUnder) wheels.add(new Wheel(mouseX+camX,mouseY+camY, 70,true));
    
    //stops
    if(obstacleButton(stopI,80,990))obstacleHolding=1;
    boolean noStopUnder=true;
    for(int i=0;i<bigMap.size();i++){
      if(bigMap.get(i).code ==2 && distance(mouseX+camX,mouseY+camY,bigMap.get(i).posX,bigMap.get(i).posY)<bigMap.get(i).size)noStopUnder=false;
    }
    if(obstacleHolding==1)image(stopI,mouseX,mouseY,200,200);
    if(obstacleHolding==1 && mouseY<830 && keys[12] && noStopUnder) bigMap.add(new Stop(mouseX+camX,mouseY+camY, 100,true));
    
    //eraser
    if(obstacleButton(eraserI,180,910))obstacleHolding=2;
    for(int i=0;i<bigMap.size();i++){
      if(mousePressed && obstacleHolding==2 && distance(mouseX+camX,mouseY+camY,bigMap.get(i).posX,bigMap.get(i).posY)<bigMap.get(i).size/2+20 && bigMap.get(i).code!=-1)bigMap.remove(i);
    }
    for(int i=0;i<wheels.size();i++){
      if(mousePressed && obstacleHolding==2 && distance(mouseX+camX,mouseY+camY,wheels.get(i).posX,wheels.get(i).posY)<wheels.get(i).size/2+20)wheels.remove(i);
    }
    if(obstacleHolding==2)image(eraserI,mouseX,mouseY,200,200);
    
    //dump
    if(obstacleButton(dumpI,180,990)){
      for(int i=0;i<bigMap.size();){
        bigMap.remove(i);
      }
      for(int i=0;i<wheels.size();){
        wheels.remove(i);
      }
      for(int i=0;i<1500;i++){
        bigMap.add(new MapObj());
      }
    }
    
    //ice
    if(obstacleButton(iceI,280,910))obstacleHolding=3;
    if(obstacleHolding==3)image(iceI,mouseX,mouseY,500,500);
    if(obstacleHolding==3 && mouseY<830 && keys[12] && firstFrameClick) bigMap.add(new Ice(mouseX+camX,mouseY+camY, 250,true));
    
     //mud
    if(obstacleButton(mudI,280,990))obstacleHolding=4;
    if(obstacleHolding==4)image(mudI,mouseX,mouseY,400,400);
    if(obstacleHolding==4 && mouseY<830 && keys[12] && firstFrameClick) bigMap.add(new Mud(mouseX+camX,mouseY+camY, 200,true));
    
    mouseDir=angle(mousePrevX,mousePrevY,mouseX+camX,mouseY+camY);
    
    //Road
    if(obstacleButton(roadI,380,910))obstacleHolding=5;
    boolean noRoadUnder=true;
    for(int i=0;i<bigMap.size();i++){
      if(bigMap.get(i).code ==6 && distance(mouseX+camX,mouseY+camY,bigMap.get(i).posX,bigMap.get(i).posY)<bigMap.get(i).size-25)noRoadUnder=false;
    }
    if(obstacleHolding==5)image(roadI,mouseX,mouseY,320,320);
    if(obstacleHolding==5 && mouseY<830 && keys[12] && noRoadUnder) bigMap.add(new Road(mouseX+camX,mouseY+camY, 160,mouseDir,true));
    
    //Conveyer
    if(obstacleButton(converyerI,380,990))obstacleHolding=6;
    boolean noConverUnder=true;
    for(int i=0;i<bigMap.size();i++){
      if(bigMap.get(i).code ==8 && distance(mouseX+camX,mouseY+camY,bigMap.get(i).posX,bigMap.get(i).posY)<bigMap.get(i).size)noConverUnder=false;
    }
    if(obstacleHolding==6)image(converyerI,mouseX,mouseY,320,320);
    if(obstacleHolding==6 && mouseY<830 && keys[12] && noConverUnder) bigMap.add(new Conveyer(mouseX+camX,mouseY+camY, 160,mouseDir,true));
    
    //Polster
    if(obstacleButton(polsterI,480,910))obstacleHolding=7;
    if(obstacleHolding==7)image(polsterI,mouseX,mouseY,320,320);
    if(obstacleHolding==7 && mouseY<830 && keys[12] && firstFrameClick) bigMap.add(new Polster(mouseX+camX,mouseY+camY, 160,0,true));
    
    //Trampo
    if(obstacleButton(trampoI,480,990))obstacleHolding=8;
    if(obstacleHolding==8)image(trampoI,mouseX,mouseY,220,220);
    if(obstacleHolding==8 && mouseY<830 && keys[12] && firstFrameClick) bigMap.add(new Trampo(mouseX+camX,mouseY+camY, 110,true));
    
    //Nitro
    if(obstacleButton(nitroI,580,910))obstacleHolding=9;
    if(obstacleHolding==9)image(nitroI,mouseX,mouseY,160,160);
    if(obstacleHolding==9 && mouseY<830 && keys[12] && firstFrameClick) bigMap.add(new Nitro(mouseX+camX,mouseY+camY, 80,true));
    
    //BigNitro
    if(obstacleButton(bignitroI,580,990))obstacleHolding=10;
    if(obstacleHolding==10)image(bignitroI,mouseX,mouseY,240,240);
    if(obstacleHolding==10 && mouseY<830 && keys[12] && firstFrameClick) bigMap.add(new BigNitro(mouseX+camX,mouseY+camY, 120,true));
    
    //Boost
    if(obstacleButton(boostI,680,910))obstacleHolding=11;
    if(obstacleHolding==11)image(boostI,mouseX,mouseY,240,240);
    if(obstacleHolding==11 && mouseY<830 && keys[12] && firstFrameClick) bigMap.add(new Boost(mouseX+camX,mouseY+camY, 120,mouseDir,true));
    
    //turnImgD(arrowFinI,mouseX+camX,mouseY+camY,80,80,HALF_PI+angle(mouseX+camX, mouseY+camY,cp1.posX,cp1.posY));
    turnImgD(arrowFinI,mouseX+camX,mouseY+camY,100,100,HALF_PI+angle(mouseX+camX, mouseY+camY,cp2.posX,cp2.posY));
    turnImgD(arrowFinI,mouseX+camX,mouseY+camY,100,100,HALF_PI+angle(mouseX+camX, mouseY+camY,cp3.posX,cp3.posY));
    turnImgD(arrowFinI,mouseX+camX,mouseY+camY,100,100,HALF_PI+angle(mouseX+camX, mouseY+camY,fin.posX,fin.posY));
    
    mousePrevX=mouseX+camX;
    mousePrevY=mouseY+camY;
}

boolean obstacleButton(PImage img,float posX,float posY){
  
  image(img,posX,posY,120,120);
  return (buttonPressed(posX,posY,60,60));
}
