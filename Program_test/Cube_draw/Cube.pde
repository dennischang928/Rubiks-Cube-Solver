int NBR_list[][] = { //<>//
  {5, 4, 2, 3}, 
  {4, 5, 2, 3}, 
  {0, 1, 5, 4}, 
  {0, 1, 4, 5}, 
  {0, 1, 2, 3}, 
  {0, 1, 3, 2} };

boolean ARR[][] = {
  {false, true, true, false}, 
  {true, false, false, true}, 
  {true, false, true, true}, 
  {false, true, true, true}, 
  {true, true, true, true}, 
  {false, false, true, true} };
boolean ARR_shift[]= {false, false, true, true};

boolean ARR_change[][] = {
  {true, true, true, true}, 
  {true, true, true, true}, 
  {true, true, true, true}, 
  {true, true, true, true}, 
  {true, true, true, true}, 
  {true, true, true, true} };

class Cube {
  Face Child[]  =new Face[6]; // 0 = up,down,left,right,front,back  
  //0B, 1G, 2O, 3R, 4W, 5Y

  Cube() {
    for (int i  =0; i<6; i++) {
      Child[i] = new Face();
    }
  }

  void SETUP() {
    for (int i = 0; i < 6; i++) {
      Child[i].AddNeighboor(NBR_list[i]);
    }
    int NBR_X[][][] = new int[6][4][3];
    int NBR_Y[][][] = new int[6][4][3];
    int NBR_X_change[][][] = new int[6][4][3];
    int NBR_Y_change[][][] = new int[6][4][3];
    for (int i = 0; i < 6; i++) {
      for (int t = 0; t < 4; t++) {
        NBR_X_change[i][t] = find_neighboorXY(Child[i].neighboor_index[t], i, 'X', ARR_change[i][t]);
        NBR_Y_change[i][t] = find_neighboorXY(Child[i].neighboor_index[t], i, 'Y', ARR_change[i][t]);
        NBR_X[i][t] = find_neighboorXY(Child[i].neighboor_index[t], i, 'X', ARR[i][t]);
        NBR_Y[i][t] = find_neighboorXY(Child[i].neighboor_index[t], i, 'Y', ARR[i][t]);
      }
    }
    for (int i = 0; i < 6; i++) {
      Child[i].Add_NBR_Addr(NBR_X[i], NBR_Y[i], NBR_X_change[i], NBR_Y_change[i], ARR[i]);
    }
  }
  void reset_CLK() {
    char CLRlist[] = {'W', 'Y', 'O', 'R', 'G', 'B'};
    for (int i = 0; i < 6; i++) {
      Child[i].Chg_Face_CLR(CLRlist[i]);
    }
  }
  Cube Clone() {
    Cube OUTPUT = new Cube();
    OUTPUT.SETUP();
    for (int i =0; i<6; i++) {
      for (int x = 0; x<3; x++) {
        for (int y = 0; y<3; y++) {
          OUTPUT.Child[i].state[x][y] =this.Child[i].state[x][y];
        }
      }
    }
    return(OUTPUT);
  }
  void rotCLK(int Face, int times) {
    char CLR_CP [][][] = new char[4][3][3];

    for (int i =0; i<times; i++) {
      for (int x = 0; x<4; x++) {
        for (int y = 0; y<3; y++) {
          for (int z = 0; z<3; z++) {
            CLR_CP[x][y][z] = this.Child[this.Child[Face].neighboor_index[x]].getCLR(y, z);
          }
        }
      }

      for (int x = 0; x < 4; x++) {
        int NBR_X_[]  = new int[3];
        int NBR_Y_[]  = new int[3];

        for (int r = 0; r<3; r++) {
          NBR_X_[r] = Child[Face].NBR_X[x][r]; 
          NBR_Y_[r] = Child[Face].NBR_Y[x][r];
        }

        if (ARR_shift[x] == false) {
          for (int r = 0; r<3; r++) {
            NBR_X_[r] = Child[Face].NBR_X[x][r]; 
            NBR_Y_[r] = Child[Face].NBR_Y[x][r];
          }


          int[]NBR_X_CP = new int[3]; 
          int[]NBR_Y_CP = new int[3]; 

          for (int  U=0; U<3; U++) {
            NBR_X_CP[U] = NBR_X_[U];
            NBR_Y_CP[U] =NBR_Y_[U];
          }

          //rearrange

          for (int z =0; z<3; z++) {
            NBR_X_[z] = NBR_X_CP[2-z];
            NBR_Y_[z] = NBR_Y_CP[2-z];
          }
        }

        for (int t = 0; t < 3; t++) {
          Child[Child[Face].neighboor_index[x]].Chg_Color(NBR_X_[t], NBR_Y_[t], CLR_CP[nextin(x, true)][Child[Face].NBR_X[nextin(x, true)][t]][Child[Face].NBR_Y[nextin(x, true)][t]]);
        }
      }
      Child[Face].rotate_faceCLK();
    }
  }


