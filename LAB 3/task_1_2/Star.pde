PShape shape;
PVector center;

class Star {
  Star() {
    shape = createShape();
    shape.beginShape();
    shape.fill(0, 0, 255);
    shape.vertex(0, 36);
    shape.vertex(24, 36);
    shape.vertex(36, 12);
    shape.vertex(48, 36);
    shape.vertex(72, 36);
    shape.vertex(52, 54);
    shape.vertex(60, 78);
    shape.vertex(36, 64);
    shape.vertex(12, 78);
    shape.vertex(20, 54);
    shape.endShape(CLOSE);
    
    center = centerStar();
  }

  PVector centerStar() {
    center = new PVector();
    for (int i = 0; i < shape.getVertexCount(); i++) {
      PVector v = shape.getVertex(i);
      center.add(v);
    }
    center.div(shape.getVertexCount());
    
    return center;
  }

  void display(PVector shapeCenter) {
    pushMatrix();
    translate(width / 2, height / 2 + 40, -width / 2);
    rotateY(frameCount * 0.05);
    translate(-shapeCenter.x, -shapeCenter.y, -shapeCenter.z); // Translate to the center of the shape
    shape(shape);
    popMatrix();
  }
}
