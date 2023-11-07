class Insect {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxSpeed = 3;
  float maxLimit = 0.1;
  float maxSize = 25;
  float size = 5;
  float mass = 1; // Mass of the insect

  Insect() {
    position = new PVector(random(width), random(height));
    velocity = PVector.random2D();
    acceleration = new PVector(0, 0);
  }

  void update() {
    applyJitter();
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);

    if (position.x > width) position.x = 0;
    if (position.x < 0) position.x = width;
    if (position.y > height) position.y = 0;
    if (position.y < 0) position.y = height;
  }

  void applyJitter() {
    PVector jitter = PVector.random2D();
    jitter.mult(0.2);
    acceleration.add(jitter);

    PVector desired = PVector.sub(position, new PVector(mouseX, mouseY));
    float d = desired.mag();
    if (d < 100) {
      desired.setMag(map(d, 0, 100, 0, maxSpeed));
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxLimit);
      acceleration.add(steer);
    }
  }

  void display() {
    stroke(0);
    fill(127, 127, 0);
    ellipse(position.x, position.y, size, size);

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
    mass += 2;
    maxSpeed -= 0.1;
    
  }
  
  boolean isMaxSize() {
    return size >= maxSize;
  }
  
  void repelFrom(Predator predator) {
    PVector desired = PVector.sub(position, predator.position);
    float d = desired.mag();
    if (d < 100) { // Adjust the repulsion range
      desired.setMag(map(d, 0, 100, 0, maxSpeed));
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxLimit);
      acceleration.add(steer);
    }
  }
}
