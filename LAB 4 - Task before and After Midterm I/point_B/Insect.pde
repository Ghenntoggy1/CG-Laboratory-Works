class Insect {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxSpeed = 3;
  float maxForce = 0.1;
  float maxSize = 25;
  float size = 5;

  Insect() {
    position = new PVector(random(width), random(height));
    velocity = PVector.random2D();
    acceleration = new PVector(0, 0);
  }

  void update() {
    // Apply jittery behavior
    applyJitter();

    // Update position, velocity, and acceleration
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);

    // Reset acceleration
    acceleration.mult(0);

    // Keep the Insect within the canvas
    if (position.x > width) position.x = 0;
    if (position.x < 0) position.x = width;
    if (position.y > height) position.y = 0;
    if (position.y < 0) position.y = height;
  }

  void applyJitter() {
    // Apply random acceleration to simulate nervousness
    PVector jitter = PVector.random2D();
    jitter.mult(0.2); // Adjust jitteriness here
    acceleration.add(jitter);

    // Steer away from the mouse cursor
    PVector desired = PVector.sub(position, new PVector(mouseX, mouseY));
    float d = desired.mag();
    if (d < 100) {
      desired.setMag(map(d, 0, 100, 0, maxSpeed));
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxForce);
      acceleration.add(steer);
    }
  }

  void display() {
    // Display the Insect with wings
    stroke(0);
    fill(127, 127, 0);
    ellipse(position.x, position.y, size, size);

    // Draw wings
    fill(255, 255, 0);
    float wingLength = 5;
    float wingWidth = 2;
    pushMatrix();
    translate(position.x, position.y);
    rotate(velocity.heading());
    rect(-wingLength, -wingWidth, wingLength * 2, wingWidth * 2);
    popMatrix();
  }
  
  void eat() {
    size += 1;
  }
  
  boolean isMaxSize() {
    return size >= maxSize;
  }
  
  void moveTo(PVector target) {
    // Move towards the target
    PVector desired = PVector.sub(target, position);
    float d = desired.mag();
    if (d > 0) {
      desired.setMag(maxSpeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxForce);
      acceleration.add(steer);
    }
  }
}
