class Popup {
  float x, y;
  float w = 560;
  float h = 182;
  String title;
  String body;
  int margin = 24;
  Button accept, cancel;

  Popup(float x, float y, String title, String body) {
    this.x = x - w/2;
    this.y = y - h/2;
    this.title = title;
    this.body = body;
  }

  void display() {
    background(50);
    fill(255);
    noStroke();
    rect(x, y, w, h, 10 );
    
    // here the measurements are done by hand, they won't work with different dimensions
    stroke(255,0,0);
    fill(0); 
    textAlign(LEFT, BASELINE);
    textFont(H1);
    text(title, x + margin, y + 19, w, h);
    textFont(par);
    text(body, x + margin, y + 58, w - margin*2, h);
    
    accept = new Button(x+w-150, y+h-26, "ACCEPT", "red");
    accept.display();
    
    cancel = new Button(x+w-150+accept.bWidth+8, y+h-26, "CANCEL", "green");
    cancel.display(); 
  }
}
