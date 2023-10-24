void setup () {
  // setting the size of the window
  size(540, 658);
}

void draw () {
  // Setting the size of the margins / frames (stroke) of the shapes
  stroke(80);
  strokeWeight(0.8);
  
  // Background style (fractured glass style)
  fill(0, 102, 51);
  quad(0, 0, 230, 0, 250, 300, 150, 210);
  fill(0, 51, 25);
  triangle(230, 0, 400, 0, 250, 300);
  fill(0, 102, 102);
  quad(400, 0, 540, 0, 540, 90, 250, 300);
  fill(0, 0, 255);
  quad(540, 90, 540, 250, 540, 400, 250, 300);
  fill(127, 0, 255);
  quad(250, 300, 540, 400, 540, 500, 400, 500);
  fill(153, 0, 153);
  quad(400, 500, 540, 500, 540, 658, 300, 658);
  fill(153, 0, 76);
  quad(250, 300, 400, 500, 300, 658, 210, 430);
  fill(255, 102, 102);
  quad(210, 430, 300, 658, 180, 658, 90, 500);
  fill(153, 0, 0);
  quad(90, 500, 180, 658, 0, 658, 0, 300);
  fill(255, 178, 102);
  quad(250, 300, 210, 430, 90, 500, 0, 300);
  fill(255, 153, 51);
  triangle(0, 0, 150, 210, 0, 300);
  fill(153, 153, 0);
  triangle(150, 210, 250, 300, 0, 300);
  
  // Body of the guitar
  fill(208, 69, 0);
  arc(308, 334, 100, 100, 3*PI/2 + 0.35, 5*PI/2 + 0.35);
  strokeWeight(0);
  quad(320, 315, 307, 355, 240, 330, 260, 285);
  arc(320, 312, 50, 50, PI - 0.4, 3*PI/2 + 0.35);
  circle(260, 295, 50);
  circle(245, 330, 50);
  arc(304, 358, 50, 50, PI/2, 2*PI);
  circle(285, 348, 15);
  circle(265, 340, 15);
  circle(285, 300, 15);
  circle(295, 302, 15);
  circle(275, 340, 15);
  
  // Fingerboard of the guitar
  strokeWeight(0.8);
  fill(255, 207, 9);
  quad(78, 235, 85, 216, 280, 309, 273, 327);
  
  // Nut of the fingerboard
  fill(230);
  quad(78, 235, 85, 216, 80, 213, 73, 233);
  
  // Headstock on the end of the guitar
  fill(255, 207, 9);
  quad(73, 233, 38, 200, 52, 200, 80, 213);
  
  // Tuners on the headstock
  fill(255);
  circle(71, 225, 5);
  circle(65, 220, 5);
  circle(57, 213, 5);
  circle(49, 206, 5);
  
  // Tuning pegs of the tuners
  fill(255);
  strokeWeight(3);
  line(67, 230, 62, 235);
  ellipse(62, 235, 5, 5);
  line(60, 224, 55, 229);
  ellipse(55, 229, 5, 5);
  line(53, 218, 48, 223);
  ellipse(48, 223, 5, 5);
  line(46, 208, 39, 214);
  ellipse(39, 214, 5, 5);

  // Frets on the fingerboard
  fill(255);
  strokeWeight(2);
  int x1 = 102;
  int y1 = 225;
  int x2 = 95;
  int y2 = 242;
  // iteration is used to place more lines in row
  for (int i = 0; i < 10; i++) {
    line(x1, y1, x2, y2);
    x1 += 19;
    y1 += 9;
    x2 += 19;
    y2 += 9;
  }
  
  // Bridge on the body of the guitar
  fill(255);
  quad(315, 320, 307, 340, 312, 354, 327, 314);
  
  // Neck Pickup on the body of the guitar
  fill(100);
  quad(295, 310, 300, 313, 290, 337, 286, 334);
  
  // Strunes attached to the Headstock and Bridge
  fill(0);
  strokeWeight(1.5);
  line(71, 225, 313, 339);
  strokeWeight(1.3);
  line(65, 220, 314, 336);
  strokeWeight(1.1);
  line(57, 213, 315, 333);
  strokeWeight(0.9);
  line(49, 206, 316, 330);
}
