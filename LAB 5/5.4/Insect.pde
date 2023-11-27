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
  
  @Override
  void update() {
    flock(insects);
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
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  void follow(float[][] flowField) {
    int i = floor(position.x / 20);
    int j = floor(position.y / 20);
    PVector force = PVector.fromAngle(flowField[i][j]);
    force.mult(0.1); // Adjust the flow field strength
    applyForce(force);
  }
  
  void flock(ArrayList<Insect> flock) {
    PVector alignment = new PVector(0, 0);
    PVector cohesion = new PVector(0, 0);
    PVector separation = new PVector(0, 0);
    int count = 0;

    for (Insect other : flock) {
      float d = PVector.dist(position, other.position);
      if (other != this && d < 50) {
        alignment.add(other.velocity);
        cohesion.add(other.position);
        PVector diff = PVector.sub(position, other.position);
        diff.div(d * d);
        separation.add(diff);
        count++;
      }
    }

    if (count > 0) {
      alignment.div(count);
      alignment.setMag(maxSpeed);
      alignment.sub(velocity);
      alignment.limit(maxLimit);

      cohesion.div(count);
      cohesion.sub(position);
      cohesion.setMag(maxSpeed);
      cohesion.sub(velocity);
      cohesion.limit(maxLimit);

      separation.div(count);
      separation.setMag(maxSpeed);
      separation.sub(velocity);
      separation.limit(maxLimit);
    }

    acceleration.add(alignment);
    acceleration.add(cohesion);
    acceleration.add(separation);
  }
}
