// Laboratory Work 5
// Point 2
// Student: Gusev Roman
// Group: FAF-222

ArrayList<Insect> insects = new ArrayList<Insect>();
ArrayList<Food> foods = new ArrayList<Food>();
ArrayList<Predator> predators = new ArrayList<Predator>();
int numInsects = 5;
int numPredators = 5;

void setup() {
  size(1000, 1000);
  
  for (int i = 0; i < numInsects; i++) {
    insects.add(new Insect());
  }
  
  for (int i = 0; i < numPredators; i++) {
    predators.add(new Predator());
  }
}

void draw() {
  background(220);
  
  for (Predator predator : predators) {
    PVector totalAttraction = new PVector(0, 0);
    
    for (Insect insect : insects) {
      PVector force = predator.attract(insect);
      totalAttraction.add(force);
    }
    
    predator.applyForce(totalAttraction);
    predator.update();
    predator.display();
  }

  // Create new food occasionally
  if (random(1) < 0.1) {
    foods.add(new Food());
  }

  // Update and display food
  for (Food food : foods) {
    food.display();
  }

  // Update and display insects
  for (int i = insects.size() - 1; i >= 0; i--) {
    Insect insect = insects.get(i);
    insect.update();
    insect.display();

    // Check for collision with food
    for (int j = foods.size() - 1; j >= 0; j--) {
      Food food = foods.get(j);
      if (insect.position.dist(food.position) < 10) {
        foods.remove(j); // Remove the food
        insect.eat();
      }
    }

    // Check if the insect has reached maximum size
    if (insect.isMaxSize()) {
      insects.remove(i); // Remove the insect
    }
  }

  // Randomly create new insects
  if (random(1) < 0.035) {
    insects.add(new Insect());
  }
  
  // Randomly create new predators
  if (random(1) < 0.002) {
    predators.add(new Predator());
  }
  
  
  // Update and display predators
  for (Predator predator : predators) {
    predator.update();
    predator.display();

    // Find the nearest insect and attract the predator to it
    if (!insects.isEmpty()) {
      Insect nearestInsect = findNearestInsect(predator.position);
      predator.attractTo(nearestInsect);
    }

    // Check for collision with insect
    for (int j = insects.size() - 1; j >= 0; j--) {
      Insect insect = insects.get(j);
      if (predator.position.dist(insect.position) < 10) {
        insects.remove(j); // Remove the insect
        predator.eat();
      }
    }
    
    // Check for collision with food
    for (int j = insects.size() - 1; j >= 0; j--) {
      Insect insect = insects.get(j);
      if (predator.position.dist(insect.position) < 10) {
        insects.remove(j); // Remove the insect
        predator.eat();
      }
    }

    // Make insects repel from the predator
    for (Insect insect : insects) {
      insect.repelFrom(predator);
    }
    
    // Check if the predator has reached maximum size
    if (predator.isMaxSize()) {
      predators.remove(predator); // Remove the predator
    }
  }

  for (int i = 0; i < predators.size(); i++) {
    if (predators.get(i).isDead()) {
      predators.remove(i);
    }
  }

  textSize(25);
  fill(0);
  text("Number of Insects: " + insects.size(), 50, 50);
  text("Number of Predators: " + predators.size(), 50, 80);
}

Food findNearestFood(PVector insectPosition) {
  Food nearestFood = null;
  float minDistance = Float.MAX_VALUE;
  
  for (Food food : foods) {
    float distance = insectPosition.dist(food.position);
    if (distance < minDistance) {
      minDistance = distance;
      nearestFood = food;
    }
  }
  
  return nearestFood;
}

Insect findNearestInsect(PVector predatorPosition) {
  Insect nearestInsect = null;
  float minDistance = Float.MAX_VALUE;

  for (Insect insect : insects) {
    float distance = predatorPosition.dist(insect.position);
    if (distance < minDistance) {
      minDistance = distance;
      nearestInsect = insect;
    }
  }

  return nearestInsect;
}
