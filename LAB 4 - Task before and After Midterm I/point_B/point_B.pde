ArrayList<Insect> insects = new ArrayList<Insect>();
ArrayList<Food> foods = new ArrayList<Food>();
int numInsects = 5;

void setup() {
  size(1000, 1000);
  
  for (int i = 0; i < numInsects; i++) {
    insects.add(new Insect());
  }
}

void draw() {
  background(220);

  // Create new food occasionally
  if (random(1) < 0.2) {
    foods.add(new Food());
  }
  
  // Update and display food
  for (Food food : foods) {
    food.display();
  }

  // Update and display insects
  for (int i = insects.size() - 1; i >= 0; i--) {
    Insect Insect = insects.get(i);
    Insect.update();
    Insect.display();
    
    // Check for collision with food
    for (int j = foods.size() - 1; j >= 0; j--) {
      Food food = foods.get(j);
      if (Insect.position.dist(food.position) < 10) {
        foods.remove(j); // Remove the food
        Insect.eat();
      }
    }
    
    // Check if the Insect has reached maximum size
    if (Insect.isMaxSize()) {
      insects.remove(i); // Remove the Insect
    }
    
    // Check for the nearest food and move towards it
    if (!foods.isEmpty()) {
      Food nearestFood = findNearestFood(Insect.position);
      Insect.moveTo(nearestFood.position);
    }
  }
  
  // Randomly create new flies
    if (random(1) < 0.015) { // Adjust the probability for new fly appearance
      insects.add(new Insect());
    }
  
  textSize(25);
  fill(0);
  text("Number of Insects: " + insects.size(), 50, 50);
}

Food findNearestFood(PVector InsectPosition) {
  Food nearestFood = null;
  float minDistance = Float.MAX_VALUE;
  
  for (Food food : foods) {
    float distance = InsectPosition.dist(food.position);
    if (distance < minDistance) {
      minDistance = distance;
      nearestFood = food;
    }
  }
  
  return nearestFood;
}
