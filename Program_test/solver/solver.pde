Cube rotated = new Cube(); //<>// //<>//
Cube Rubiks = new Cube();
String rotation[]  = {"L", "R", "F", "B", "U", "D"};
Cube cube[][] = new Cube[6][577000];
int Cube_Enable_Num[]  = new int [6];  //5 mean Depth.
int Braching_Factor = 6;

void setup() {
  for (int i = 0; i<Cube_Enable_Num.length; i++) {
    Cube_Enable_Num[i] = int(pow(Braching_Factor, i));
  }
  for (int D = 0; D<cube.length; D++) { //D = Depth
    for (int N = 0; N<Cube_Enable_Num[D]; N++) {
      cube[D][N] = new Cube();
      cube[D][N].SETUP();
    }
  }
  size(880, 670);
  cube[0][0].SETUP();
  //cube[0][0] =   cube[0][0].Clone();
  cube[0][0].reset_CLK();
  //rotated.Create_New_Generation(rotation);
  println("hi");
  for (int D = 0; D<cube.length-1; D++) { //D = Depth
    int change = 0;
    for (int N = 0; N<Cube_Enable_Num[D]; N++) { // N = Node
      for (int N_next = 0; N_next< Braching_Factor; N_next++) {
        cube[D+1][change] = cube[D][N].Create_New_Generation(rotation)[N_next];
        change++;
      }
    }
  }


  //printArray(Cube_Enable_Num);
  println(cube[0][0].Depth);
  println(cube[1][0].Depth);
  println(cube[2][0].Depth);
  
  printArray(cube[0][0].Notation_Step_To_Get_Here);
  printArray(cube[5][125].Notation_Step_To_Get_Here);
  //}
}


void draw() {
  //background(224, 237, 253);
  cube[5][125].DrawCube(70);
  //rotated.DrawCube(70);
}



void keyReleased() {
  rotated = rotated.command(str(key).toUpperCase());
}

void Create_Tree (String rotation[], String Targert_Check) {
}
