class Walker {
  PVector loc;

  float tx,ty;

  Walker(PVector loc) {
    this.loc = loc;
    tx = 0;
    ty = 10000;
  }

  void step() {
    loc.x = map(noise(tx), 0, 1, 0, width);
    loc.y = map(noise(ty), 0, 1, 0, height);

    tx += 0.01;
    ty += 0.01;

  }
}
