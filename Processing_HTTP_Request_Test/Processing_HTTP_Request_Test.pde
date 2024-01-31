
import http.requests.*;

void setup()
{
  size(400, 400);
  smooth();


  GetRequest get = new GetRequest("http://localhost:3000/data");
  get.send(); // d program will wait untill the request is completed
  JSONObject response = parseJSONObject(get.getContent());
  String Cube_Solution = (response.getString("Cube_Solution"));
  String SolverID =  response.getString("SolverID");

  PutRequest put = new PutRequest("http://localhost:3000/data");
  put.addHeader("Content-Type", "application/json");
  put.addData("{\"Cube_State\":\"dec\"," + "\"Cube_Solution\":" + "\""+Cube_Solution+"\","+ "\"SolverID\":" + "\""+SolverID+"\"}");

  put.send();
  System.out.println("Reponse Content: " + put.getContent());
  System.out.println("Reponse Content-Length Header: " + put.getHeader("Content-Length"));
}
