# Slotcar Leaderboard

A simple lap counter & timer for [Slot cars](https://en.wikipedia.org/wiki/Slot_car):

## Requirements:

- Line follower: [https://www.sparkfun.com/products/11769](https://www.sparkfun.com/products/11769)
- Arduino
- Raspberry Pi running [Processing](https://pi.processing.org/)
- Screen for Pi
- 5V Power for everything

## Wiring

You'll need one line follower per car. The idea is that you put the line follower at the start line, either at the side of the track pointing in to see the car pass, or you can hover it above the start line with Helping Hands.

## Running the scripts

- Run the Arduino sketch on your Arduino
- Open the serial monitor
- Race your cars around to see their times printed
- Run Processing sketch to see GUI

## Customisation

At the start of `Leaderboard.ino`, you can define the sensors. We only have two tracks, so we need two sensors. If you need more lanes, you'll need to start here:

```
int sensor1 = 2; // Pin 2
int sensor2 = 3; // Pin 3

void setup() {
	pinMode(sensor1,INPUT);
	pinMode(sensor2,INPUT);
	Serial.begin(9600);
}

```

## Improvements

We're going to 3D modal a starting block that you should be able to print and attach sensors. This should help integrate the lap counter with the Slot Cars, so everything feels warmer on the inside.

## Running on Raspberry Pi
Following is enaugh to get it working on a Raspberry Pi with stock Raspbian:
```
git clone https://github.com/makerspace48/leaderboard.git
curl https://processing.org/download/install-arm.sh | sudo sh
```
Then in the user dir:
```
processing leaderboard\leaderboard.pde
```
Processing should open the sketch. Paste your serial device in line 11
```
 myPort = new Serial(this, "/dev/tty.wchusbserial1410", 9600);
 ```
 And click the run button. Enjoy your race.
