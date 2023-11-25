class Food {
  PVector position;
  float oscillationRadius = 0.5;
  float oscillationSpeed = 0.05;
  float angle;
  
  Food() {
    position = new PVector(random(width), random(height));
    angle = random(TWO_PI);
  }

  void update() {
    // Oscillate the food position
    float xOffset = cos(angle) * oscillationRadius;
    float yOffset = sin(angle) * oscillationRadius;
    position.add(xOffset, yOffset);

    // Update the angle for the next frame
    angle += oscillationSpeed;

    // Optional: Wrap around the screen if the food goes out of bounds
    if (position.x > width) position.x = 0;
    if (position.x < 0) position.x = width;
    if (position.y > height) position.y = 0;
    if (position.y < 0) position.y = height;
  }

  void display() {
    update();
    fill(0, 255, 0);
    noStroke();
    ellipse(position.x, position.y, 10, 10);
  }
}
