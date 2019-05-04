#!/usr/bin/python

import time

from adafruit_servokit import ServoKit
kit = ServoKit(channels=16)

while True:

    for i in range (60,110):
        kit.servo[13].angle = i
        kit.servo[11].angle = i
        kit.servo[ 9].angle = i
        kit.servo[ 7].angle = i
        time.sleep(0.05)

    time.sleep(1)

    for i in range (110,60, -1):
        kit.servo[13].angle = i
        kit.servo[11].angle = i
        kit.servo[ 9].angle = i
        kit.servo[ 7].angle = i
        time.sleep(0.025)

    time.sleep(1)