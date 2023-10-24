// Exercise 1.4
// Student: Gusev Roman
// Group: FAF-222

Mover mover;

void setup() {
  size(400, 400);
  mover = new Mover();
}

void draw() {
  background(255);
  mover.update();
  mover.checkEdges();
  mover.display();
  System.out.println(mover.velocity);
}