  void rotATCLK(int Face, int times) {
    char CLR_CP [][][] = new char[4][3][3];

    for (int i =0; i<times; i++) {
      for (int x = 0; x<4; x++) {
        for (int y = 0; y<3; y++) {
          for (int z = 0; z<3; z++) {
            CLR_CP[x][y][z] = this.Child[this.Child[Face].neighboor_index[x]].getCLR(y, z);
          }
        }
      }

      for (int x = 0; x < 4; x++) {
        int NBR_X_[]  = new int[3];
        int NBR_Y_[]  = new int[3];

        for (int r = 0; r<3; r++) {
          NBR_X_[r] = Child[Face].NBR_X[x][r]; 
          NBR_Y_[r] = Child[Face].NBR_Y[x][r];
        }

        if (ARR_shift[x] == true) {
          for (int r = 0; r<3; r++) {
            NBR_X_[r] = Child[Face].NBR_X[x][r]; 
            NBR_Y_[r] = Child[Face].NBR_Y[x][r];
          }

          int[]NBR_X_CP = new int[3]; 
          int[]NBR_Y_CP = new int[3]; 

          for (int  U=0; U<3; U++) {
            NBR_X_CP[U] = NBR_X_[U];
            NBR_Y_CP[U] =NBR_Y_[U];
          }
          //rearrange

          for (int z =0; z<3; z++) {
            NBR_X_[z] = NBR_X_CP[2-z];
            NBR_Y_[z] = NBR_Y_CP[2-z];
          }
        }
        for (int t = 0; t < 3; t++) {
          //this.Child[5].Chg_Color(Child[Face].NBR_X[x][t], Child[Face].NBR_Y[x][t], 'E');
          Child[Child[Face].neighboor_index[x]].Chg_Color(NBR_X_[t], NBR_Y_[t], CLR_CP[nextin(x, false)][Child[Face].NBR_X[nextin(x, false)][t]][Child[Face].NBR_Y[nextin(x, false)][t]]);
        }
      }
      Child[Face].rotate_faceATCLK();
    }
  }

  Cube command(String input) {
    char letter_to_index[] = {'U', 'D', 'L', 'R', 'F', 'B'};
    char Letter = input.charAt(0);
    char ROT_Time  = ' ';
    Cube OUTPUT = new Cube();
    OUTPUT.SETUP();
    for (int i = 0; i<6; i++) {
      for (int x = 0; x<3; x++) {
        for (int y = 0; y<3; y++) {
          OUTPUT.Child[i].state[x][y] = this.Clone().Child[i].state[x][y];
        }
      }
    }

    OUTPUT.Child[4].printface();
    if (input.length()==2) {
      ROT_Time = input.charAt(1);

      if (ROT_Time == '2') {
        for (int i = 0; i<6; i++) {
          if (letter_to_index[i]==Letter) {
            OUTPUT.rotCLK(i, 2);
          }
        }
      } else if (ROT_Time == 0x0027) { 
        for (int i = 0; i<6; i++) {
          if (letter_to_index[i]==Letter) {
            OUTPUT.rotATCLK(i, 1);
          }
        }
      }
    } else {
      for (int i = 0; i<6; i++) {
        if (letter_to_index[i]==Letter) {
          OUTPUT.rotCLK(i, 1);
        }
      }
    }
    println("-----------");
    OUTPUT.Child[4].printface();
    return(OUTPUT);
  }

  void DrawCube(int size) {
    pushMatrix();
    translate(20, 20);
    pushMatrix();
    translate(size * 3, 0);
    Child[0].DrawFace(0, 0, size);
    popMatrix();

    pushMatrix();
    translate(size * 3, size * 3 * 2);
    Child[1].DrawFace(0, 0, size);
    popMatrix();

    pushMatrix();
    translate(0, size * 3);
    Child[2].DrawFace(0, 0, size);
    popMatrix();

    pushMatrix();
    translate(size * 3 * 2, size * 3);
    Child[3].DrawFace(0, 0, size);
    popMatrix();

    pushMatrix();
    translate(size * 3, size * 3);
    Child[4].DrawFace(0, 0, size);
    popMatrix();

    pushMatrix();
    translate(size * 3 * 3, size * 3);
    Child[5].DrawFace(0, 0, size);
    popMatrix();

    popMatrix();
  }



  // --------------------------function--------------------------
  int[] find_neighboorXY(int targetID, int myID, char X_OR_Y, boolean ARR) {
    int X_Y = (X_OR_Y=='X')? 0:1;

    return(this.Child[targetID].corrID(myID, ARR)[X_Y]);
  }
}
int nextin(int yourindex, boolean R_L) { // right = true, left = false

  if (R_L == true) {
    switch(yourindex) {
    case 0: 
      return(2);
    case 1: 
      return(3);
    case 2: 
      return(1);
    case 3: 
      return(0);
    default:
      return(-1);
    }
  } else {
    switch(yourindex) {
    case 0: 
      return(3);
    case 1: 
      return(2);
    case 2: 
      return(0);
    case 3: 
      return(1);
    default:
      return(-2);
    }
  }
}

color Char_to_CLR(char input) {
  color output = 0;
  if (input =='R') {
    output=color(218, 67, 59);
  }
  if (input =='G') {
    output=color(123, 209, 116);
  }
  if (input =='B') {
    output=color(43, 99, 245);
  }
  if (input =='O') {
    output=color(221, 160, 60);
  }
  if (input =='Y') {
    output=color(242, 241, 83);
  }
  if (input =='W') {
    output=color(255, 255, 255);
  }
  if (input =='E') {
    output=color(0);
  }
  return(output);
}
