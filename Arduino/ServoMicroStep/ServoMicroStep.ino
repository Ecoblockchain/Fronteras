#include <Servo.h>

// Range [600,2200] ~180 deg ==> 9ms ~ 1 degree
Servo mServo[2];
const int SERVO_RANGE = 90; // 90 ~10 deg

// {BASE,LASER}
const int SERVO_PIN[2] = {3, 5};
const int SERVO_CENTER[2] = {1460, 1530};
const int LASER_PIN = 6;

int mPosition = 0;

void setup() {
  for (short i = 0; i < 2; i++) {
    mServo[i].attach(SERVO_PIN[i]);
    mServo[i].writeMicroseconds(SERVO_CENTER[i]);
  }
  pinMode(LASER_PIN, OUTPUT);
  analogWrite(LASER_PIN, LOW);
}

void loop() {
  // toggle position
  for (short i = 0; i < 2; i++) {
    if (mPosition) {
      analogWrite(LASER_PIN, 255);
      mServo[i].writeMicroseconds(SERVO_CENTER[i] - SERVO_RANGE);
    }
    else {
      analogWrite(LASER_PIN, LOW);
      mServo[i].writeMicroseconds(SERVO_CENTER[i] + SERVO_RANGE);
      delay(50);
    }
    //mServo[i].writeMicroseconds(SERVO_CENTER[i]);
  }

  mPosition = (mPosition + 1) % 2;
  delay(150);
}

