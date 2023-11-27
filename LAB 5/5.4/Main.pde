// Laboratory Work 5
// Point 3
// Student: Gusev Roman
// Group: FAF-222

import java.util.Iterator;

ArrayList<Insect> insects = new ArrayList<Insect>();
ArrayList<Particle> foods = new ArrayList<Particle>();
ArrayList<Predator> predators = new ArrayList<Predator>();
ArrayList<UserControlledInsect> userInsects = new ArrayList<UserControlledInsect>();
int numInsects = 50;
int numPredators = 5;
int cols;
int rows;
float[][] flowField;
float flowScale = 0.1; // Adjust the scale to control the strength of the flow
boolean isUserDead = false;

void setup() {
  size(1000, 1000);
  
  for (int i = 0; i < numInsects; i++) {
    insects.add(new Insect());
  }
  
  for (int i = 0; i < numPredators; i++) {
    predators.add(new Predator());
  }
  // Adjust the resolution of the flow field
  cols = width / 20;  
  rows = height / 20;
  
  // Initialize flow field
  flowField = new float[cols][rows];
  
  // Populate flow field with random vectors
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float angle = random(TWO_PI);
      flowField[i][j] = angle;
    }
  }
  
  userInsects.add(new UserControlledInsect(color(0, 102, 255)));
}

void draw() {
  background(220);
  
  for (Predator predator : predators) {
    predator.update();
    predator.display();
  }

  // Create new food occasionally
  if (random(1) < 0.1) {
    foods.add(new Particle());
  }

  // Update and display food
  for (Particle food : foods) {
    food.display();
  }

  // Update and display insects
  Iterator<Insect> insectIterator = insects.iterator();
  while (insectIterator.hasNext()) {
    Insect insect = insectIterator.next();
    insect.update();
    insect.display();
    insect.flock(insects);
  
    // Check for collision with food
    Iterator<Particle> foodIterator = foods.iterator();
    while (foodIterator.hasNext()) {
      Particle food = foodIterator.next();
      if (insect.position.dist(food.position) < 10) {
        foodIterator.remove(); // Use iterator to remove the food
        insect.eat();
      }
    }
  
    // Check if the insect has reached maximum size
    if (insect.isMaxSize()) {
      insectIterator.remove(); // Use iterator to remove the insect
    }
  }

  // Randomly create new insects
  if (random(1) < 0.035) {
    insects.add(new Insect());
  }
  
  // Randomly create new predators
  if (random(1) < 0.009) {
    predators.add(new Predator());
  }
  
  
  // Update and display predators
  Iterator<Predator> predatorIterator = predators.iterator();
  while (predatorIterator.hasNext()) {
    Predator predator = predatorIterator.next();
    predator.update();
    predator.display();
  
    // Find the nearest insect and attract the predator to it
    if (!insects.isEmpty()) {
      Creature nearestInsect = findNearestInsect(predator.position);
      predator.attractTo(nearestInsect);
    }
  
    if (!userInsects.isEmpty()) {
      Creature nearestInsect = findNearestInsect(predator.position);
      predator.attractTo(nearestInsect);
    }
  
    // Check for collision with insect
    insectIterator = insects.iterator();
    while (insectIterator.hasNext()) {
      Insect insect = insectIterator.next();
      if (predator.position.dist(insect.position) < 10) {
        insectIterator.remove(); // Use iterator to remove the insect
        predator.eat();
      }
    }
    
    // Check for collision with insect
    Iterator<UserControlledInsect> ucInsectIterator = userInsects.iterator();
    while (ucInsectIterator.hasNext()) {
      UserControlledInsect usInsect = ucInsectIterator.next();
      if (predator.position.dist(usInsect.position) < 10) {
        ucInsectIterator.remove(); // Use iterator to remove the insect
        predator.eat();
        isUserDead = true;
      }
    }
  
    // Make insects repel from the predator
    for (Insect insect : insects) {
      insect.repelFrom(predator);
    }
  
    // Check if the predator has reached maximum size
    if (predator.isMaxSize()) {
      predatorIterator.remove(); // Use iterator to remove the predator
    }
  }

  for (int i = 0; i < predators.size(); i++) {
    if (predators.get(i).isDead()) {
      predators.remove(i);
    }
  }
  
  for (int i = 0; i < insects.size(); i++) {
    if (insects.get(i).isDead()) {
      insects.remove(i);
    }
  }
  
  for (UserControlledInsect userInsect : userInsects) {
    userInsect.update();
    userInsect.display();
  }
  
  textSize(25);
  fill(0);
  text("Number of Insects: " + insects.size(), 50, 50);
  text("Number of Predators: " + predators.size(), 50, 80);
  
  if (isUserDead) {
    textSize(100);
    fill(255, 0, 0);
    text("YOU LOST!", width/2, height/2);
  }
}

Particle findNearestParticle(PVector insectPosition) {
  Particle nearestParticle = null;
  float minDistance = Float.MAX_VALUE;
  
  for (Particle food : foods) {
    float distance = insectPosition.dist(food.position);
    if (distance < minDistance) {
      minDistance = distance;
      nearestParticle = food;
    }
  }
  
  return nearestParticle;
}

Creature findNearestInsect(PVector predatorPosition) {
  Creature nearestInsect = null;
  float minDistance = Float.MAX_VALUE;

  // Check distances from regular insects
  for (Insect insect : insects) {
    float distance = predatorPosition.dist(insect.position);
    if (distance < minDistance) {
      minDistance = distance;
      nearestInsect = insect;
    }
  }

  // Check distances from user-controlled insects
  for (UserControlledInsect ucInsect : userInsects) {
    float distanceUser = predatorPosition.dist(ucInsect.position);
    if (distanceUser < minDistance) {
      minDistance = distanceUser;
      nearestInsect = ucInsect; // Reset nearestInsect for user-controlled insect
    }
  }

  return nearestInsect;
}

void keyPressed() {
  // Handle user input to control the user-controlled insect
  for (UserControlledInsect userInsect : userInsects) {
    userInsect.handleInput(keyCode);
  }
}
