class Creature {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  float maxLimit;
  float maxSize;
  float size;
  float mass;
  int hunger;
  int maxHunger;
  int timeWithoutFood;
  int maxTimeWithoutFood;
  float wingLength;
  float wingWidth;
  
  Creature(float maxSpeed, float maxLimit, float maxSize, float size,
           float mass, int maxHunger, int maxTimeWithoutFood,
           float wingLength, float wingWidth) {
    this.position = new PVector(random(width), random(height));
    this.velocity = PVector.random2D();
    this.acceleration = new PVector(0, 0);
    this.maxSpeed = maxSpeed;
    this.maxLimit = maxLimit;
    this.maxSize = maxSize;
    this.size = size;
    this.mass = mass;
    this.hunger = 0;
    this.maxHunger = maxHunger;
    this.timeWithoutFood = 0;
    this.maxTimeWithoutFood = maxTimeWithoutFood;
    this.wingLength = wingLength;
    this.wingWidth = wingWidth;
  }
  
  void update() {
    applyJitter();
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
    increaseHunger();
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
  
  void eat() {
    size += 1;
    mass += 1;
    maxSpeed -= 0.1;
    hunger = 0;
    wingLength += 0.2;
  }
  
  void increaseHunger() {
    hunger++;
    if (hunger >= maxHunger) {
      timeWithoutFood++;
      maxSpeed = 0.5;
    }
  }
  
  boolean isMaxSize() {
    return size >= maxSize;
  }
  
  boolean isDead() {
    return timeWithoutFood >= maxTimeWithoutFood;
  }
  
  void display() {}
}
