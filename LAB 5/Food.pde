class Food {
  PVector position;

  Food() {
    position = new PVector(random(width), random(height));
  }

  void display() {
    fill(0, 255, 0);
    noStroke();
    ellipse(position.x, position.y, 10, 10);
  }
}
