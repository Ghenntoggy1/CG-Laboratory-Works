class Car {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector deceleration;
  float accelerationValue;
  float maxSpeed;
  float minSpeed;
  boolean isAccelerating;
  
  Car(float accelerationValue, PVector location) {
    this.location = location;
    velocity = new PVector(0, 0);
    this.accelerationValue = accelerationValue;
    acceleration = new PVector(0, this.accelerationValue);
    deceleration = new PVector(0, -this.accelerationValue);
    maxSpeed = 10;
    minSpeed = 0;
    isAccelerating = false;
  }
  
  void update() {
    if (keyPressed && ((key == CODED && keyCode == UP) || key == 'w')) {
      velocity.add(acceleration);
      velocity.limit(maxSpeed);      
    }
    else if (keyPressed && ((key == CODED && keyCode == DOWN) || key == 's')) {
      velocity.add(deceleration);
      if (velocity.mag() < 0.1) {
        velocity.limit(minSpeed);
      }
      else {
        velocity.limit(max(velocity.mag(), minSpeed));
      }
    }
    
    location.add(velocity);
  }
  
  void display() {
    fill(255, 0, 0);
    square(location.x, location.y, 25);
  }
  
  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    }
    else if (location.x < 0) {
      location.x = width;
    }
    
    if (location.y > height) {
      location.y = 0;
    }
    else if (location.y < 0) {
      location.y = height;
    }
  }
}
