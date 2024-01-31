import http.requests.*; //<>// //<>//

int box_size=80;
rubikCube rubik = new rubikCube();

//============================================================================================
String comment[] = {"F", "F'", "R", "R'", "L", "L'", "B", "B'", "F2", "U2", "R2", "D2", "L2", "B2", "U", "U'", "D", "D'"};//, "X", "X'", "Y", "Y'", "Z", "Z'"};
int maxDepth = 52;  // max depth of IDDFS
int sufftleNumber = 5100;
long timeOut = 100;  //when over this time out time, the solver will resolve with random order
String solution = "";
//============================================================================================

long timeOutTimer = 0;
boolean Can_I_Solve_It = true;
String directionComment[] = {"X", "X'", "Y", "Y'", "Z", "Z'"};
String randComment0[] = {"F", "F'", "R", "R'", "L", "L'", "B", "B'", "F2", "U2", "R2", "D2", "L2", "B2", "U", "U'", "D", "D'"};
String randComment1[] = {"F", "F'", "R", "R'", "L", "L'", "B", "B'", "F2", "U2", "R2", "D2", "L2", "B2"};
String randComment2[] = {"R", "R'", "L", "L'", "F2", "U2", "R2", "D2", "L2", "B2"};
String randComment3[] = {"F2", "U2", "R2", "D2", "L2", "B2"};
String outputComment= "", stateComment;
boolean isSolved = false;

PutRequest put = new PutRequest("http://localhost:3000/data");
GetRequest get = new GetRequest("http://localhost:3000/data");
void setup() {

  size(0, 0);
  pixelDensity(displayDensity());
  textAlign(LEFT, TOP);
  smooth();
  textSize(16);

  //setCubeColor();
}


void draw() {
  get.send();
  JSONObject res = parseJSONObject(get.getContent());
  //delay(100);
  rubik.drawCube();
  if (res.getString("SolverID").equals("0")) {
    solution = "";
    isSolved = false;
    Can_I_Solve_It = true;
    rubik = new rubikCube();
    rubik.Write_Color(res.getString("Cube_State_Processing"));
    solveCube(rubik);
    if (Can_I_Solve_It == true) {

      println("YES");
      keyPressed();
      rubik.printColor();
      rubik.drawCube();
      get.send();
      // d program will wait untill the request is completed
      JSONObject response = parseJSONObject(get.getContent());
      String Cube_State_processing = (response.getString("Cube_State_Processing"));
      String Cube_State_python = (response.getString("Cube_State_Python"));
      String SolverID =  response.getString("SolverID");
      put.addHeader("Content-Type", "application/json");
      put.addData("{\"Cube_State_Processing\":\"" + Cube_State_processing+ "\"," + "\"Cube_State_Python\":\"" + Cube_State_python+ "\"," + "\"Cube_Solution\":" + "\""+solution+"\","+ "\"SolverID\":" + "\""+1+"\"}");
      put.send();
    } else if (Can_I_Solve_It == false) {
      get.send(); // d program will wait untill the request is completed
      JSONObject response = parseJSONObject(get.getContent());
      String Cube_State_processing = (response.getString("Cube_State_Processing"));
      String Cube_State_python = (response.getString("Cube_State_Python"));
      String Cube_Solution = (response.getString("Cube_Solution"));
      String SolverID =  response.getString("SolverID");
      put.addHeader("Content-Type", "application/json");
      put.addData("{\"Cube_State_Processing\":\"" + Cube_State_processing+ "\"," + "\"Cube_State_Python\":\"" + Cube_State_python+ "\"," + "\"Cube_Solution\":" + "\""+Cube_Solution+"\","+ "\"SolverID\":" + "\""+2+"\"}");
      put.send();
      println("NO GOD!!!!!!");
    }
  }
}

rubikCube sufftleCube(rubikCube r, int sufftleNumber) {
  println("Sufftle");
  for (int i=0; i < sufftleNumber; i++) {
    String rand = comment[(int)random(0, comment.length)];
    r = r.twistPuzzle(rand);
    print(rand+' ');
  }
  return r.clone();
}


