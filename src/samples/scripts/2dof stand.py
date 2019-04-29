#!/usr/bin/env python3

from adafruit_servokit import ServoKit
kit = ServoKit(channels=16)

#head
kit.servo[15].angle = 90
kit.servo[14].angle = 90

#front left
kit.servo[13].angle = 90 - 45
kit.servo[12].angle = 90 - 45

#front right
kit.servo[11].angle = 90 + 45
kit.servo[10].angle = 90 + 45

#rear right
kit.servo[ 9].angle = 90 + 45
kit.servo[ 8].angle = 90 + 45

#rear left
kit.servo[ 7].angle = 90 - 45
kit.servo[ 6].angle = 90 - 45

