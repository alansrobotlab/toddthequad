#!/usr/bin/python

import time

from adafruit_servokit import ServoKit
kit = ServoKit(channels=16)

offset =  [10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]


for i in range (0,16):
    kit.servo[i].angle = 90

#time.sleep(1) 