rubikCube solveCube(rubikCube r) {
  if (isSolved) return r;

  long timer;

  rubikCube _r = r.clone();
  rubikCube rubikG0 = new rubikCube();
  rubikCube rubikG1 = new rubikCube();
  rubikCube rubikG2_1 = new rubikCube();
  rubikCube rubikG2_2 = new rubikCube();
  rubikCube rubikG3 = new rubikCube();
  rubikCube rubikG4 = new rubikCube();

  timeOutTimer = millis();

  println('\n'+"==========================================="+'\n'+"START"+'\n'+"==========================================="+'\n');
  println("Group 0 cubic");
  r.printColor();

  timer = millis();
  if (IDDFS(_r, maxDepth, 0)) {
    println("reach Group 0 in "+(millis() - timer)/1000.+" seconds");
    println(outputComment += stateComment);
    rubikG0 = _r.twistPuzzle(stateComment);
    rubikG0.printColor();
  }

  timer = millis();
  if (IDDFS(rubikG0, maxDepth, 1)) {
    println("reach Group 1 in "+(millis() - timer)/1000.+" seconds");
    println(outputComment += stateComment);
    rubikG1 = rubikG0.twistPuzzle(stateComment);
    rubikG1.printColor();
  }

  timer = millis();
  if (IDDFS(rubikG1, maxDepth, 21)) {
    println("reach Group 2_1 in "+(millis() - timer)/1000.+" seconds");
    println(outputComment += stateComment);
    rubikG2_1 = rubikG1.twistPuzzle(stateComment);
    rubikG2_1.printColor();
  }

  timer = millis();
  if (IDDFS(rubikG2_1, maxDepth, 22)) {
    println("reach Group 2_2 in "+(millis() - timer)/1000.+" seconds");
    println(outputComment += stateComment);
    rubikG2_2 = rubikG2_1.twistPuzzle(stateComment);
    rubikG2_2.printColor();
  }

  timer = millis();
  if (IDDFS(rubikG2_2, maxDepth, 3)) {
    println("reach Group 3 in "+(millis() - timer)/1000.+" seconds");
    println(outputComment += stateComment);
    rubikG3 = rubikG2_2.twistPuzzle(stateComment);
    rubikG3.printColor();
  }

  timer = millis();
  if (IDDFS(rubikG3, maxDepth, 4)) {
    println("reach solution in "+(millis() - timer)/1000.+" seconds");
    println(outputComment += stateComment);
    solution = outputComment += stateComment;
    rubikG4 = rubikG3.twistPuzzle(stateComment);
    rubikG4.printColor();
    isSolved = true;
  }
  return rubikG4;
}



boolean IDDFS(rubikCube _r, int maxDepth, int group) {
  if (isSolved) return true;

  randomize(directionComment);
  randomize(randComment0);
  randomize(randComment1);
  randomize(randComment2);
  randomize(randComment3);

  for (int limit = 0; limit <= maxDepth; limit++)
    if (DLS(_r, limit, group)) return true;

  return false;
}

