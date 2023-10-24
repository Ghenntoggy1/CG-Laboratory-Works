// Trajectory of Moon and Sun
float horizontalTraj = 400;
float verticalTraj = 250;

// Position on unit circle of Sun and Moon (initial)
float sunAngle = 0;
float moonAngle = PI;

// Color of Day and Night
color dayColor = color(0, 155, 255);
color nightColor = color(0, 15, 15);

// Color of the grass
color dayGrass = color(0, 153, 0);
color nightGrass = color(7, 53, 30);

// Color of the tree
color dayTree = color(196, 92, 0);
color nightTree = color(67, 33, 0);

// Color of the rope
color ropeDay = color(131, 71, 19);
color ropeNight = color(71, 39, 11);

// Position on canvas of Sun and Moon
float sunX;
float sunY;
float moonX;
float moonY;

// Position of the rope
float ropeNum1InitX = 525;
float ropeNum1InitY = 265;
float ropeNum1EndX;
float ropeNum1EndY;
float ropeNum2X = ropeNum1InitX + 15;
float ropeNum2Y = ropeNum1InitY - 5;
float ropeNum2EndX;
float ropeNum2EndY;

// Swing variables
float ropeLength = 100;
float ropeAmplitude = 20;
float ropeFrequency = 0.01;
float ropeAngle = 0;
boolean swinging = true;
int direction = 1;

// Function that add Stars during Night
void drawStars(float aux) {
  if (aux > 0.5) {
    for (int i = 0; i < 15; i++) {
      float starX = random(0, width);
      float starY = random(0, 299);
      float starSize = random(2, 4);
      strokeWeight(starSize);
      stroke(255);
      point(starX, starY);
    }
  }
  else if (aux >= 0.3 && aux <= 0.5) {
    for (int i = 0; i < 4; i++) {
      float starX = random(0, width);
      float starY = random(0, 299);
      float starSize = random(2, 4);
      strokeWeight(starSize);
      stroke(255);
      point(starX, starY);
    }  
  }
  strokeWeight(1);
  stroke(0);  
}

// Function to draw a tree in the field
void drawTree(float aux, color grassColor) {
  color treeColor = lerpColor(dayTree, nightTree, aux);
  fill(treeColor);
  noStroke();
  
  // Tree body
  quad(420, 400, 440, 320, 490, 320, 510, 400);
  quad(440, 350, 440, 210, 490, 210, 490, 350);
  
  // Tree branches
  quad(490, 260, 565, 240, 580, 255, 490, 280);
  quad(565, 240, 590, 210, 610, 210, 580, 255);
  quad(440, 300, 380, 280, 365, 295, 440, 320);
  quad(380, 280, 355, 260, 335, 260, 365, 295);
  
  // Leaves
  fill(grassColor);
  ellipseMode(CENTER);
  stroke(0);
  ellipse(465, 180, 140, 130);
  ellipse(600, 230, 90, 80);
  ellipse(345, 280, 90, 80);
  
  // Function to draw the Swing
  drawSwing(aux);
  
  // Reset stroke color and strokeWeight
  stroke(0);
  strokeWeight(1);
}

// Function to draw the Swing on the branch
void drawSwing(float aux) {
  strokeWeight(3);
  color swingColor = lerpColor(ropeDay, ropeNight, aux);
  stroke(swingColor);
  
  if (swinging) {
    // Calculate where Rope ends
    ropeNum1EndX = ropeNum1InitX + ropeLength * sin(ropeAngle);
    ropeNum1EndY = ropeNum1InitY + ropeLength * cos(ropeAngle) - 15;
    ropeNum2EndX = ropeNum2X + ropeLength * sin(ropeAngle);
    ropeNum2EndY = ropeNum2Y + ropeLength * cos(ropeAngle);
    
    // Draw the rope
    line(ropeNum1InitX, ropeNum1InitY, ropeNum1EndX, ropeNum1EndY);
    line(ropeNum2X, ropeNum2Y, ropeNum2EndX, ropeNum2EndY);
    
    // Draw the plank
    fill(swingColor); // Use the same color as the rope
    noStroke();
    rect(ropeNum1EndX - 20, ropeNum1EndY, 50, 20);
    
    // Update the rope angle for swinging motion
    ropeAngle += ropeFrequency * direction;
    
    // Reverse the swing direction when reaching 15 degrees
    if (ropeAngle >= radians(15) || ropeAngle <= -radians(15)) {
      direction *= -1;
    }
  }
}

void setup() {
  // Setting up the sizes of canvas
  size(800, 600);
}

void draw() {
  // Sun and Moon position being calculated
  sunX = width / 2 + horizontalTraj * cos(sunAngle);
  sunY = height / 2 + verticalTraj * sin(sunAngle);
  moonX = width / 2 + horizontalTraj * cos(moonAngle);
  moonY = height / 2 + verticalTraj * sin(moonAngle);
  
  // Changing the color of sky based on position of Sun and Moon
  float aux = map(sunY, height / 2 - verticalTraj, height / 2 + verticalTraj, 0, 1);
  color bgColor = lerpColor(dayColor, nightColor, aux);
  background(bgColor);
  
  // Sun
  fill(255, 255, 0);
  ellipse(sunX, sunY, 50, 50);
  
  // Function drawStars()
  drawStars(aux);
  
  // Moon
  fill(180);
  ellipse(moonX, moonY, 50, 50);
  
  // Changing the color of grass based on positions of Sun and Moon
  color grassColor = lerpColor(dayGrass, nightGrass, aux);
  
  // Horizon
  fill(grassColor);
  rect(0, 300, 800, 350);
  
  // Updating the angles for motion on the trajectory (speed of Sun and Moon)
  sunAngle += radians(1);
  moonAngle += radians(1);
  
  // Drawing a tree in the field
  drawTree(aux, grassColor);
}
