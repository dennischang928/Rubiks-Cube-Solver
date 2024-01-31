/*
   Microstepping demo

   This requires that microstep control pins be connected in addition to STEP,DIR

   Copyright (C)2015 Laurentiu Badea

   This file may be redistributed under the terms of the MIT license.
   A copy of this license has been included with this distribution in the file LICENSE.
*/
#include <Servo.h>
#include <Arduino.h>

// Motor steps per revolution. Most steppers are 200 steps or 1.8 degrees/step
#define MOTOR_STEPS 200
#define RPM 200

#define DIR 9
#define STEP 8
#define SLEEP 13 // optional (just delete SLEEP from everywhere if not used)

/*
   Choose one of the sections below that match your board
*/

#include "DRV8834.h"
#define M0 10
#define M1 11
DRV8834 stepper(MOTOR_STEPS, DIR, STEP, SLEEP, M0, M1);

// #include "A4988.h"
// #define MS1 10
// #define MS2 11
// #define MS3 12
// A4988 stepper(MOTOR_STEPS, DIR, STEP, SLEEP, MS1, MS2, MS3);

// #include "DRV8825.h"
// #define MODE0 10
// #define MODE1 11
// #define MODE2 12
// DRV8825 stepper(MOTOR_STEPS, DIR, STEP, SLEEP, MODE0, MODE1, MODE2);

// #include "DRV8880.h"
// #define M0 10
// #define M1 11
// #define TRQ0 6
// #define TRQ1 7
// DRV8880 stepper(MOTOR_STEPS, DIR, STEP, SLEEP, M0, M1, TRQ0, TRQ1);

// #include "BasicStepperDriver.h" // generic
// BasicStepperDriver stepper(MOTOR_STEPS, DIR, STEP);
Servo test;
void setup() {
  Serial.begin(115200);
  /*
     Set target motor RPM.
  */
  stepper.begin(RPM);
  // if using enable/disable on ENABLE pin (active LOW) instead of SLEEP uncomment next line
  // stepper.setEnableActiveState(LOW);
  stepper.enable();

  // set current level (for DRV8880 only).
  // Valid percent values are 25, 50, 75 or 100.
  // stepper.setCurrent(100);
  test.attach(3);
  stepper.setMicrostep(1);
}

void loop() {
  //  test.write(0);
  //  delay(1000);

  /*
     Moving motor in full step mode is simple:
  */
  //  Serial.println(test.read());


  // Set microstep mode to 1:1

  // One complete revolution is 360°
  stepper.rotate(90);
  delay ( 2000);
  //   forward revolution
  //      stepper.rotate();    // reverse revolution


  //    delay(5000);
}
