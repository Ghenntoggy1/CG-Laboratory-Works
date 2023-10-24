class Sheep {
  // location of sheep
  PVector loc;
  // speed of sheep
  float speed;
  
  // initialize parameters for location and speed
  Sheep(PVector loc, float speed) {
    this.loc = loc;
    this.speed = speed;
  }
  
  void drawSheep() {
  // back legs
  fill(255);
  rect(loc.x - 40, loc.y + 45, 20, 45, 0, 0, 15, 15);
  rect(loc.x + 45, loc.y + 45, 20, 45, 0, 0, 15, 15);
  
  // body
  fill(255);
  rect(loc.x, loc.y, 150, 100, 100);
  
  // head
  rect(loc.x + 55, loc.y - 50, 65, 50, 25);
  
  // horns
  fill(150);
  quad(loc.x + 40, loc.y - 70, loc.x + 30, loc.y - 90, loc.x + 50, loc.y - 70, loc.x + 50, loc.y - 70);
  quad(loc.x + 80, loc.y - 70, loc.x + 80, loc.y - 90, loc.x + 70, loc.y - 70, loc.x + 70, loc.y - 70);

  // eyes
  fill(51, 153, 255);
  rect(loc.x + 50, loc.y - 60, 15, 15, 25);
  rect(loc.x + 70, loc.y - 60, 15, 15, 25);
  
  // mouth
  fill(255, 51, 255);
  arc(loc.x + 60, loc.y - 40, 30, 20, 0, PI);
  
  // tail
  fill(255);
  arc(loc.x - 68, loc.y - 10, 40, 35, PI, 3 * PI/2 + radians(5), CHORD);
  
  // visible legs
  rect(loc.x - 50, loc.y + 50, 20, 45, 0, 0, 15, 15);
  rect(loc.x + 30, loc.y + 50, 20, 45, 0, 0, 15, 15);
  
  }
  
  // move sheep on canvas
  void moveSheep() {
    loc.x += speed;
    if (loc.x >= width - 100 || loc.x <= 100) {
      speed *= -1;
    }
    drawSheep();
  }
}
