
int sensor1 = 2;
int sensor2 = 3;

void setup() {
  // put your setup code here, to run once:
pinMode(sensor1,INPUT);
pinMode(sensor2,INPUT);
Serial.begin(9600);
}

void loop() {
  static bool detected1 = 0;
  static bool detected2 = 0;
  static long prevTime1 = 0;
  static long prevTime2 = 0;
  // put your main code here, to run repeatedly:
if (digitalRead(sensor1)) {
if (!detected1) {
  Serial.print("A");
  Serial.println(millis()-prevTime1);
     prevTime1 = millis();
     detected1 = 1;
}
}
else {
  detected1 = 0;
}
if (digitalRead(sensor2)) {
if (!detected2) {
  
  Serial.print("B");
  Serial.println(millis()-prevTime2);
     prevTime2 = millis();
     detected2 = 1;
}
}
else {
  detected2 = 0;
}
}
