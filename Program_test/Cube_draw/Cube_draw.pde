 //<>//
//0W, 1Y, 2O, 3R, 4G, 5B



//Cube Rubiks = new Cube();
Cube rotated = new Cube();
void setup() {
  size(880, 670);
  //Rubiks.SETUP();
  //Rubiks.reset_CLK();
  rotated.SETUP();
  rotated.reset_CLK();
}

//0B, 1G, 2O, 3R, 4W, 5Y
void draw() {
  background(224, 237, 253);
  rotated.DrawCube(70);
}



void keyReleased() {
  rotated = rotated.command(str(key).toUpperCase());
}
