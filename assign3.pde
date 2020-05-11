final int ROG_START_X = 320;
final int ROG_START_Y = 80;
final int SOLDIER_RANGE =0;
final int SOLDIER_Y = 160;
final int ROBOT_Y = 160;
final int BLOCK = 80;

final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

//BUTTON
final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

//background
PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24;
PImage soil0,soil1,soil2,soil3,soil4,soil5;
PImage stone1,stone2;

//item
PImage life,robot,soil,soldier,cabbage;
PImage  groundhogIdle,groundhogDown,groundhogLeft,groundhogRight;

//P2D
float pageCamera = 0;
float pageY = 0;
float soilX=0;
float soilY=160;


//rog move
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

//life
boolean newLife = false;
int newLifeX;
int heartNum;
float heartY = 10 ;

int randRobot,randSoldier;
float hogX , hogY , hogSpeed;
float hogMoveX,hogMoveY;
float soldierX=0.0, soldierY , soldierSpeed;
float cabbageX , cabbageY;

//stone 
int stone1Tmp=2;
int stone2Tmp=1;


// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean camera = false;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
//item
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
   life = loadImage("img/life.png");

//soil
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  
//stone
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  
  //groundhog
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  
  //soldier
  randSoldier = floor(random(0,4));
  soldierY = SOLDIER_Y + randSoldier*80;
  soldierSpeed = floor(random( 1,3 )) ;
  
  //groundhog
  hogX = ROG_START_X;
  hogY = ROG_START_Y;
  
  //cabbage
  cabbageX=floor(random(0,8))*BLOCK;
  cabbageY= 160+floor(random(0,4))*BLOCK;
  
  //life
  heartNum = 2;

}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;


// In-Game
		case GAME_RUN: 
//translate

// Background
		image(bg, 0, 0);

	   // Sun
	   stroke(255,255,0);
	   strokeWeight(5);
	   fill(253,184,19);
	   ellipse(590,50,120,120);

	  // Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

    if( camera ){
      translate( 0,pageCamera );
    }

// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		  //image(soil8x24, 0, 160);
    for( int i=0 ; i<24 ; i++ ){
      
      for( int j=0 ; j<8 ; j++ ){
      
        //first floor  
        if( i<4 ){
           image( soil0,soilX+BLOCK*j,soilY+BLOCK*i );
           //stone
           if( i==j ){
             image( stone1,soilX+BLOCK*j,soilY+BLOCK*i );
           }
        }
        
        //second floor
        else if( i>=4 && i<8 ){
          
           image( soil1,soilX+BLOCK*j,soilY+BLOCK*i );
           //stone
           if( i==j ){
             image( stone1,soilX+BLOCK*j,soilY+BLOCK*i );
           }
           
        }
        //third floor
         else if(  i>=8 && i<12 ){
           image( soil2,soilX+BLOCK*j,soilY+BLOCK*i );
           
           if( i%4==0 || i%4==3 ){
             if( (j+1)%4==2 || (j+1)%4==3 ){
               image( stone1,soilX+BLOCK*j,soilY+BLOCK*i );
             }
           }
           else{
             if( (j+1)%4==1 || (j+1)%4==0 ){
               image( stone1,soilX+BLOCK*j,soilY+BLOCK*i );
             }
           }
        }
        //forth floor
        else if(  i>=12 && i<16 ){
           image( soil3,soilX+BLOCK*j,soilY+BLOCK*i );
           
           if( i%4==0 || i%4==3 ){
             if( (j+1)%4==2 || (j+1)%4==3 ){
               image( stone1,soilX+BLOCK*j,soilY+BLOCK*i );
             }
           }
           else{
             if( (j+1)%4==1 || (j+1)%4==0 ){
               image( stone1,soilX+BLOCK*j,soilY+BLOCK*i );
             }
           }
        }
        //fifth floor
         else if(  i>=16 && i<20 ){
           image( soil4,soilX+BLOCK*j,soilY+BLOCK*i );
           
           //stone1
           if(  (j+1)%3!=stone1Tmp ){
             image( stone1,soilX+BLOCK*j,soilY+BLOCK*i );
           }
           //stone2
           if(  (j+1)%3==stone2Tmp ){
             image( stone2,soilX+BLOCK*j,soilY+BLOCK*i );
           }
           
        }
        else if(  i>=20 && i<24 ){
           image( soil5,soilX+BLOCK*j,soilY+BLOCK*i );
           
           //stone1
           if(  (j+1)%3!=stone1Tmp ){
             image( stone1,soilX+BLOCK*j,soilY+BLOCK*i );
           }
           
            //stone2
           if(  (j+1)%3==stone2Tmp ){
             image( stone2,soilX+BLOCK*j,soilY+BLOCK*i );
           }
           
        }
      
      }//j
      
      //stone1Tmp
        stone1Tmp --;
        stone2Tmp--;
        if( stone1Tmp<0 ){
          stone1Tmp = 2;
        }
        if( stone2Tmp<0 ){
          stone2Tmp = 2;
        }
      
    }//i
