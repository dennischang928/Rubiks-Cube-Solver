class Face {
  int neighboor_index[] = new int[4];
  int NBR_X[][] = new int[4][3];
  int NBR_Y[][] = new int[4][3];
  int NBR_X_change[][] = new int[4][3];
  int NBR_Y_change[][] = new int[4][3];
  boolean NBR_ARR[] = new boolean[4];
  char state[][]  = new char[3][3];
  
  
  
  void AddNeighboor(int neighboor_i[]) {
    neighboor_index = neighboor_i;
  }

  void Add_NBR_Addr(int X[][], int Y[][], int change_x[][], int change_y[][], boolean ARR[]) {
    NBR_X = X;
    NBR_Y = Y;
    NBR_X_change= change_x;
    NBR_Y_change= change_y;
    NBR_ARR =ARR;
  }

  void printface() {
    for (int y = 0; y < 3; y++) {
      for (int x = 0; x < 3; x++) {
        print(state[x][y]);
      }
      println("");
    }
  }

  void rotate_faceCLK() {
    char statecp[][] = new char[3][3];
    for (int x =0; x<3; x++) {
      for (int y =0; y<3; y++) {
        statecp[x][y] = state[x][y];
      }
    }
    char test[] = {
      'E', 'Y', 'R'
    };
    Chg_ROW_CLR(0, get_Col(0, state), statecp);
    Chg_ROW_CLR(2, get_Col(2, state), statecp);
    Chg_COL_CLR(2, get_Row(0, state), statecp);
    Chg_COL_CLR(0, get_Row(2, state), statecp); 
    for (int x =0; x<3; x++) {
      for (int y =0; y<3; y++) {
        state[x][y]=statecp[x][y];
      }
    }
  }
  
  void rotate_faceATCLK() {
    char statecp[][] = new char[3][3];
    for (int x =0; x<3; x++) {
      for (int y =0; y<3; y++) {
        statecp[x][y] = state[x][y];
      }
    }
    char test[] = {
      'E', 'Y', 'R'
    };
    Chg_COL_CLR(0, get_Row(0, state), statecp);
    Chg_COL_CLR(2, get_Row(2, state), statecp);
    Chg_ROW_CLR(2, get_Col(0, state), statecp);
    Chg_ROW_CLR(0, get_Col(2, state), statecp); 
    for (int x =0; x<3; x++) {
      for (int y =0; y<3; y++) {
        state[x][y]=statecp[x][y];
      }
    }
  }

  char[] get_Row(int COL, char[][]src) {
    char output[] = new char[3];
    for (int x =0; x<3; x++) {
      output[x]=src[x][COL];
    }
    return(output);
  }

  char[] get_Col(int ROW, char[][]src) {
    char output[] = new char[3];
    for (int y =0; y<3; y++) {
      output[y]=src[ROW][y];
    }
    return(output);
  }

  char getCLR(int x, int y) {
    return(state[x][y]);
  }

  int [][] corrID(int yourINDEX, boolean ARR) {
    int ID[][] = new int[2][3];
    for (int i = 0; i<4; i++) {
      if (neighboor_index[i] ==yourINDEX) {
        int X_t = 0;
        int Y_t = 0;
        if (i == 0) {
          for (int x = 0; x<3; x++) {
            ID[0][x] = x;
            ID[1][x] = 0;
          }
        } else  if (i == 1) {
          for (int x = 0; x<3; x++) {
            ID[0][x] = x;
            ID[1][x] = 2;
          }
        } else if (i == 2) {
          for (int y = 0; y<3; y++) {
            ID[0][y] = 0;
            ID[1][y] = y;
          }
        } else if (i == 3) {
          for (int y = 0; y<3; y++) {
            ID[0][y] = 2;
            ID[1][y] = y;
          }
        }

        if (ARR != true) {
          int[][] ID_CP = new int[2][3];
          //copy ID
          for (int  Q=0; Q<3; Q++) {
            ID_CP[0][Q] = ID[0][Q];
            ID_CP[1][Q] = ID[1][Q];
          }
          //rearrange
          for (int z =0; z<3; z++) {
            ID[0][z] = ID_CP[0][2-z];
            ID[1][z] = ID_CP[1][2-z];
          }
        }
      }
    }
    return(ID);
  }

  void DrawFace(int x, int y, int size) { //size : every cell's size
    stroke(0);
    strokeWeight(size*0.05);
    for (int X = 0; X < 3; X++) {
      for (int Y = 0; Y < 3; Y++) {
        rectMode(CORNER);
        fill(Char_to_CLR(state[X][Y]));
        rect(x+X*size, y+Y*size, size, size);
      }
    }
  }

  void Chg_Face_CLR(char CLR) {
    for (int x = 0; x < 3; x++) {
      for (int y = 0; y < 3; y++) {
        state[x][y] = CLR;
      }
    }
  }

  void Chg_Color(int x, int y, char CLR) {
    state[x][y] =  CLR;
  }

  void Chg_ROW_CLR(int ROW, char CLR[], char src[][]) {
    for (int x = 0; x < 3; x++) {
      src[x][ROW] = CLR[x];
    }
  }

  void Chg_COL_CLR(int COL, char CLR[], char src[][]) {
    for (int y = 0; y < 3; y++) {
      src[COL][y] = CLR[y];
    }
  }
}
