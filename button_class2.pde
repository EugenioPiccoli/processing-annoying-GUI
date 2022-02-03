class Button {
  float x;
  float y;
  String label;
  String style;
  float sw;
  float bWidth;
  float bHeight = 36;
  color buttonColor; // default button color
  color buttonHover; // color if button is cursor over button
  color buttonClick; // color if button is clicked
  color strokeStyle;

  Button(float x, float y, String label, String style) {
    this.label = label;
    this.style = style;
    this.sw = textWidth(label); // defines the string width using the textWidth() function
    this.bWidth = sw + 32; // internal paddings are added to the button based on sw (16px - left and right)
    this.x = x - bWidth/2;
    this.y = y - bHeight/2;
  }

  void display() { // the diplay() method draws the instance on the screen

    if (style == "green") {
      buttonColor = color(0, 200, 0, 255);
      strokeStyle = color(0, 155, 0, 255);
    } else if (style == "red") {
      buttonColor = color(255, 0, 0, 255);
      strokeStyle = color(155, 0, 0, 255);
    } else {
      buttonColor = color(255, 255, 255, 255);
      strokeStyle = color(155, 155, 155, 255);
    }

    buttonHover = buttonColor - color(0, 0, 0, 80);
    buttonClick = buttonColor - color(0, 0, 0, 150);

    if (clickButton()) {
      fill(buttonClick);
      strokeWeight(2);
    } else if (overButton()) {
      fill(buttonHover);
      strokeWeight(2);
    } else {
      fill(buttonColor);
      strokeWeight(1);
    }
    
    stroke(strokeStyle);
    rect(x, y, bWidth, bHeight, bHeight/2);
    fill(0);
    textAlign(CENTER, CENTER);
    textFont(but);
    text(label, x + bWidth/2, y + bHeight/2 - 3);
  }
  
  // the following boolean methods are used to change the appearance AND trigger events
  
  boolean overButton() {
    if (mouseX >= x && mouseX <= x+bWidth && mouseY >= y && mouseY <= y+bHeight) {
      return true;
    } else {
      return false;
    }
  }

  boolean clickButton() {
    if (mousePressed && overButton()) {
        return true;
      } else {
        return false;
      }
  }
}
