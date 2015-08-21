
/***********************************************************************
 * Adapted from Exp6_2_LineFollowing_IRSensors -- RedBot Experiment 6
 ***********************************************************************/

#include <RedBot.h>
RedBotSensor left = RedBotSensor(A3);   // initialize a left sensor object on A3
RedBotSensor center = RedBotSensor(A6); // initialize a center sensor object on A6
RedBotSensor right = RedBotSensor(A7);  // initialize a right sensor object on A7

#define SPEED 120  // sets the nominal speed. Set to any number from 0 - 255.

#define SPEED_ADJUSTMENT 30

#define COUNTER_MAX 20

// These thresholds are manually configured.
#define TAPE_THRESHOLD  150 // below this value, we are looking at the tape

#define NOT_SET 0
#define TAPE_STATE 1
#define NOT_TAPE_STATE 2

RedBotMotors motors;
int leftSpeed;   // variable used to store the leftMotor speed
int rightSpeed;  // variable used to store the rightMotor speed

bool driftingRight = false;
bool driftingLeft = false;

void setup()
{
  Serial.begin(9600);
  Serial.println("Line Following Startup");  
  Serial.println("------------------------------------------");
  delay(2000);
  Serial.println("IR Sensor Readings: ");
  delay(500);
}

void loop()
{
  int leftReading = left.read();
  int centerReading = center.read();
  int rightReading = right.read();
  
  // reset speeds to base speed
  leftSpeed =  SPEED; 
  rightSpeed = SPEED;
  
  // no drift
  if((onTape(centerReading) && !onTape(leftReading) && !onTape(rightReading)) ||
     (onTape(centerReading) && onTape(leftReading) && onTape(rightReading))) {
    driftingLeft = false;
    driftingRight = false;
  }
   
  // drifting left
  if((onTape(rightReading) && onTape(centerReading) && !onTape(leftReading)) ||
     (onTape(rightReading) && !onTape(centerReading) && !onTape(leftReading))) 
  {
    driftingLeft = true;
    driftingRight = false;
    
    rightSpeed -= SPEED_ADJUSTMENT;
  }

  // drift right
  if((onTape(leftReading) && onTape(centerReading) && !onTape(rightReading)) ||
     (onTape(leftReading) && !onTape(centerReading) && !onTape(rightReading)))
  {
    driftingRight = true;
    driftingLeft = false;
    
    leftSpeed -= SPEED_ADJUSTMENT;
  }
    
  // recovery
  if(!onTape(leftReading) && !onTape(centerReading) && !onTape(rightReading))
  {
    if(driftingLeft) {
      leftSpeed = SPEED;
      rightSpeed = 70;
    }
    else if(driftingRight) {
      rightSpeed = SPEED;
      leftSpeed = 70;
    }
  }

  driveRightForward(rightSpeed);
  driveLeftForward(leftSpeed);
  
  delay(0);  // add a delay to decrease sensitivity.
  
  Serial.print(leftReading);
  Serial.print("\t");  // tab character
  Serial.print(centerReading);
  Serial.print("\t");  // tab character
  Serial.print(rightReading);
  Serial.print("\t");
  Serial.print("\t|\t");
  if(driftingLeft) { Serial.print("DRIFT LEFT"); }
  Serial.print("\t");
  if(driftingRight) { Serial.print("DRIFT RIGHT"); }
  Serial.print("\t");
  Serial.print(leftSpeed);
  Serial.print("\t");
  Serial.print(rightSpeed);
  Serial.println();
}

void driveLeftForward(int speed) {
  motors.leftMotor(-1 * speed);
}

void driveLeftBackward(int speed) {
  motors.leftMotor(speed);
}

void driveRightForward(int speed) {
  motors.rightMotor(speed);
}

void driveRightBackward(int speed) {
  motors.rightMotor(-1 * speed);
}

bool onTape(int sensorReading) {
  return sensorReading < TAPE_THRESHOLD;
}
