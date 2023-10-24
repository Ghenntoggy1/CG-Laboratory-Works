// Exercise 1.4
// Student: Gusev Roman
// Group: FAF-222

PVector car1Location;
PVector car2Location;
Car car1;
Car car2;

void setup() {
  size(200, 400);
  car1Location = new PVector(150, height/2);
  car2Location = new PVector(25, height/3);
  car1 = new Car(-0.01, car1Location);
  car2 = new Car(0.01, car2Location);
  fill(0);
  rect(80, 400, 400, 200);
}

void draw() {
  background(0);
  fill(255, 255, 0);
  rect(95, 0, 10, 400);
  car1.update();
  car1.checkEdges();
  car1.display();
  
  car2.update();
  car2.checkEdges();
  car2.display();
}
