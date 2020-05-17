PImage bg,title,gameover,startNormal,startHovered,restartNormal,restartHovered,life,soil;
PImage cabbage,groundhogDown,groundhogIdle,groundhogLeft,groundhogRight,soldier;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;

int gameState;
int hit = 2;
int actionFrame;


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
int lifeY3=10;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

float soldierX,soldierXSpeed,soldierYi,soldierY;
float cabbageX,cabbageY;
float groundhogX,groundhogY;
float groundhogX2,groundhogY2;






void setup() {
	size(640, 480, P2D);
  
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
  
  soldierX=random(-1,6)*role_W;
  soldierXSpeed=3;
  soldierY=floor(random(2,6))*80;

  cabbageX=(floor(random(0,7))+1)*role_W;
  cabbageY=floor(random(2,6))*80;

  groundhogX=role_W*4;
  groundhogY=role_W;
  
  frameRate (60);
  gameState = GAME_START;
  lastTime = millis();
  
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
      image(soil,0,role_W*2,640,320);
      
      if(hit==0){
        gameState = GAME_OVER;
      }
      if(hit==1){
        image(life,lifeX1,lifeY1);
      }
      if(hit==2){
        image(life,lifeX1,lifeY1);
        image(life,lifeX2,lifeY2);
      }
      if(hit==3){
        image(life,lifeX1,lifeY1);
        image(life,lifeX2,lifeY2);
        image(life,lifeX3,lifeY3);
      }
      
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
      soldierX+=soldierXSpeed;
      //soldierX%=(width+role_W);
      if(soldierX>640){
        soldierX=-80;
      }
      image(soldier,soldierX,soldierY);
            
      //soldier&groundhog
      if(groundhogX+role_W>soldierX-role_W && groundhogX<soldierX){
        if(groundhogY+role_W>soldierY&&groundhogY<soldierY+role_W){
          hit=hit-1;
                    
          if(hit>0&&hit<=3){
        groundhogX=role_W*4;
        groundhogY=role_W;
        }
        downPressed = false;
        leftPressed = false;
        rightPressed = false;
      }
    }
      
      //cabbage
      image(cabbage,cabbageX,cabbageY);
      //cabbage&&groundhog
      if(groundhogX+role_W > cabbageX && groundhogX < cabbageX+role_W
      && groundhogY+role_W > cabbageY && groundhogY < cabbageY+role_W){
          cabbageY=-100;
          hit=hit+1;
        
      }
      
        
      //groundhogmove
      
      
      
      if(downPressed==false&&leftPressed==false&&rightPressed==false){
        image(groundhogIdle,groundhogX,groundhogY);
      }
      
      if(downPressed){
        actionFrame++;
        if(actionFrame>0 && actionFrame<15){
          groundhogY+=role_W/15.0;        
          image(groundhogDown,groundhogX,groundhogY);
      }else{
        groundhogY=groundhogY2+role_W;
        downPressed = false;
      }
      }
        
      if(leftPressed){
        actionFrame++;
        if(actionFrame>0 && actionFrame<15){
          groundhogX-=role_W/15.0;                
          image(groundhogLeft,groundhogX,groundhogY);
      }else{
        groundhogX=groundhogX2-role_W;
        leftPressed = false;
      }
      }
        
      if(rightPressed){
        actionFrame++;
        if(actionFrame>0 && actionFrame<15){
          groundhogX+=role_W/15.0;
          image(groundhogRight,groundhogX,groundhogY);
      }else{
        groundhogX=groundhogX2+role_W;
        rightPressed = false;
      }
      }
        
      /*else{
        image(groundhogIdle,groundhogX,groundhogY);
      }*/
        
      
      /*if(lifeY2==-50){
        if(groundhogY==soldierY){
          if(groundhogX>soldierX&&groundhogX<soldierX+role_W){
            gameState = GAME_OVER;
          }
          }
        }*/
      
      if(groundhogY>=height-role_W){
        groundhogY=height-role_W;
      }
       if(groundhogY<=0){
        groundhogY=0;
      }
      if(groundhogX>width-role_W){
        groundhogX=width-role_W;
      }
      if(groundhogX<=0){
        groundhogX=0;
      }
     
       
 
    break;
     
     
		// Game Lose
     case GAME_OVER:
     image(gameover, 0, 0);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHovered, BUTTON_LEFT, BUTTON_TOP);
        if(mousePressed){
          downPressed = false;
          leftPressed = false;
          rightPressed = false;
          soldierX=random(-1,6)*role_W;
          soldierXSpeed=3;          
          soldierY=floor(random(2,6))*80;

          cabbageX=(floor(random(0,7))+1)*role_W;
          cabbageY=floor(random(2,6))*role_W;

          hit=2;
          groundhogX=role_W*4;
          groundhogY=role_W;
          gameState = GAME_RUN;
          

        }
      }else{
        image(restartNormal, BUTTON_LEFT, BUTTON_TOP);
      }
     
     break;
}
}


float nowTime,lastTime;

void keyPressed(){
  nowTime = millis();  
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
     
      
      case DOWN:
      if(nowTime - lastTime >  250){ 
        downPressed = true;
        actionFrame = 0;
        groundhogY2=groundhogY;            
        lastTime = nowTime;
    }
        break;
      case LEFT:
        if(nowTime - lastTime >  250){ 
        leftPressed = true;
        actionFrame = 0;
        groundhogX2=groundhogX;             
        lastTime = nowTime;
    }
        break;
      case RIGHT:
        if(nowTime - lastTime >  250){ 
        rightPressed = true;
        actionFrame = 0;
        groundhogX2=groundhogX;
              
        lastTime = nowTime;
    }
        break;
      
       
    }
  }
  
}
////////
/*void keyReleased(){
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
*/
