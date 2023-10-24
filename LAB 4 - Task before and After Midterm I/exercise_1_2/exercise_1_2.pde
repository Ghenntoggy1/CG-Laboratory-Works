/* Exercise 1.2 */
// Student: Gusev Roman
// Group: FAF-222

// Convert Perlin Noise walker class 
// to using PVectors
Walker walker;
PVector locationBall = new PVector();

void setup() {
  size(500, 500);
  walker = new Walker(locationBall);
}

void draw() {
  background(255);
  walker.step();
  fill(255, 0, 0);
  circle(locationBall.x, locationBall.y, 25);
}
