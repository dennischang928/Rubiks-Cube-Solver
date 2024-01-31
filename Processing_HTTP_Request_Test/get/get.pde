import http.requests.*;

public void setup()
{
  size(400, 400);
  smooth();

  GetRequest get = new GetRequest("http://localhost:3000/data");
  get.send();
  println(get.getContent());
  println("Reponse Content-Length Header: " + get.getHeader("Content-Length"));
}
