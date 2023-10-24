// Student: Gusev Roman
// Group: FAF-222
// Variant: 3
// Exercise 1, 2, 3:

// speed of sheep
float speed = 2;
// Array sheeps
Sheep[] sheeps;
// Number of sheeps
int numSheeps = 3;
// color of background;
color bgColor = color(51, 153, 255);

void drawBackground() {
  // sky
  background(bgColor);
  // land
  rectMode(CENTER);
  fill(0, 153, 0);
  circle(250, 1000, 1500);
}

void setup() {
  // setting the size of canvas and background
  size(500, 500);
  drawBackground();
  // instantiate array of Sheep objects
  sheeps = new Sheep[numSheeps];
  // create sheep object through iteration
  for (int i = 0; i < numSheeps; i++) {
    // create position for sheep
    PVector posSheep = new PVector(random(150, width - 150), random(300, height - 60));
    sheeps[i] = new Sheep(posSheep, speed);
  }
}

void draw() {
  drawBackground();
  // display sheeps
  for (int i = 0; i < numSheeps; i++) {
    sheeps[i].moveSheep();
  }
}