boolean DLS(rubikCube _r, int _limit, int group) {
  if (isSolved) return true;

  if (millis() - timeOutTimer >= timeOut) {
    println("time out", str((millis() - timeOutTimer)/1000.) + "seconds");
    outputComment = "";
    isSolved = true;
    //solveCube(rubik);
    Can_I_Solve_It = false;
  }

  if (group == 0) {
    if (_r.isGroup0()) {
      stateComment = _r.parentComment;
      return true;
    }

    if (_limit <= 0) return false;

    for (int i=0; i < directionComment.length; i++) {
      rubikCube temp = _r.twistPuzzle(directionComment[i]);
      temp.parentComment += directionComment[i]+' ';
      if (DLS(temp, _limit - 1, group)) return true;
    }
  } else if (group == 1) {
    if (_r.isGroup1()) {
      stateComment = _r.parentComment;
      return true;
    }

    if (_limit <= 0) return false;

    for (int i=0; i < randComment0.length; i++) {
      rubikCube temp = _r.twistPuzzle(randComment0[i]);
      temp.parentComment += randComment0[i]+' ';
      if (DLS(temp, _limit - 1, group)) return true;
    }
  } else  if (group == 21) {
    if (_r.isGroup2_1()) {
      stateComment = _r.parentComment;
      return true;
    }

    if (_limit <= 0) return false;

    for (int i=0; i < randComment1.length; i++) {
      rubikCube temp = _r.twistPuzzle(randComment1[i]);
      temp.parentComment += randComment1[i]+' ';
      if (DLS(temp, _limit - 1, group)) return true;
    }
  } else  if (group == 22) {
    if (_r.isGroup2_2()) {
      stateComment = _r.parentComment;
      return true;
    }

    if (_limit <= 0) return false;

    for (int i=0; i < randComment1.length; i++) {
      rubikCube temp = _r.twistPuzzle(randComment1[i]);
      temp.parentComment += randComment1[i]+' ';
      if (DLS(temp, _limit - 1, group)) return true;
    }
  } else  if (group == 3) {
    if (_r.isGroup3()) {
      stateComment = _r.parentComment;
      return true;
    }

    if (_limit <= 0) return false;

    for (int i=0; i < randComment2.length; i++) {
      rubikCube temp = _r.twistPuzzle(randComment2[i]);
      temp.parentComment += randComment1[i]+' ';
      if (DLS(temp, _limit - 1, group)) return true;
    }
  } else  if (group == 4) {
    if (_r.isSolved()) {
      stateComment = _r.parentComment;
      return true;
    }

    if (_limit <= 0) return false;

    for (int i=0; i < randComment3.length; i++) {
      rubikCube temp = _r.twistPuzzle(randComment3[i]);
      temp.parentComment += randComment3[i]+' ';
      if (DLS(temp, _limit - 1, group)) return true;
    }
  }



  return false;
}



void keyPressed() {
  if (key == 's') save("cap.png");
  if (key == 'p') rubik.printColor();
  if (key == 'f') {
    rubik = rubik.twistPuzzle("F");
    rubik.drawCube();
  }
  if (key == 'F') {
    rubik = rubik.twistPuzzle("F'");
    rubik.drawCube();
  }
  if (key == 'u') {
    rubik = rubik.twistPuzzle("U");
    rubik.drawCube();
  }
  if (key == 'U') {
    rubik = rubik.twistPuzzle("U'");
    rubik.drawCube();
  }
  if (key == 'r') {
    rubik = rubik.twistPuzzle("R");
    rubik.drawCube();
  }
  if (key == 'R') {
    rubik = rubik.twistPuzzle("R'");
    rubik.drawCube();
  }
  if (key == 'd') {
    rubik = rubik.twistPuzzle("D");
    rubik.drawCube();
  }
  if (key == 'D') {
    rubik = rubik.twistPuzzle("D'");
    rubik.drawCube();
  }
  if (key == 'l') {
    rubik = rubik.twistPuzzle("L");
    rubik.drawCube();
  }
  if (key == 'L') {
    rubik = rubik.twistPuzzle("L'");
    rubik.drawCube();
  }
  if (key == 'b') {
    rubik = rubik.twistPuzzle("B");
    rubik.drawCube();
  }
  if (key == 'B') {
    rubik = rubik.twistPuzzle("B'");
    rubik.drawCube();
  }
  if (key == 'x') {
    rubik = rubik.rotateCubeX(1);
    rubik.drawCube();
  }
  if (key == 'X') {
    rubik = rubik.rotateCubeX(-1);
    rubik.drawCube();
  }
  if (key == 'y') {
    rubik = rubik.rotateCubeY(1);
    rubik.drawCube();
  }
  if (key == 'Y') {
    rubik = rubik.rotateCubeY(-1);
    rubik.drawCube();
  }
  if (key == 'z') {
    rubik = rubik.rotateCubeZ(1);
    rubik.drawCube();
  }
  if (key == 'Z') {
    rubik = rubik.rotateCubeZ(-1);
    rubik.drawCube();
  }

  if (key == '1') println(rubik.isGroup1());
  if (key == '2') println(rubik.isGroup2_2());
  if (key == '3') println(rubik.isGroup3());


  if (key == ' ') {
    println("sufftle");
    for (int i=0; i <5; i++) {
      String rand = comment[(int)random(0, 12)];
      rubik = rubik.twistPuzzle(rand);
      println(rand);
    }
    rubik.drawCube();
  }
}



