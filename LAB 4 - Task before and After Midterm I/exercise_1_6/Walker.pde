class Walker {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  float accelerationX;
  float accelerationY;
  PVector time = new PVector();

  Walker(PVector location) {
    this.location = location;
    this.velocity = new PVector();
    this.acceleration = new PVector();
    this.maxSpeed = 5;  // Reduced max speed for smoother wrapping
    this.time.x = 0;
    this.time.y = 10000;
  }

  void step() {
    accelerationX = map(noise(time.x), 0, 1, -0.2, 0.2);
    accelerationY = map(noise(time.y), 0, 1, -0.2, 0.2);

    acceleration.set(accelerationX, accelerationY);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);

    time.x += 0.01;
    time.y += 0.01;

    // Wrap the walker to the opposite side if it goes out of bounds
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}
