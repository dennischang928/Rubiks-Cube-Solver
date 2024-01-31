#include <Arduino.h>
#include <Servo.h>
#include "BasicStepperDriver.h"
#include "MultiDriver.h"
#include "SyncDriver.h"
#define MICROSTEPS 16
#define MOTOR_STEPS 200

char input = ' ';
int encoder_value[4];
boolean finishhome = false;
struct Send
{
  int en_cen_value[4] = {

      424, 600, 583, 676};
};

Send setting;
int servoPin[4] = {10, 11, 12, 13};
byte encoderPin[4] = {A5, A4, A0, A1};
BasicStepperDriver stepper1(MOTOR_STEPS, 2, 3);
BasicStepperDriver stepper2(MOTOR_STEPS, 4, 5);
BasicStepperDriver stepper3(MOTOR_STEPS, 6, 7);
BasicStepperDriver stepper4(MOTOR_STEPS, 8, 9);
//
SyncDriver stepper1_3(stepper1, stepper3);
SyncDriver stepper2_4(stepper2, stepper4);

Servo servo[4];

void setup()
{
  Serial.begin(115200);
  for (int x = 0; x < 2; x++)
  {
    for (int i = 0; i < 4; i++)
    {
      pinMode(encoderPin[i], INPUT);
      servo[i].attach(servoPin[i]);
      servo[i].write(88);
    }
  }

  stepper1.begin(40, MICROSTEPS);
  stepper2.begin(40, MICROSTEPS);
  stepper3.begin(40, MICROSTEPS);
  stepper4.begin(40, MICROSTEPS);
  stepper1_3.setMicrostep(16);
  stepper2_4.setMicrostep(16);
}

void loop()
{
  if (Serial.available() > 0)
  {
    input = Serial.read();
  }
  if (input == 'C' || input == 'c')
  {
    calbration(encoder_value);
    input = NULL;
  }
  else if (input == 'H' || input == 'h')
  {
    // finishhome = false;
    // if (finishhome == false)
    // {
    boolean homing[4];
    for (int i = 0; i < 4; i++)
    {
      homing[i] = center(i);
    }

    int x = 0;
    for (int i = 0; i < 4; i++)
    {
      if (homing[i] = true)
      {
        x++;
      }
    }
    if (x == 4)
    {
      for (int i = 0; i < 4; i++)
      {
        servo[i].write(10);
      }
      delay(7000);
      for (int i = 0; i < 4; i++)
      {
        servo[i].write(88);
      }
      input = ' ';
    }
  }
  else
  {
    for (int i = 0; i < 4; i++)
    {
      encoder_value[i] = analogRead(encoderPin[i]);
      Serial.print(setting.en_cen_value[i]);
      Serial.print(",");
    }
    Serial.println("");
  }

  Serial.println("");
}

void calbration(int env[4])
{
  for (int i = 0; i < 4; i++)
  {
    setting.en_cen_value[i] = env[i];
  }
}

boolean center(int module)
{
  int encoder_angle = 0;
  if (module == 0)
  {
    Serial.println("hi");
    boolean Homed = false;
    for (int i = 0; i < 4; i++)
    {
      servo[i].write(88);
    }
    servo[module].write(40);
    for (int i = 0; i < 3200; i += 1)
    {
      if (Homed == false)
      {
        stepper1_3.move(i, 0);
      }
      encoder_angle = analogRead(encoderPin[module]);
      if (abs(setting.en_cen_value[module] - encoder_angle) < 10)
      {
        Homed = true;
        return (true);
      }
      else
      {
        Serial.println(encoder_angle);
      }
    }
  }
  if (module == 1)
  {
    Serial.println("hi");
    boolean Homed = false;
    for (int i = 0; i < 4; i++)
    {
      servo[i].write(88);
    }
    servo[module].write(20);
    for (int i = 0; i < 3200; i += 1)
    {
      if (Homed == false)
      {
        stepper2_4.move(i, 0);
      }
      encoder_angle = analogRead(encoderPin[module]);
      if (abs(setting.en_cen_value[module] - encoder_angle) < 10)
      {
        Homed = true;
        return (true);
      }
      else
      {
        Serial.println(encoder_angle);
      }
    }
  }
  if (module == 2)
  {
    Serial.println("hi");
    boolean Homed = false;
    for (int i = 0; i < 4; i++)
    {
      servo[i].write(88);
    }
    servo[module].write(20);
    for (int i = 0; i < 3200; i++)
    {
      if (Homed == false)
      {
        stepper1_3.move(0, (i));
      }
      encoder_angle = analogRead(encoderPin[module]);
      (300);
      if (abs(setting.en_cen_value[module] - encoder_angle) < 10)
      {
        Homed = true;
        return (true);
      }
      else
      {
        Serial.println(encoder_angle);
      }
    }
  }
  if (module == 3)
  {
    Serial.println("hi");
    boolean Homed = false;
    for (int i = 0; i < 4; i++)
    {
      servo[i].write(88);
    }
    servo[module].write(20);
    for (int i = 0; i < 3200; i++)
    {
      if (Homed == false)
      {
        stepper2_4.move(0, (i));
      }
      encoder_angle = analogRead(encoderPin[module]);
      if (abs(setting.en_cen_value[module] - encoder_angle) < 10)
      {
        Homed = true;
        return (true);
      }
      else
      {
        Serial.println(encoder_angle);
      }
    }
  }
}