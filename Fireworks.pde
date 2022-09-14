
ArrayList<Explosion> explosion;//the explosion phase of the program
ArrayList<Rocket> rocket;// the launching phase of the program

void setup(){
  size(1000,700);
explosion = new ArrayList<Explosion>(); //Create the lists
rocket = new ArrayList<Rocket>();
}

void draw(){
background(0);
launch();
setRocket();
explode();
}

float f = 80;

void setRocket(){ //add rockets every 80 frames
if((frameCount % f ) == 0){
rocket.add(new Rocket());
}

if(mousePressed){//If mouse is pressed, launch the rockets at the same time
 f = f/4;
}

else{//If mouse is not pressed, keep the framecount to the same value
f = 80;
}

}


void launch(){ //launch the rockets and explode when they reach desired height
for(int r = 0; r < rocket.size(); r++){
Rocket roc = rocket.get(r);
roc.draw();
if(roc.reached()){//when they reach desired height
explosion.add(new Explosion(roc.getX(),roc.getY(),roc.getColor()));// add new explosion
rocket.remove(r);// remove the rocket once they have exploded
}
}
}

void explode(){ //the particles from the explosion disappear after a while
for(int e = 0; e < explosion.size(); e++){
Explosion ex = explosion.get(e);

ex.draw();
if(ex.over()){ 
explosion.remove(e); //remove the particles 
}
}

}

class Explosion{ //Explosion phase of fireworks

ArrayList<Particles> particle; // set all variables
float x,y,xa,ya,dis,fin;
float vy;
float G;
float j;
float r;
float k;

color col;

Explosion(float xx, float yy, color c){
particle = new ArrayList<Particles>();
x = xx;
y = yy;
col = c;
dis = 0; // starting point of particles
fin = 100; // ending distance of particles
G = 0.00005; //force of gravity pulling down on the particles
r = random(0,100); // random factor is used to create elliptical shapes from the explosions
k = random(0,100);
}

void draw(){
float gravity = 0.01; //value that increases the lifespan of the particles before they they get pulled by gravity
for(int a = 0; a < 720; a += 24){ //dictates how far the particles travel before they disappear
xa = sin(radians(r*a))*dis; //
xa = 2*xa; //horizontal speed of particles
ya = cos(radians(k*a))*dis+gravity; //
ya = 2*ya; //vertical speed of particles
particle.add(new Particles(x+xa,y+ya,col));
y += vy;
vy += G; //the force of gravity increases when vy increases
}
for(int p = 0; p < particle.size(); p ++){
Particles part = particle.get(p);
part.draw();
particle.remove(p);
if (mousePressed){ //when the mouse is pressed, it adds more particles
p = 30;
}
else{ //when the mouse is not pressed, the number of particles stays the same as usual
p = 0;
}
}

dis++;// distance continues to increase
}

boolean over(){
return dis > fin;
}

}
class Particles{ //Particles from the explosion

float x,y,dia,dis; 
color c;
float my; //vertical speed of particles
float a; //the transparency value that allows the particles to glitter once the rocket has exploded

Particles(float xx, float yy, color col){
x = xx;
y = yy;
dia = random(0,10); //randomize the size of the particles from the explosion
my = 100;
c = col;
dis = 5;
a = random(-1000,1000);
}

void draw(){
noStroke();
fill(c,a);
ellipse(x,y,dia,dia);
}

float getDist(){
return dis;
}

}
class Rocket{ //the launch sequence

color c;
float dia, x,y, endy, r, g, b;

Rocket(){
dia = 10; //the diameter of the rockets stay constants
x = random(width);
y = height;
endy = random(50,500); //allows the rockets to explode at different elevations
r = random(120,250); // allows rockets to explode with different colours
g = random(120,250);
b = random(120,250);
c = color(r,g,b); // randomizes colour of rocket
}


void draw(){
noStroke();
fill(c);
ellipse(x,y,dia,dia);
y -= 10; // the vertical speed in which the rocket travels


}


float getX(){
return x; 
}
float getY(){
return y;
}
float getEnd(){
return endy;
}
color getColor(){
return c;
}

boolean reached(){
return y < endy; //if the rocket reaches desired height, then disappear
}
}
