
import processing.serial.*;

Serial myPort;

ArrayList<Integer>[] lapTimes = new ArrayList[2];
void setup() {
  lapTimes[0] = new ArrayList<Integer>();
  lapTimes[1] = new ArrayList<Integer>();
  //on some macbook:
  //myPort = new Serial(this, "/dev/serial1", 9600);
  //on some windows laptop:
  //myPort = new Serial(this, "COM5", 9600);
  //on Raspberry Pi:
  myPort = new Serial(this, "/dev/serial1", 9600); //change this to actual device.
  background(0);
  size(1200, 800);
  noStroke();
  smooth();
  fill(255);
  drawPlayer(50, "Player 1");
  drawPlayer(650, "Player 2");
  frameRate(30);
}
int y_inc = 100;
int start_y = 250; 
void drawPlayer(int x, String title ) {
  int y = start_y;
  textSize(32);
  text(title, x, y);
  textSize(20);
  y += y_inc;text("Fastest time: ",x, y);
  y += y_inc;text("Last lap time: ",x, y);
  y += y_inc;text("Average lap time (last 10 laps): ",x, y);
  y += y_inc;text("Lap count: ",x, y);
}
void readSerial() {
  String _buffer = myPort.readString();
  String[] m;
  if (null == _buffer) {
    return;
  }
  m = match(_buffer, "([AB])([0-9]+)");
  println("Player " + m[1] + " Millis " + m[2]);
  
  int player = 0;
  if (m[1].equals("B")) {
    player = 1;
  }
  lapTimes[player].add(int(m[2]));
}

void draw() {
  readSerial();
  drawTimes(0, 50);
  drawTimes(1, 650);
}
void keyPressed() {
  println(keyCode);
  if(keyCode == 32) {
    lapTimes[0].clear();
    lapTimes[1].clear();
  }
}

void drawTimes(int player_no, int x) {
  ArrayList data = lapTimes[player_no];
  int lapCount = data.size();
  Integer lastLap = 0;
  Integer averageLap = 0;
  Integer fastest = 0;
  if (lapCount > 1) {
    
    for (int i = 1; i < lapCount; i++) {
      Integer lapTime = (Integer) data.get(i);
      if ((fastest == 0) || (fastest > lapTime)) {
        fastest = lapTime;
      }
    }

    lastLap = (Integer) data.get(lapCount - 1);
    Integer total = 0;
    int amount = 0;
    for (int i = max(1, lapCount - 11); i < lapCount; i++) {
      Integer lapTime = (Integer) data.get(i);
      total += lapTime;
      amount++;
    }
    
    averageLap = total  / amount;
    
  }
  
  
  int w = 300;
  int h = 50;
  int y = start_y + 10;
  stroke(255);
  fill(0);
  y += y_inc;rect(x, y, w, h);
  y += y_inc;rect(x, y, w, h);
  y += y_inc;rect(x, y, w, h);
  
  y += y_inc;rect(x, y, w, h);
  
  y = start_y + 50;
  textSize(32);
  fill(255);
  noStroke();
  y += y_inc;text(fastest / 1000.0, x, y);
  y += y_inc;text(lastLap / 1000.0, x, y);
  y += y_inc;text(averageLap / 1000.0, x, y);
  y += y_inc;text(max(0,lapCount-1), 10+x, y);
}
