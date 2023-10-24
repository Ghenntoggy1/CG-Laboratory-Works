// Student: Gusev Roman
// Group: FAF-222
// Variant 4

// Variables
int rx;
int ry;
float x;
float y;

void setup() {
  // Setting the size of the canvas
  size(400, 400);
  
  // Setting the color for background
  background(200);
  
  // Variables initialization
  x = width / 2;
  y = height / 2;
  rx = 190;
  ry = 145;
  
  // Using rectMode with parameter CENTER, to use rect center x and y
  rectMode(CENTER);
  
  // Setting the width of the line to 2
  strokeWeight(2);
  
  // Drawing rect in center of the canvas
  fill(255, 204, 204);
  rect(x, y, 2 * rx, 2 * ry);
  
  // Drawing lines inside of rect
  line(x - rx, y - ry, x + rx, y + ry);
  line(x - rx, y + ry, x + rx, y - ry);
  line(x - rx, y, x + rx, y);
  line(x, y - ry, x, y + ry);
}

void draw() {
  // Setting the width of the arcs to 4
  strokeWeight(4);
  
  // a) Drawing an arc in III Quadrant
  
  noFill();  // setting empty design for arcs
  stroke(100, 100, 255);  // setting color of the arc
  arc(x, y, rx * 2, ry * 2, HALF_PI, PI);  // constructing the arc
  //stroke(0);  // setting color back to black
  
  // b) Drawing a chord (angle to start the chord in Quadrant IV and angle to
  //    end the chord in the middle of Quadrant I)
  
  stroke(255, 0 , 0);  // setting color of the chord
  arc(x, y, rx * 2, ry * 2, -QUARTER_PI, HALF_PI, CHORD);  // constructing the chord
  //stroke(0);  // setting color back to black
  
  // c) Drawing a Pie (angle to start the pie at the beginning of quadrant II
  //    and angle to end the pie is the middle of quadrant IV)
  
  stroke(255, 100, 100);  // setting color of the pie
  arc(x, y, rx * 2 - 50, ry * 2 - 50, QUARTER_PI, PI + HALF_PI, PIE);  // constructing the pie
  stroke(0);  // setting color back to black
}
