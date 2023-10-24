// Laboratory Work 5
// Student: Gusev Roman
// Group: FAF-222

// Position of first sphere
int x_fs = 50;
int y_fs = 50;
int z_fs = -50;
// Auxiliary variables for movement first sphere
int direction_fs = -1;
int speed_fs = 2;
float speedAngle_fs = 0.01;
float angle_fs = 0;
// Colors for the first sphere
color startColor_fs = color(0, 100, 255);
color endColor_fs = color(100, 255, 0);

// Position of second sphere (on the ground)
int x_ss = 25;
int y_ss;
int z_ss;
// Auxiliary variables for movement first sphere
int directionX_ss = -1;
int directionY_ss = -1;
int directionZ_ss = -1;
int speedX_ss = 0;
int speedY_ss = -3;
int speedZ_ss = 0;
// Colors for the first sphere
color startColor_ss = color(0, 0, 255);
color endColor_ss = color(255, 100, 0);

// Position for the boxes
int[] boxSizes = {70, 90, 110, 130, 150, 130, 110, 90, 70}; // Sizes of the 5 boxes
int numBoxes = 9;
int centerX;
int centerY;
int centerZ;
 // Auxiliary variables for the boxes
float[] boxRotations = {0, 0, 0, 0, 0, 0, 0, 0, 0};
float rotationSpeed = 0.1;
float rotationDelay = 1;

Star s;
Box[] boxes = new Box[numBoxes];

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
  // create a canvas used for 3D graphics
  size(500, 500, P3D);
  
  y_ss = height - 25;
  z_ss = -width + 25;
  
  s = new Star();
  
  for (int i = 0; i < numBoxes; i++) {
    boxes[i] = new Box(boxSizes[i], startColor_ss, endColor_ss);  
  }
}

void draw() {
  // resetting the stroke weight
  strokeWeight(1);
  // resetting the background
  background(200);
  // parameter for light
  lights();
  
  // change the position of first sphere
  x_fs += speed_fs;
  y_fs += speed_fs;
  z_fs -= speed_fs;
  angle_fs += speedAngle_fs;
  
  // use function to draw borders of 
  drawBorders();
  
  // moving the sphere on the canvas
  if (z_fs <= -width + 50 && x_fs >= width - 50 && y_fs >= height - 50) {
    x_fs = width - 50;
    y_fs = height - 50;
    z_fs = -width + 50;
    speed_fs *= direction_fs;
    speedAngle_fs *= direction_fs;
  }
  else if (x_fs <= 50 && y_fs <= 50) {
    x_fs = 50;
    y_fs = 50;
    z_fs = -50;
    speed_fs *= direction_fs;
    speedAngle_fs *= direction_fs;
  }
  // Interpolate between startColor_fs and endColor_fs based on angle_fs
  float zColorAmount_fs = map(z_fs, -width + 50, -50, 0, 1);
  color currentColor_fs = lerpColor(startColor_fs, endColor_fs, zColorAmount_fs);
  
  float relPos = dist(x_fs, y_fs, z_fs, x_ss, y_ss, z_ss);
  
  // drawing first sphere
  pushMatrix();
  fill(currentColor_fs);
  translate(x_fs, y_fs, z_fs);
  rotateX(angle_fs);
  rotateY(angle_fs);
  rotateZ(angle_fs);
  sphereDetail(int(relPos / 32));
  sphere(70);
  popMatrix();
  
  // change the position of second sphere
  x_ss += speedX_ss;
  y_ss += speedY_ss;
  z_ss -= speedZ_ss;
  // moving the sphere on the canvas
  if (y_ss <= 25) {
    y_ss = 25;
    speedX_ss = 3;
    speedY_ss *= directionY_ss;
    speedZ_ss = 3 * directionZ_ss;
  }
  else if (x_ss >= width - 25 && y_ss >= height - 25 && z_ss >= -25) {
    x_ss = width - 25;
    y_ss = height - 25;
    z_ss = 25;
    speedX_ss *= directionX_ss;
    speedY_ss = 0;
    speedZ_ss *= directionZ_ss;
  }
  else if (x_ss < 25 || z_ss < - width - 25) {
    x_ss = 25;
    y_ss = height - 25;
    z_ss = -width + 25;
    speedX_ss = 0;
    speedY_ss = -3;
    speedZ_ss = 0;
  }
  
  // Interpolate between startColor_ss and endColor_ss based on zColorAmount_ss
  float zColorAmount_ss = map(y_ss, 0, height, 0, 1);
  color currentColor_ss = lerpColor(startColor_ss, endColor_ss, zColorAmount_ss);
  // drawing second sphere (on the ground)
  pushMatrix();
  fill(currentColor_ss);
  noStroke();
  translate(x_ss, y_ss, z_ss);
  sphere(25);
  popMatrix();
  
  // Draw an array of 9 boxes
  centerX = width / 2;
  centerY = 0;
  centerZ = -(width + 50) / 2;
  for (int i = 0; i < numBoxes; i++) {
    float boxColorAmount = map(i, 0, numBoxes - 1, 0, 1);
    color currentBoxColor = lerpColor(startColor_ss, endColor_ss, boxColorAmount);
    boxes[i].display(centerX, centerY, centerZ, currentBoxColor);
    // Add some space between boxes
    centerY += boxSizes[i] / 2 + 20;
  }
  
  s.display(s.centerStar());
}
