class Predator extends Creature{
  PVector amplitude;
  PVector angle;
  float x1;
  float y1;

  Predator() {
    super(2, 0.1, 30, 15, 6, 1000, 200, 5, 2);
    amplitude = new PVector(random(16, 22),random(16, 22));
    angle = new PVector();
    x1 = random(5, 10);
    y1 = random(5, 10);
  }
  
  @Override
  void applyJitter() {
    PVector jitter = PVector.random2D();
    jitter.mult(0.2);
    // Apply jitter to acceleration
    acceleration.add(jitter);
  }
  
  @Override
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
    oscillate();
  }
  
  void oscillate() {
    angle.add(velocity);
  }

  @Override
  void display() {
    stroke(0);
    fill(255, 0, 0);
    ellipse(position.x, position.y, size, size);
    fill(0, 255, 0);
    pushMatrix();
    translate(position.x, position.y);
    popMatrix();
    rect(-wingLength, -wingWidth, wingLength * 2, wingWidth * 2);
    stroke(0);
    fill(255, 0, 0);
    ellipse(position.x, position.y, size, size);
    fill(0, 255, 0);
    float x = sin(constrain(x1 * 0.05, 5, 15)) * amplitude.x;
    float y = sin(frameCount * 0.05) * amplitude.y;    

    pushMatrix();
    translate(position.x, position.y);
    rotate(cos(x1 * 0.05));
    line(0, 0, x, y);
    rotate(cos(frameCount * 0.05));
    line(0, 0, -x, -y);
    popMatrix();
  }

  void attractTo(Creature insect) {
    if (insect != null) {
      PVector desired = PVector.sub(insect.position, position);
      desired.setMag(maxSpeed); // Set the desired speed
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxLimit); // You can adjust the limit for smoother turning
      // Apply attraction force to acceleration
      acceleration.add(steer);
    }
  }
  
  @Override
  void eat() {
    size += 1;
    mass += 1;
    maxSpeed -= 0.1;
    hunger = 0;
    wingLength += 0.2;
    amplitude.add(1,1);
  }
  
  void follow(float[][] flowField) {
    int i = floor(position.x / 20);
    int j = floor(position.y / 20);
    PVector force = PVector.fromAngle(flowField[i][j]);
    applyForce(force);
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
}
