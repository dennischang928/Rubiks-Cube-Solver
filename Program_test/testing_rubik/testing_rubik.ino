/*
   Multi-motor control (experimental)

   Move two or three motors at the same time.
   This module is still work in progress and may not work well or at all.

   Copyright (C)2017 Laurentiu Badea

   This file may be redistributed under the terms of the MIT license.
   A copy of this license has been included with this distribution in the file LICENSE.
*/
#include <Arduino.h>
#include "BasicStepperDriver.h"
#include "MultiDriver.h"
#include "SyncDriver.h"
#include <Wire.h>
#include <AS5600.h>
#ifdef ARDUINO_SAMD_VARIANT_COMPLIANCE
#define SERIAL SerialUSB
#define SYS_VOL   3.3
#else
#define SERIAL Serial
#define SYS_VOL   5
#endif

AMS_5600 ams5600;

int ang, lang = 0;

// Motor steps per revolution. Most steppers are 200 steps or 1.8 degrees/step
#define MOTOR_STEPS 200
// Target RPM for X axis motor
#define MOTOR_X_RPM 60
// Target RPM for Y axis motor
#define MOTOR_Y_RPM 60

// X motor
#define DIR_X 2
#define STEP_X 3

// Y motor
#define DIR_Y 4
#define STEP_Y 5

// If microstepping is set externally, make sure this matches the selected mode
// 1=full step, 2=half step etc.
#define MICROSTEPS 16

// 2-wire basic config, microstepping is hardwired on the driver
// Other drivers can be mixed and matched but must be configured individually
BasicStepperDriver stepperX(MOTOR_STEPS, DIR_X, STEP_X);
BasicStepperDriver stepperY(MOTOR_STEPS, DIR_Y, STEP_Y);

// Pick one of the two controllers below
// each motor moves independently, trajectory is a hockey stick
// MultiDriver controller(stepperX, stepperY);
// OR
// synchronized move, trajectory is a straight line
SyncDriver controller(stepperX, stepperY);

void setup() {
  /*
     Set target motors RPM.
  */
  SERIAL.begin(115200);
  Wire.begin();
  SERIAL.println(">>>>>>>>>>>>>>>>>>>>>>>>>>> ");
  stepperX.begin(MOTOR_X_RPM, MICROSTEPS);
  stepperY.begin(MOTOR_Y_RPM, MICROSTEPS);
  // if using enable/disable on ENABLE pin (active LOW) instead of SLEEP uncomment next two lines
  // stepperX.setEnableActiveState(LOW);
  // stepperY.setEnableActiveState(LOW);
}
float convertRawAngleToDegrees(word newAngle)
{
  /* Raw data reports 0 - 4095 segments, which is 0.087 of a degree */
  float retVal = newAngle * 0.087;
  ang = retVal;
  return ang;
}
void loop()
{
  SERIAL.println(String(convertRawAngleToDegrees(ams5600.getRawAngle()), DEC));
  //  for (int i = 0; i < 4; i++) {
  controller.rotate(360, 360);
  //  while (1);
  //  controller.rotate(0, 0);
  //    delay(1000);
  //  }
  delay(1000);
  //  controller.rotate(-90 * 5, -30 * 15);
  //  delay(1000);
  //  controller.rotate(0, -30 * 15);
  //    delay(30000);
}
