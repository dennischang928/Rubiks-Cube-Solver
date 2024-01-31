/*
   Multi-motor control (experimental)

   Move two or three motors at the same time.
   This module is still work in progress and may not work well or at all.

   Copyright (C)2017 Laurentiu Badea

   This file may be redistributed under the terms of the MIT license.
   A copy of this license has been included with this distribution in the file LICENSE.
*/
#include <Arduino.h>
#include <Servo.h>
#include "BasicStepperDriver.h"
#include "MultiDriver.h"
#include "SyncDriver.h"
#define MICROSTEPS 32
#define MOTOR_STEPS 200

int servoPin[4] = {10, 11, 12, 13};
BasicStepperDriver stepper1(MOTOR_STEPS, 2, 3);
BasicStepperDriver stepper2(MOTOR_STEPS, 4, 5);
BasicStepperDriver stepper3(MOTOR_STEPS, 6, 7);
BasicStepperDriver stepper4(MOTOR_STEPS, 8, 9);
//
SyncDriver stepper1_3(stepper1, stepper3);
SyncDriver stepper2_4(stepper2, stepper4);

Servo servo[4];
void setup() {
  Serial.begin(115200);
  for (int x = 0; x < 2; x++) {
    for (int i = 0; i < 4; i++) {
      servo[i].attach(servoPin[i]);
      servo[i].write(0);
    }
  }
  stepper1.begin(30, MICROSTEPS);
  stepper2.begin(30, MICROSTEPS);
  stepper3.begin(30, MICROSTEPS);
  stepper4.begin(30, MICROSTEPS);
}

void loop() {


}
