/* Exercise 1.1 */
// Student: Gusev Roman
// Group: FAF-222

// Create Vectors for location and velocity
// of the square and size of the square
PVector location;
PVector velocity;
int sizeSquare;

void setup() {
  // Canvas size and background color
  size(400, 400);
  background(255);
  // Initialize Vectors for location
  // and velocity and size of the ball
  sizeSquare = 25;
  location = new PVector(random(sizeSquare, width - sizeSquare), random(sizeSquare, height - sizeSquare));
  velocity = new PVector(3, 1.1);
}

void draw() {
  // Reset the background every iteration
  background(255);
  
  // Move ball in direction
  location.add(velocity);
  
  // If ball touches borders, reverse direction
  if ((location.x > width - sizeSquare/2) || (location.x < 0 + sizeSquare/2)) {
    velocity.x *= -1;
    fill(color(random(0, 255), random(0, 255), random(0, 255)));
  }
  if ((location.y > height - sizeSquare/2) || (location.y < 0 + sizeSquare/2)) {
    velocity.y *= -1;
    fill(random(0, 255), random(0, 255), random(0, 255));
  }
  
  rectMode(CENTER);
  square(location.x, location.y, sizeSquare);
}
