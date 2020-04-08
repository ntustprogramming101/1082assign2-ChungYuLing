PImage bg,title,gameover,startNormal,startHovered,restartNormal,restartHovered,life,soil;
PImage cabbage,groundhogDown,groundhogIdle,groundhogLeft,groundhogRight,soldier;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;
int gameState = GAME_START;

final int BUTTON_LEFT= 248;
final int BUTTON_RIGHT = 392;
final int BUTTON_TOP= 360;
final int BUTTON_BOTTOM= 420;

float groundhogSpeed=20;

int role_W=80;

int lifeX1=10;
int lifeX2=80;
int lifeX3=150;
int lifeY1=10;
int lifeY2=10;
int lifeY3=-50;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

float soldierX=random(-80,480);
float soldierXSpeed=3;
float soldierYi=floor(random(2,6));
float soldierY=80*soldierYi;

float cabbageX=(floor(random(0,7))+1)*80;
float cabbageY=floor(random(2,6))*80;

int groundhogX=320;
int groundhogY=80;





void setup() {
	size(640, 480, P2D);
  frameRate (60);
  bg=loadImage("img/bg.jpg");
  cabbage=loadImage("img/cabbage.png");
  title=loadImage("img/title.jpg");
  gameover=loadImage("img/gameover.jpg");
  startNormal=loadImage("img/startNormal.png");
  startHovered=loadImage("img/startHovered.png");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
  life=loadImage("img/life.png");
  soil=loadImage("img/soil.png");
  soldier=loadImage("img/soldier.png"); 
}

void draw() {
  
	// Switch Game State
  switch(gameState){
    
		// Game Start
    case GAME_START:
      image(title, 0, 0);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHovered, BUTTON_LEFT, BUTTON_TOP);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(startNormal, BUTTON_LEFT, BUTTON_TOP);
      }
    
    break;

		// Game Run
    case GAME_RUN:
      //background
      image(bg,0,0,640,480);
      image(soil,0,160,640,320);
      image(life,lifeX1,lifeY1);
      image(life,lifeX2,lifeY2);
      image(life,lifeX3,lifeY3);
      //lawn
      noStroke();
      fill(124,204,25);
      rect(0,145,640,15);
      //sun
      strokeWeight(5);
      stroke(255,255,0);
      fill(253,184,19);
      ellipse(590,50,120,120);
      
    
      
      
      //soldier
      image(soldier,soldierX,soldierY);
      soldierX+=soldierXSpeed;
      if(soldierX>640){
        soldierX=-80;
      }
      
      //cabbage
      image(cabbage,cabbageX,cabbageY);
      
      
        
      //groundhogmove
      
      if(groundhogY+80>height){
        groundhogY=height-80;
      }
      if(groundhogX+80>width){
        groundhogX=width-80;
      }
      if(groundhogX<0){
        groundhogX=0;
      }
      
      if(downPressed){
        groundhogY+=groundhogSpeed;
        
        image(groundhogDown,groundhogX,groundhogY);
      }
        
      if(leftPressed){
        groundhogX-=groundhogSpeed;
        
        image(groundhogLeft,groundhogX,groundhogY);
      }
        
      if(rightPressed){
        groundhogX+=groundhogSpeed;
        
        image(groundhogRight,groundhogX,groundhogY);
      }
        
      else{
        image(groundhogIdle,groundhogX,groundhogY);
      }
        
      //soldier&groundhog
      if(groundhogY==soldierY){
        if(groundhogX>soldierX&&groundhogX<soldierX+role_W){
          if(lifeY2==10){
            if(lifeY3==10){
              lifeY3=-50;
            }
            else{
              lifeY2=-50;
            }
          }
        }
      }
      if(lifeY2==-50){
        if(groundhogY==soldierY){
          if(groundhogX>soldierX&&groundhogX<soldierX+role_W){
            gameState = GAME_OVER;
          }
          }
        }
      

              
        
        
      //cabbage&&groundhog
      if(groundhogY==cabbageY){
        if(groundhogX>cabbageX&&groundhogX<cabbageX+role_W){
          cabbageY=-100;
          if(lifeY2==10){
            lifeY3=10;
          }
          else{
            lifeY2=10;
          }
        }
      }
       
 
    break;
     
     
		// Game Lose
     case GAME_OVER:
     image(gameover, 0, 0);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHovered, BUTTON_LEFT, BUTTON_TOP);
        if(mousePressed){
          gameState = GAME_RUN;
          groundhogX=320;
          groundhogY=80;

        }
      }else{
        image(restartNormal, BUTTON_LEFT, BUTTON_TOP);
      }
     
     break;
}
}


int nowTime,lastTime;

void keyPressed(){
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
     
      
      case DOWN:
        downPressed = true;
         nowTime = millis();
      if(- lastTime >=  250){ 
        lastTime = millis();
    }
        break;
      case LEFT:
        leftPressed = true;
         nowTime = millis();
      if(- lastTime >=  250){ 
        lastTime = millis();
    }
        break;
      case RIGHT:
        rightPressed = true;
         nowTime = millis();
      if(- lastTime >=  250){ 
        lastTime = millis();
    }
        break;
      
       
    }
  }
  
}
////////
void keyReleased(){
  if (key == CODED) {
    switch (keyCode) {
      
      
     
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
  
}
