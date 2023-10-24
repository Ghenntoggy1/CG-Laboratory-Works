/* Exercise 1.3 */
// Student: Gusev Roman
// Group: FAF-222

// Create Vectors for location and velocity
// of the box and size of the box
PVector location;
PVector velocity;
int sizeBox;

// Draw the canvas borders in 3D
void drawBorders() {
  stroke(0); // Set the stroke color to black
  
  // Lines along the edges of the canvas
  line(0, 0, 0, 0, 0, -width);
  line(width, 0, 0, width, 0, -width);
  line(width, height, 0, width, height, -width);
  line(0, height, 0, 0, height, -width);
  line(0, 0, -width, width, 0, -width);
  line(width, 0, -width, width, height, -width);
  line(width, height, -width, 0, height, -width);
  line(0, height, -width, 0, 0, -width);
}

void setup() {
  // Canvas size and background color
  size(400, 400, P3D);
  background(255);
  // Initialize Vectors for location
  // and velocity and size of the box
  sizeBox = 50;
  location = new PVector(random(sizeBox, width - sizeBox), random(sizeBox, height - sizeBox), random(-sizeBox, sizeBox - width ));
  velocity = new PVector(3, 1.1, 2);
  fill(color(random(0, 255), random(0, 255), random(0, 255)));
}

void draw() {
  // Reset the background every iteration
  background(255);
  drawBorders();
  
  // Move box in direction
  location.add(velocity);
  
  if ((location.x > width - sizeBox/2) || (location.x < 0 + sizeBox/2)) {
    velocity.x *= -1;
    fill(color(random(0, 255), random(0, 255), random(0, 255)));
  }
  if ((location.y > height - sizeBox/2) || (location.y < 0 + sizeBox/2)) {
    velocity.y *= -1;
    fill(random(0, 255), random(0, 255), random(0, 255));
  }
  if ((location.z < - height + sizeBox/2) || (location.z > -sizeBox/2)) {
    velocity.z *= -1;
    fill(random(0, 255), random(0, 255), random(0, 255));
  }
  
  rectMode(CENTER);
  translate(location.x, location.y, location.z);
  box(sizeBox);
}
