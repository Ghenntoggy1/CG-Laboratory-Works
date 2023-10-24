class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  
  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    maxSpeed = 10;
  }
  
  void update() {
    PVector mouseLocation = new PVector(mouseX, mouseY);
    PVector direction = PVector.sub(mouseLocation, location);
    // calculate distance from mouse to ball
    float distance = direction.mag();
    direction.normalize();
    
    // determine the force of the attraction based on
    // distance
    float strength = map(distance, 0, height, 1, 30);
    // divide by that force strength
    direction.div(strength);
    
    acceleration = direction;
    
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
  }
  
  void display() {
    stroke(0);
    fill(175);
    circle(location.x, location.y, 25);
    textSize(50);
    fill(0);
    text("Acceleration: " + acceleration.mag(), 50, 50);
  }
}
