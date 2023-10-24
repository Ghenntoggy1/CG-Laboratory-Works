// Exercise 1.6
// Student: Gusev Roman
// Group: FAF-222

Walker walker;
PVector locationBall = new PVector(500, 355);

void setup() {
  size(400, 500);
  walker = new Walker(locationBall);
  //frameRate(10);
}

void draw() {
  background(255);
  walker.step();
  fill(255, 0, 0);
  circle(walker.location.x, walker.location.y, 25);
}
