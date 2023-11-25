class Insect extends Creature{

  Insect() {
    super(3, 0.1, 25, 5, 1, 1000, 400, 5, 2);
  }

  @Override
  void display() {
    stroke(0);
    fill(127, 127, 0);
    ellipse(position.x, position.y, size, size);

    fill(255, 255, 0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(velocity.heading());
    rect(-wingLength, -wingWidth, wingLength * 2, wingWidth * 2);
    popMatrix();
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
