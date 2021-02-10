'''
7.5 - forward
6.5 - backward; time - 0.1

90 degree - 1.2
'''

import RPi.GPIO as gpio
import time

gpio.setmode(gpio.BOARD)

servo = 8

gpio.setup(servo, gpio.OUT)

sp = gpio.PWM(servo, 50)
sp.start(0)

def forward():
    sp.ChangeDutyCycle(7.5)
    time.sleep(1.2)

def back():
    sp.ChangeDutyCycle(6.5)
    time.sleep(1.1)

def right():
    back()

    sp.ChangeDutyCycle(0)

    time.sleep(5)

    forward()

    sp.ChangeDutyCycle(0)

def left():
    forward()

    sp.ChangeDutyCycle(0)

    time.sleep(5)

    back()

    sp.ChangeDutyCycle(0)

'''
dirs = {"r": right, "l": left}

try:
    while True:
        inp = input("Which direction: ")

        dirs[inp[0].lower()]()
except:
    gpio.cleanup()
'''