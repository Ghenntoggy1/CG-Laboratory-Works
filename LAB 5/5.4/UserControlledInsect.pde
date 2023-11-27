class UserControlledInsect extends Creature {
  int colorInsect;

  UserControlledInsect(int c) {
    super(4, 0.1, 10, 10, 1, 0, 0, 0, 0);
    colorInsect = c;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    fill(colorInsect);
    noStroke();
    ellipse(position.x, position.y, size, size);
  }

  void handleInput(int keyCode) {
    // Handle arrow key input to control the user-controlled insect
    float forceAmount = 0.1;
    if (keyCode == UP) {
      applyForce(new PVector(0, -forceAmount));
    } else if (keyCode == DOWN) {
      applyForce(new PVector(0, forceAmount));
    } else if (keyCode == LEFT) {
      applyForce(new PVector(-forceAmount, 0));
    } else if (keyCode == RIGHT) {
      applyForce(new PVector(forceAmount, 0));
    }
  }
}
