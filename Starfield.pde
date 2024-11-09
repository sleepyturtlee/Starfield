class Tree extends Particle {

  // as long as you make a constructor, if you don't initialize the vars in the
  // constructor, the subclass just uses the parent class initialization

  int startingX, startingY;
  float mySize;
  Tree() {
    myX = (Math.random()*30)+275;
    myY = 140;
    // spawn somewhere in the middle
    startingX = (int)(Math.random() * 50) + 275;
    startingY = 140;
    mySize = 1;

    if (startingX <= 300) {
      myAngle = radians(150);
    }
    if (startingX > 300) {
      myAngle = radians(30);
    }
    mySpeed = (Math.random()*10) + 5;
    myTint = 0;
  }

  void move() {
    myX += Math.cos(myAngle) * mySpeed;
    myY += Math.sin(myAngle) * mySpeed;
    myTint += 5;
    mySize ++;

    // make it so that if they go off screen, come back on screen and respawn
    // I don't want that many stars to respawn tho so I only do it for the few that
    // happen to go off in the range below
    if (myX > 1000 || myX < -400 || myY > 1000 || myY < -400) {
      myX = startingX;
      myY = startingY;
      myTint = 0;
      mySize = 1;
      if (startingX < 300) {
        myAngle = radians(150);
      }
      if (startingX > 300) {
        myAngle = radians(30);
      }
      mySpeed = (Math.random()*10) + 5;
    }
  }
  void show() {
    //    float trunkWidth = 5*3 + mySize;
    //float trunkHeight =  70*3 + mySize*3;
    float trunkWidth = 5*3 + mySize;
    float trunkHeight =  70*3 + mySize;
    if (trunkWidth > 20) {
      trunkWidth = 20;
    }

    fill(10, 10, 10, (float)myTint);
    noStroke();
    // trunk
    rect((float)myX - (trunkWidth)/2, (float)myY+5*3 -mySize, trunkWidth, trunkHeight);
    // leaves
    // new + improved
    triangle((float)myX, (float)myY - mySize*2, (float)myX-15*3 - mySize, (float)myY + 20*3 -mySize, (float)myX+15*3 +mySize, (float)myY + 20*3 - mySize);
    // mid leaf
    triangle((float)myX, (float)myY+20*3 -mySize, (float)myX-20*3 - mySize, (float)myY + (20+20)*3-mySize/2, (float)myX +20*3+mySize, (float)myY + (20+20)*3 -mySize/2);
    // bot leaf
    triangle((float)myX, (float)myY +40*3 -mySize/2, (float)myX-25*3 - mySize, (float)myY +(20+40)*3-mySize/3, (float)myX+25*3+mySize, (float)myY +(20+40)*3-mySize/3);
    
    // top leaf
    //triangle((float)myX, (float)myY, (float)myX-15*3 - mySize, (float)myY + 20*3 +mySize, (float)myX+15*3 +mySize, (float)myY + 20*3 +mySize);
    //// mid leaf
    //triangle((float)myX, (float)myY+20*3 +mySize, (float)myX-20*3 - mySize, (float)myY + (20+20)*3+mySize*2, (float)myX +20*3+mySize, (float)myY + (20+20)*3+mySize*2);
    //// bot leaf
    //triangle((float)myX, (float)myY +40*3 +mySize*2, (float)myX-25*3 - mySize, (float)myY +(20+40)*3+mySize*3, (float)myX+25*3+mySize, (float)myY +(20+40)*3+mySize*3);
    // prevent trunk width from getting too big
  }
} // end of tree class

class Particle {
  double myX, myY, myAngle, mySpeed, myTint;
  Particle() {
    myX = (Math.random()*50) + 275;
    myY = (Math.random()*50) + 225;
    myAngle = (Math.random()*(2*Math.PI));
    mySpeed = (Math.random()*10) + 5;
    myTint = (Math.random()*200 + 30);
  }

  void move() {
    myX += Math.cos(myAngle) * mySpeed;
    myY += Math.sin(myAngle) * mySpeed;

    // make it so that if they go off screen, come back on screen and respawn
    // I don't want that many stars to respawn tho so I only do it for the few that
    // happen to go off in the range below
    if (myX > 650 || myX < -50 || myY > 650 || myY < -50) {
      myX = (Math.random()*50) + 275;
      myY = (Math.random()*50) + 225;
      myAngle = (Math.random()*(2*Math.PI));
      mySpeed = (Math.random()*10) + 5;
    }
  }
  void show() {
    fill(255, 255, 255, (float)myTint);
    ellipse((float)myX, (float)myY, 2, 2);
  }
} // end of Particle class

Particle[] tahoe = new Particle[150];
Tree favTestTree = new Tree();
double countdown = 3;
double currentTime = second();
double previousTime = second();
float transition = 500;
void setup() {
  background(43, 66, 141);
  size(600, 600);
  for(int i = 0; i < tahoe.length; i++) {
    tahoe[i] = new Particle();
  }
  for(int i = 0; i < 100; i++) {
    tahoe[i] = new Tree();
  }
}

void draw() {
  background(#07062b);
  for(int i = 0; i < tahoe.length; i++) {
    tahoe[i].move();
    tahoe[i].show();
  }
  fill(10);
  quad(300+10, 350, 300-10, 350, 0-150, 600, 600+150, 600);
  //triangle(300, 350, 0 - 150, 600, 600 + 150, 600);
  fill(20);
  //quad(300+10, 350, 300-10, 350, 30, 600, 600-30, 600);
  triangle(300, 350, 30, 600, 600 - 30, 600);
  
  favTestTree.move();
  favTestTree.show();

  // car
   fill(5);
   // top of car
   rect(0, 0, 600, 80);
   // bot of car
   rect(0, 600 - 180, 600, 180);
   //sides of car: w = 30 px, l = 600
   rect(0 - 10, 0, 30 + 10, 600);
   rect(600 - 30, 0, 30 + 10, 600);
   // rear view mirror
   rect(300 - 30/2, 70, 30, 30);
   rect(300 - 200/2, 100, 200, 60);
   fill(#022933);
   rect(300 - 180/2, 100+10, 200-20, 60-20);
   
   // blackout 
   fill(0, 0, 0, transition);
   rect(0, 0, 600, 600);
   
   currentTime = millis();
   if(currentTime > previousTime) {
     transition -=5;
     previousTime = millis();
     
   }
   
   
   //// bobblehead
   //arc(500, 450, 100, 100, PI, TWO_PI);
   //fill(0, 255, 0);
   //ellipse(500-50, 450, 40, 40);
}
