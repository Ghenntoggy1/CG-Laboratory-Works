class Walker {
  PVector location;
  PVector time = new PVector();
 
  Walker(PVector location) {
    time.x = 0;
    time.y = 10000;
    
    this.location = location;
  }
  
  void step() {
    location.x = map(noise(time.x), 0, 1, 0, width);
    location.y = map(noise(time.y), 0, 1, 0, height);

    time.x += 0.01;
    time.y += 0.01;
  }
}
