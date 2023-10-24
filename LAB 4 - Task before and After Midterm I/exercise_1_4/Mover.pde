class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  
  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(-0.001, 0.01);
    maxSpeed = 10;
  }
  
  void limit(float maxSpeed) {
    if (this.acceleration.mag() > maxSpeed) {
      this.acceleration.normalize();
      this.acceleration.mult(maxSpeed);
    }
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
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
