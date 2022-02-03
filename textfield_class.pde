class Textfield {
  float x, y;
  float rectHeight = 30;
  float rectWidth = 200;
  String input;
  String hint;
  boolean blink = true;
  String cursor = "|";

  Textfield(float x, float y, String hint, String input) {
    this.x = x - rectWidth/2;
    this.y = y;
    this.hint = hint;
    this.input = input;
  }

  void display() {
    textAlign(LEFT, BASELINE);
    
    // when the frame number is a multiple of 30 the cursor changes state, making the "blinking" effect
    if (focus() && frameCount % 30 == 0) {
      blink = !blink;
    }

    fill(255);
    stroke(55);
    strokeWeight(2);
    rect(x, y, rectWidth, rectHeight);

    textFont(but);

    fill(81);
    if (blink) {
      text(hint, x + 10, y + 20);
    } else {
      text(hint + cursor, x + 10, y + 20);
    }

    fill(255);
    text(input, x, y - 5);
  }

  // focus() works in the same way as overButton()
  boolean focus() {
    if (mouseX >= x && mouseX <= x+rectWidth && mouseY >= y && mouseY <= y+rectHeight) {
      return true;
    } else {
      return false;
    }
  }
}
