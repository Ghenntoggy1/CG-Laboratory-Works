class Predator {
  PVector position;
  PVector velocity;
  PVector acceleration; // Add acceleration
  float maxSpeed = 2; // Adjust the maximum speed as needed
  float maxLimit = 0.1; // Adjust the maximum force limit
  float size = 15;
  float mass = 6; // Adjust mass for predator
  int hunger = 0; // Initialize hunger level
  int maxHunger = 2000; // Set the maximum hunger level
  int timeWithoutFood = 0; // Initialize time without eating
  int maxTimeWithoutFood = 1000; // Set the maximum time without food (adjust as needed)
  int maxSize = 30;
  float wingLength = 5;
  float wingWidth = 2;

  Predator() {
    position = new PVector(random(width), random(height));
    velocity = PVector.random2D();
    acceleration = new PVector(0, 0);
  }

  void update() {
    applyJitter();
    // Apply acceleration to velocity
    velocity.add(acceleration);
    // Limit velocity to maximum speed
    velocity.limit(maxSpeed);
    // Update position based on velocity
    position.add(velocity);

    if (position.x > width) position.x = 0;
    if (position.x < 0) position.x = width;
    if (position.y > height) position.y = 0;
    if (position.y < 0) position.y = height;
    
    // Increment the hunger without food
    increaseHunger();

    // Reset acceleration at the beginning of each frame
    acceleration.set(0, 0);
  }

  void applyJitter() {
    PVector jitter = PVector.random2D();
    jitter.mult(0.2);
    // Apply jitter to acceleration
    acceleration.add(jitter);
  }

  void display() {
    stroke(0);
    fill(255, 0, 0);
    ellipse(position.x, position.y, size, size);
    fill(0, 255, 0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(velocity.heading());
    rect(-wingLength, -wingWidth, wingLength * 2, wingWidth * 2);
    popMatrix();
  }

  void attractTo(Insect insect) {
    PVector desired = PVector.sub(insect.position, position);
    desired.setMag(maxSpeed); // Set the desired speed
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxLimit); // You can adjust the limit for smoother turning
    // Apply attraction force to acceleration
    acceleration.add(steer);
  }

  // Check if the predator dies from hunger
  boolean isDead() {
    return timeWithoutFood >= maxTimeWithoutFood;
  }
  
  void eat() {
    size += 1;
    mass += 1;
    maxSpeed -= 0.1;
    hunger = 0;
    wingLength += 0.2;
  }
  
  void applyForce(PVector force) {
    // Adjust the force according to the predator's mass
    PVector f = force.copy();
    f.div(mass);
    acceleration.add(f);
  }
  
  PVector attract(Insect insect) {
    PVector force = PVector.sub(insect.position, position);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0);

    force.normalize();
    float strength = (mass * insect.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }
  
  // Implement a hunger mechanism
  void increaseHunger() {
    hunger++;
    if (hunger >= maxHunger) {
      // Predator is very hungry, slow it down
      timeWithoutFood++;
      maxSpeed = 0.5;
    }
  }
  
  boolean isMaxSize() {
    return size >= maxSize;
  }
}
