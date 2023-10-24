// Exercise 1.7
// Student: Gusev Roman
// Group: FAF-222

PVector v;

void setup() {
  size(400, 400);
  background(255);
  v = new PVector(100, 125);
  rectMode(CENTER);
  translate(10, 10);
  line(0,0,v.x,v.y);
  
  PVector u = PVector.mult(v, 2);
  translate(15, 0);
  stroke(255, 0, 0);
  line(0, 0, u.x, u.y);
  
  PVector w = PVector.sub(v, u);
  translate(width/2, height/2);
  stroke(0, 255, 0);
  line(0, 0, w.x, w.y);
  
  w.div(3);
  translate(width/4, 0);
  stroke(0, 255, 100);
  line(0, 0, w.x, w.y);
}
