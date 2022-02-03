// instances declaration
Button startBtn, loginBtn, selectBtn, confirmBtn, cancelBtn;
Popup p1, p2, p3;
Textfield t1, t2;

// declaration of fonts used
PFont H1, par, but;

boolean hidePopup1, hidePopup2, hidePopup3; // control whether a popup is hidden = true or not.
int state = 0; // set this to 0
boolean focus1, focus2; // control whether a specific textfield is focused (clicked) 

// array of numbers and corresponding array of booleans for the "slot-machine" like behavior of the last exercise
int[] numbers = new int[10];
Boolean[] running = new Boolean[10];
String phoneNumber = "";
int select = 9; // check how the numbers get written on screen

void setup() {
  size(1920, 1080);
  frameRate(60);

  hidePopup1 = hidePopup2 = hidePopup3 = true;

  textSize(14);

  // initialization of fonts, instances and arrays
  H1 = createFont("Ebrima Grassetto", 20);
  par = createFont("Ebrima", 16);
  but = createFont("Ebrima", 14);

  textFont(but);

  startBtn = new Button(width/2, 2*height/3, "START", "default");
  loginBtn = new Button(width/2, height/2, "LOGIN", "default");
  selectBtn = new Button(width/4, height/2+100, "SELECT", "default");
  confirmBtn = new Button(2*width/4, height/2+100, "CONFIRM", "red");
  cancelBtn = new Button(3*width/4, height/2+100, "CANCEL", "green");

  // 3 buttons: SELECT, CONFIRM, CANCEL. One for stopping the random number generator in one position, one to confirm, and one resets the generator.

  p1 = new Popup(width/2, height/2, "Cookies", "This website uses cookies. By continuing, you consent to the use of cookies on your device");
  p2 = new Popup(width/2, height/2, "Newsletter", "Since you are here why don't you subscribe to our newsletter?");
  p3 = new Popup(width/2, height/2, "AdBlock", "Disable adBlock while visiting our website (it will make us make EVEN MORE money)?");
  t1 = new Textfield(width/2, 300, "Your username here", "Username");
  t2 = new Textfield(width/2, 400, "Your password here", "Password");

  for (int i = 0; i< numbers.length; i++) {
    running[i] = true;
    numbers[i] = 0;
  }
}

/*

for the draw function, the variable "state" works as a sort of page selector/allows to go to the "next" phase
e.g. closing popups if they have been closed

using conditionals it is possible to display() specific components (buttons, text, etc.)

it works in coordination with the mouseClicked() and keyReleased() functions to trigger events.

*/

void draw() {
  background(0);
  textAlign(CENTER, CENTER);
  
  if (state <= 3) {
    textFont(H1);
    fill(255);
    text("Hi YOU and welcome to An-Usable Interface, an example of some Worst Practices for Interface building", width/2, height/2);

    startBtn.display();

    if (!hidePopup1) { // if the popup is NOT hidden, show it
      p1.display();
    }
    if (!hidePopup2) {
      p2.display();
    }
    if (!hidePopup3) {
      p3.display();
    }
  } else if (state == 4) {
    textFont(H1);
    fill(255);
    text("Login with your credentials", width/2, 120);
    t1.display();
    t2.display();
    loginBtn.display();
  } else  if (state < 1000) { // this could be done in a better way, encasing all the ifs in a while() loop
    textFont(H1);
    fill(255);
    text("Insert your phone number", width/2, 120);

    textSize(36);

    for (int i = 0; i < numbers.length; i++) {
      if (frameCount % 6 == 0 && running[i]) {
        numbers[i] = int(random(0, 10));        // random numbers from 0 and 10-excluded, converted to integer
      }
      text(numbers[i], 800+(40*i), height/3);
    }
    text(phoneNumber, width/2, height/3 + 50);

    cancelBtn.display();
    selectBtn.display();
    confirmBtn.display();
  } else {
    textFont(H1);
    textSize(80);
    fill(255);
    text("Leaving so soon? =(", width/2, height/2);
  }
}

/*
mouseClicked registers an event when the mouse is pressed and released. 
Using the overButton() and focus() method it is possible to register clicks over buttons or textfields.
*/

void mouseClicked() {
  if (startBtn.overButton()) {
    if (state == 0) {
      hidePopup1 = false;
    } else if (state == 1) {
      hidePopup2 = false;
    } else if (state == 2) {
      hidePopup3 = false;
    } else if (state == 3) {
      state++;
    }
  } else if (!hidePopup1 || !hidePopup2 || !hidePopup3) {
    if (p1.accept.overButton() || p1.cancel.overButton()) {
      hidePopup1 = hidePopup2 = hidePopup3 = true;
      state++;
      startBtn.style = "red";
      startBtn.label = startBtn.label + " !";
      startBtn.bHeight = startBtn.bHeight + 10;
      startBtn.bWidth = startBtn.bWidth + 20;
    }
  } else if (t1.focus()) {
    focus1 = true;
    focus2 = false;
  } else if (t2.focus()) {
    focus1 = false;
    focus2 = true;
  } else if (loginBtn.overButton()) {
    state++;
  } else if (selectBtn.overButton()) {
    // the numbers are written in inverse order, just to mess with the user
    if (select >= 0) {
      phoneNumber = phoneNumber + numbers[select];
      running[select] = false;
      select--;
    }
  } else if (cancelBtn.overButton()) {
    // if the cancelBtn is clicked the string is entirely deleted, the iterator select re-initialized to 9
    // and the random generation of numbers started again
    phoneNumber = "";
    for(int i = 0; i < numbers.length; i++) {
      running[i] = true;
    }
    select = 9;
  } else if (confirmBtn.overButton()) {
    state = 1000;
  }
  println(state);
}

/*
keyReleased works in a similar way to mouseClicked, registering a keypress only after the key is released.
Using the global variables "focus" it is possible to edit a specific textfield that received focus (e.g. was clicked)
*/

void keyReleased() {
  if (focus1) {
    if (key == BACKSPACE && t1.input.length() > 0) {
      t1.input = t1.input.substring(0, t1.input.length()-1);
    } else if (key != CODED) {
      t1.input = t1.input + key;
    }
  } else if (focus2) {
    if (key == BACKSPACE && t2.input.length() > 0) {
      t2.input = t2.input.substring(0, t2.input.length()-1);
    } else if (key != CODED) {
      t2.input = t2.input + key;
    }
  }
}
