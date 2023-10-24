// Laboratory Work 4
// Point A
// Student: Gusev Roman
// Group: FAF-222

// setting the sizes for both parts of the canvas
int width_window = 1000;
int height_window = 500;

// setting the random seed;
int seed = round(random(0, 1));

// setting values for randomGaussian
int sd = 160;
int mean = 0;

// setting values for Perlin Noise Generator
float noiseVal;
float noiseScale=0.05;

void setup() {
  size(1000, 1000);
  randomSeed(seed);
  fill(10);
  rect(0, 0, width_window, height_window);
  frameRate(200);
}

void draw() {
  stroke(lerpColor(color(255), color(255, 166, 0), random(0, 1)));
  int randomWeight = round(random(1, 3));
  strokeWeight(randomWeight);
  
  // left side of upper half randomGaussian sketch
  float x_loc = randomGaussian();
  x_loc = abs(x_loc * sd) + mean;
  x_loc = constrain(x_loc, 0, width_window/2);
  float shift = x_loc * 0.32;
  float y_loc = random(0 + shift, 500 - shift);
  point(width_window / 2 - x_loc, y_loc);
  
  // right side of upper half randomGaussian sketch;
  x_loc = randomGaussian();
  x_loc = abs(x_loc * sd) + mean;
  x_loc = constrain(x_loc, 0, width_window/2);
  shift = x_loc * 0.32;
  y_loc = random(0 + shift, 500 - shift);
  point(width_window / 2 + x_loc, y_loc);
  
  fill(0);
  stroke(0);
  rectMode(CENTER);
  rect(width_window/2 + 6, height_window + 25, 290, 30);
  textSize(20);
  fill(255);
  text("Press any key to draw Perlin Noise", width_window/2 - 135, height_window + 30);
  
  // lower half designed for Perlin Noise
  if (keyPressed) {
    drawPerlinNoise();
  }
}

void drawPerlinNoise() {
  noiseSeed(1); // You can change the seed value
  noiseDetail(round(random(1, 5)), 0.5); // Adjust these parameters to control the noise
  
  for (int x = 0; x < width; x++) {
    for (int y = height_window; y < height; y++) {
      float noiseVal = noise(x * noiseScale, y * noiseScale);
      float bright = map(noiseVal, 0, 1, 0, 255);
      stroke(bright, 100);
      point(x, y);
    }
  }
}
