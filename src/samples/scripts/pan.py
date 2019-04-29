#!/usr/bin/python

import time

from adafruit_servokit import ServoKit
kit = ServoKit(channels=16)

while True:

    for i in range (60,110):
        for s in range (0,16):
            kit.servo[s].angle = i
        time.sleep(0.05)

    time.sleep(1)

    for i in range (110,60, -1):
        for s in range (0,16):
            kit.servo[s].angle = i
        time.sleep(0.025)

    time.sleep(1)