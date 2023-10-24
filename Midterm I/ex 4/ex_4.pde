Walker[] walkers = new Walker[3]; // Create an array of Walkers to determine sheep positions
Sheep[] sheeps = new Sheep[3]; // Create an array to hold three sheep
PVector[] init = new PVector[3];

void setup() {
  size(500, 500);
  noFill();
  for (int i = 0; i < 3; i++) {
    init[i] = new PVector(width/2, height/2);
    walkers[i] = new Walker(init[i]);
    sheeps[i] = new Sheep(init[i], 2, walkers[i]);
  }
}

void draw() {
  background(51, 153, 255);

  // Update the positions of the walkers and move and display each sheep accordingly
  for (int i = 0; i < 3; i++) {
    sheeps[i].moveSheep();
  }
}