void randomize (String[] arrMy) {
  for (int k=0; k < arrMy.length; k++) {
    int x = (int)random(0, arrMy.length);
    arrMy = swapValues(arrMy, k, x);
  }
}

String[] swapValues (String[] myArray, int a, int b) {
  String temp=myArray[a];
  myArray[a]=myArray[b];
  myArray[b]=temp;
  return myArray;
}


void setCubeColor() {
  rubik.face[0].setCubeColor(0, 0, 'O');
  rubik.face[0].setCubeColor(0, 1, 'W');
  rubik.face[0].setCubeColor(0, 2, 'W');
  rubik.face[0].setCubeColor(1, 0, 'Y');
  rubik.face[0].setCubeColor(1, 2, 'W');
  rubik.face[0].setCubeColor(2, 0, 'G');
  rubik.face[0].setCubeColor(2, 1, 'W');
  rubik.face[0].setCubeColor(2, 2, 'W');
  //=======================================
  rubik.face[1].setCubeColor(0, 0, 'B');
  rubik.face[1].setCubeColor(0, 1, 'O');
  rubik.face[1].setCubeColor(0, 2, 'W');
  rubik.face[1].setCubeColor(1, 0, 'O');
  rubik.face[1].setCubeColor(1, 2, 'G');
  rubik.face[1].setCubeColor(2, 0, 'Y');
  rubik.face[1].setCubeColor(2, 1, 'R');
  rubik.face[1].setCubeColor(2, 2, 'G');
  //=======================================
  rubik.face[2].setCubeColor(0, 0, 'O');
  rubik.face[2].setCubeColor(0, 1, 'G');
  rubik.face[2].setCubeColor(0, 2, 'G');
  rubik.face[2].setCubeColor(1, 0, 'Y');
  rubik.face[2].setCubeColor(1, 2, 'G');
  rubik.face[2].setCubeColor(2, 0, 'Y');
  rubik.face[2].setCubeColor(2, 1, 'B');
  rubik.face[2].setCubeColor(2, 2, 'R');
  //=======================================
  rubik.face[3].setCubeColor(0, 0, 'R');
  rubik.face[3].setCubeColor(0, 1, 'R');
  rubik.face[3].setCubeColor(0, 2, 'R');
  rubik.face[3].setCubeColor(1, 0, 'R');
  rubik.face[3].setCubeColor(1, 2, 'R');
  rubik.face[3].setCubeColor(2, 0, 'Y');
  rubik.face[3].setCubeColor(2, 1, 'O');
  rubik.face[3].setCubeColor(2, 2, 'B');
  //=======================================
  rubik.face[4].setCubeColor(0, 0, 'B');
  rubik.face[4].setCubeColor(0, 1, 'B');
  rubik.face[4].setCubeColor(0, 2, 'W');
  rubik.face[4].setCubeColor(1, 0, 'B');
  rubik.face[4].setCubeColor(1, 2, 'G');
  rubik.face[4].setCubeColor(2, 0, 'Y');
  rubik.face[4].setCubeColor(2, 1, 'O');
  rubik.face[4].setCubeColor(2, 2, 'O');
  //=======================================
  rubik.face[5].setCubeColor(0, 0, 'O');
  rubik.face[5].setCubeColor(0, 1, 'Y');
  rubik.face[5].setCubeColor(0, 2, 'G');
  rubik.face[5].setCubeColor(1, 0, 'Y');
  rubik.face[5].setCubeColor(1, 2, 'B');
  rubik.face[5].setCubeColor(2, 0, 'B');
  rubik.face[5].setCubeColor(2, 1, 'W');
  rubik.face[5].setCubeColor(2, 2, 'R');
}
