class Box {
  float size;
  float rotation;
  color startColor;
  color endColor;

  Box(float size, color startColor, color endColor) {
    this.size = size;
    this.startColor = startColor;
    this.endColor = endColor;
    rotation = 0;
  }

  void display(float x, float y, float z, color currentBoxColor) {
    pushMatrix();
    fill(currentBoxColor);
    noFill();
    stroke(currentBoxColor);
    strokeWeight(2);
    translate(x, y, z);
    rotateY(rotation);

    box(size);
    popMatrix();

    rotation += rotationSpeed;
    if (rotation > TWO_PI) {
      rotation -= TWO_PI;
    }
  }
}
