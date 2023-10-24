// Exercise 1.8
// Student: Gusev Roman
// Group: FAF-222

Mover mover;

void setup() {
  size(1000, 1000);
  background(255);
  mover = new Mover();
}

void draw() {
  background(255);
  mover.update();
  mover.display();
}
