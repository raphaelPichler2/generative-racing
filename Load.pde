PImage carI;
PImage floorI;
PImage arrowFinI;
PImage reifnI;
PImage iceI;
PImage stopI;
PImage checkI;
PImage nitroI;
PImage bignitroI;
PImage trampoI;
PImage mudI;
PImage roadI;
PImage converyerI;
PImage boostI;
PImage polsterI;
PImage eraserI;
PImage dumpI;

void loadImg(){
  carI = loadImage("car.png");
  arrowFinI = loadImage("arrow.png");
  floorI = loadImage("Floor.png");
  reifnI = loadImage("reifn.png");
  iceI = loadImage("ice.png");
  stopI = loadImage("stop.png");
  checkI = loadImage("checkpoint.png");
  nitroI = loadImage("nitro.png");
  bignitroI = loadImage("bignitro.png");
  trampoI = loadImage("trampolin.png");
  roadI = loadImage("road.png");
  mudI = loadImage("mud.png");
  converyerI = loadImage("converyer.png");
  boostI = loadImage("boost.png");
  polsterI = loadImage("polster.png");
  eraserI = loadImage("eraser.png");
  dumpI = loadImage("trash.png");
}

void save(){
  table= loadTable("new.csv","header,csv");
  int objects=bigMap.size()+wheels.size();
  table.getRow(0).setFloat("value",objects);
  
  for(int i=0;i<bigMap.size();i++){
    table.getRow(i+1).setFloat("value",bigMap.get(i).code);
    table.getRow(i+1).setFloat("posX",bigMap.get(i).posX);
    table.getRow(i+1).setFloat("posY",bigMap.get(i).posY);
    table.getRow(i+1).setFloat("size",bigMap.get(i).size);
    table.getRow(i+1).setFloat("angle",bigMap.get(i).angle);
  }
  
  for(int i=0;i<wheels.size();i++){
    table.getRow(i+1+bigMap.size()).setFloat("value",wheels.get(i).code);
    table.getRow(i+1+bigMap.size()).setFloat("posX",wheels.get(i).posX);
    table.getRow(i+1+bigMap.size()).setFloat("posY",wheels.get(i).posY);
    table.getRow(i+1+bigMap.size()).setFloat("size",wheels.get(i).size);
  }
  table.getRow(wheels.size()+1+bigMap.size()).setFloat("posX",cp1.posX);
  table.getRow(wheels.size()+1+bigMap.size()).setFloat("posY",cp1.posY);
  table.getRow(wheels.size()+2+bigMap.size()).setFloat("posX",cp2.posX);
  table.getRow(wheels.size()+2+bigMap.size()).setFloat("posY",cp2.posY);
  table.getRow(wheels.size()+3+bigMap.size()).setFloat("posX",cp3.posX);
  table.getRow(wheels.size()+3+bigMap.size()).setFloat("posY",cp3.posY);
  
  saveTable(table, "data/new.csv");
  
  saveHighscores();
}

void saveHighscores(){
  table= loadTable("new.csv","header,csv");
  int objects=(int)table.getFloat(0,"value");
  table.getRow(objects+4).setFloat("value",highscore1);
  table.getRow(objects+4).setString("name",scoreHolder1);
  table.getRow(objects+5).setFloat("value",highscore2);
  table.getRow(objects+5).setString("name",scoreHolder2);
  table.getRow(objects+6).setFloat("value",highscore3);
  table.getRow(objects+6).setString("name",scoreHolder3);
  saveTable(table, "data/new.csv");
}

void loadMap(){
  table= loadTable("new.csv","header,csv");
  bigMap.clear();
  wheels.clear();
  int objects=(int)table.getFloat(0,"value");
  
  for(int i=1;i<objects+1;i++){
    switch ((int)table.getFloat(i,"value")){
      case -1:
        bigMap.add( new MapObj());
        break;
      case 0:
        wheels.add( new Wheel(table.getFloat(i,"posX"),table.getFloat(i,"posY"),table.getFloat(i,"size"),false) );
        break;
      case 1:
        bigMap.add( new Ice(table.getFloat(i,"posX"),table.getFloat(i,"posY"),table.getFloat(i,"size"),false) );
        break;
      case 2:
        bigMap.add( new Stop(table.getFloat(i,"posX"),table.getFloat(i,"posY"),table.getFloat(i,"size"),false) );
        break;
      case 3:
        bigMap.add( new Nitro(table.getFloat(i,"posX"),table.getFloat(i,"posY"),table.getFloat(i,"size"),false) );
        break;
      case 4:
        bigMap.add( new Trampo(table.getFloat(i,"posX"),table.getFloat(i,"posY"),table.getFloat(i,"size"),false) );
        break;
      case 5:
        bigMap.add( new Mud(table.getFloat(i,"posX"),table.getFloat(i,"posY"),table.getFloat(i,"size"),false) );
        break;
      case 6:
        bigMap.add( new Road(table.getFloat(i,"posX"),table.getFloat(i,"posY"),table.getFloat(i,"size"),table.getFloat(i,"angle"),false) );
        break;
      case 7:
        bigMap.add( new BigNitro(table.getFloat(i,"posX"),table.getFloat(i,"posY"),table.getFloat(i,"size"),false) );
        break;
      case 8:
        bigMap.add( new Conveyer(table.getFloat(i,"posX"),table.getFloat(i,"posY"),table.getFloat(i,"size"),table.getFloat(i,"angle"),false) );
        break;
      case 9:
        bigMap.add( new Boost(table.getFloat(i,"posX"),table.getFloat(i,"posY"),table.getFloat(i,"size"),table.getFloat(i,"angle"),false) );
        break;
      case 10:
        bigMap.add( new Polster(table.getFloat(i,"posX"),table.getFloat(i,"posY"),table.getFloat(i,"size"),table.getFloat(i,"angle"),false) );
        break;
    }
  }
  cp1=new CheckPoint(table.getFloat(objects+1,"posX"),table.getFloat(objects+1,"posY"));
  cp2=new CheckPoint(table.getFloat(objects+2,"posX"),table.getFloat(objects+2,"posY"));
  cp3=new CheckPoint(table.getFloat(objects+3,"posX"),table.getFloat(objects+3,"posY"));
  
  highscore1=table.getFloat(objects+4,"value");
  scoreHolder1=table.getString(objects+4,"name");
  highscore2=table.getFloat(objects+5,"value");
  scoreHolder2=table.getString(objects+5,"name");
  highscore3=table.getFloat(objects+6,"value");
  scoreHolder3=table.getString(objects+6,"name");
}