//soil end 

// Player
    //soldier
   image( soldier, soldierX ,soldierY );
    soldierX += soldierSpeed;
    
    if( soldierX>640 ){
      soldierX = -100;
    }
    
    //cabbage  newlife
    if( !newLife ){
      image( cabbage,cabbageX,cabbageY );
      
      if( hogX>=cabbageX && hogX<(cabbageX+BLOCK) ){
        if( hogY==cabbageY ){
          heartNum ++;
          newLife = true;
        }
      }
    }
    
    
    //meet soldier lose heart
    if( hogY==soldierY ){
      
      if( (hogX+BLOCK) > (soldierX+BLOCK) && hogX < (soldierX+BLOCK)  ){
        heartNum --;
        hogX = ROG_START_X;
        hogY = ROG_START_Y;
        
        pageY=0;
        pageCamera = 0;
        heartY = 10;
        camera = false;
      }
      if( (hogX+BLOCK) > soldierX && hogX < soldierX  ){
        heartNum --;
        hogX = ROG_START_X;
        hogY = ROG_START_Y;
        
        pageY=0;
        pageCamera = 0;
        heartY = 10;
        camera = false;
      }
    }
    
    // Health UI
   //amount of heart
    
    for( int i=0 ; i<heartNum ; i++ ){
     
      image( life,10+i*70,heartY );
      
    }
    
    
      
      //no heart game over
      if( heartNum<1 ){
        gameState = GAME_OVER;
      }
    
      //groundhog move
      if( rightPressed ){
        if( hogMoveX<=hogX ){
          image( groundhogRight , hogMoveX, hogY );
          hogMoveX += (BLOCK/15);//15 frames
        }else{
          rightPressed = false;
        }
      }
      else if(leftPressed){
        if( hogMoveX>=hogX ){
          image( groundhogLeft , hogMoveX, hogY );
          hogMoveX -= (BLOCK/15);//15 frames
        }else{
          leftPressed = false;
        }
      }
     
      
      else if(downPressed){

 //hog - down
  
       if( hogMoveY<=hogY ){
          image( groundhogDown , hogX, hogMoveY );
          hogMoveY += (BLOCK/15);//15 frames
        }else{
          downPressed = false;
        }
 //camera down
       if( pageCamera>-1600 ){
            pageCamera -= (BLOCK/15);//15 frames
            if( pageCamera<=pageY ){
              pageCamera = pageY;
            }
            heartY = 10-pageCamera;
         }
        
      }
      else{
        image( groundhogIdle,hogX,hogY );
      }

     
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				 //cabbage
          cabbageX=floor(random(0,8))*BLOCK;
          cabbageY= 160+floor(random(0,4))*BLOCK;
          
          //soldier
          randSoldier = floor(random(0,4));
          soldierY = SOLDIER_Y + randSoldier*80;
          soldierSpeed = floor(random( 1,3 )) ;
          
          gameState = GAME_RUN;
          newLife = false;
          
          //hog
          hogX = ROG_START_X;
          hogY = ROG_START_Y;
          
          //heartY
          heartY = 10;
          pageCamera = 0;
          camera = false;
          heartNum = 2;
          pageY=0;
          
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}






    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
    
    
}

void keyPressed(){
	// Add your moving input code here

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if( heartNum > 0) heartNum --;
  
      break;

      case 'd':
      if( heartNum > 0) heartNum ++;
      if( heartNum >= 5 ){
        heartNum = 5;
      }
      break;
       
    }
    
 if( gameState==GAME_RUN ){
   if( ! leftPressed && ! rightPressed && ! downPressed){ 
      switch( keyCode ){
        case LEFT:
          hogMoveX = hogX;
          if( hogX>0 ){
            leftPressed = true;
            hogX -= BLOCK;
          }
          break;
          
        case RIGHT:
          hogMoveX = hogX;
          if( hogX<560 ){
            rightPressed = true;
            hogX += BLOCK;
          }
          break;
          
          
          
        case DOWN:
          hogMoveY = hogY;
          if( pageCamera>-1921 ){
            downPressed = true;
            camera = true;
            //hog max
            if( hogY<2000 ){
              hogY += BLOCK;
            }
            pageY -= BLOCK; 
          }
          
          
          break;   
       }
    }
 }
}

void keyReleased(){
}
