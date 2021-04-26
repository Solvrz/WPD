from knn import model, predict
from server import upload #needs internet
import RPi.GPIO as gpio
import time, random, datetime, os, pygame
from arduino import get_vals
import numpy as np

pygame.init()
pygame.font.init()

font = pygame.font.SysFont("comicsans", 50)
desFont = pygame.font.SysFont("comicsans", 25)

win = pygame.display.set_mode((400, 400))
win.fill((255, 255, 255))

DMOTOR = {
    "IN1": 13,
    "IN2": 15,
    "EN": 11
}

SOL = {
    "IN1": 18,
    "IN2": 16,
    "IN3": 37,
    "IN4": 24,
    "IN5": 35
}

VMOTOR = 40
SERVO = 33

BUTTON = 32

mp = None

ec = cond = turb = temp = 0

def draw_window(progress, des=None):
    win.fill((11, 65, 198))

    if progress != 100:
        #Progress bar
        pygame.draw.rect(win, (0, 0, 0), (71, 297, 259, 57))
        pygame.draw.rect(win, (255, 255, 255), (75, 300, 250, 50))
        pygame.draw.rect(win, (255, 0, 0), (75, 300, 250 * (progress / 100), 50))

        text = font.render(str(int(progress)) + "%", 1, (0, 0, 0))

        win.blit(text, (145 + text.get_width() / 2, 325 - text.get_height() / 2))

        description = desFont.render(des, 1, (11, 11, 11))

        win.blit(description, (162.5 -  description.get_width() / 4, 285 - description.get_height() / 2))

    else:
        f = pygame.font.SysFont("comicsans", 25)
        text = f.render("All processes have been completed! NORA", 1, (0, 0, 0))


        win.blit(text, (200 - text.get_width() / 2, 200 - text.get_height() / 2))

    pygame.display.update()

def initBoard():
    global mp

    gpio.setmode(gpio.BOARD)

    print("BUTTON HAS BEEN INIT")
    gpio.setup(BUTTON, gpio.IN, pull_up_down=gpio.PUD_UP)

    gpio.setup(DMOTOR["IN1"], gpio.OUT)
    gpio.setup(DMOTOR["IN2"], gpio.OUT)
    gpio.setup(DMOTOR["EN"], gpio.OUT)

    gpio.output(DMOTOR["IN1"], gpio.LOW)
    gpio.output(DMOTOR["IN2"], gpio.LOW)

    gpio.setup(SOL["IN1"], gpio.OUT)
    gpio.setup(SOL["IN2"], gpio.OUT)
    gpio.setup(SOL["IN3"], gpio.OUT)
    gpio.setup(SOL["IN4"], gpio.OUT)
    gpio.setup(SOL["IN5"], gpio.OUT)

    gpio.output(SOL["IN1"], gpio.HIGH)
    gpio.output(SOL["IN2"], gpio.HIGH)
    gpio.output(SOL["IN3"], gpio.HIGH)
    gpio.output(SOL["IN4"], gpio.HIGH)
    gpio.output(SOL["IN5"], gpio.HIGH)

    mp = gpio.PWM(DMOTOR["EN"], 1000)
    mp.start(0)

    gpio.setup(VMOTOR, gpio.OUT)
    gpio.output(VMOTOR, gpio.LOW)

def send_water(ph, progress):
    global ec, cond, turb, temp

    date = datetime.datetime.now()
    data = {"date":str(datetime.date.today()), "time":str(date.hour)+":"+str(date.minute), "pH":str(ph), "Cond":str(ec), "Temp":str(temp), "ppm":str(ppm)}

    if 6.4 < ph < 8.6:
        draw_window(progress, "Water is suitable for drinking")
        data["description"] = "This water could be used for drinking or cooking purposes"
        upload(data, "history")
        solenoid3()

    elif 8.5 < ph < 11.1:
        draw_window(progress, "Water is being sent for agriculture")
        data["description"] = "This water could be used in agricultural works. It will work as a fertilizer in acidic soil"
        upload(data, "history")
        solenoid4()

    else:
        draw_window(progress, "Water is being sent to houses")
        data["description"] = "This water should be used in household cleaning purposes like moppingthe floor, cleaning windows, etc."
        upload(data, "history")
        solenoid5()

def dropperMotor():
    global mp

    print("DROPPER ACTIVATED!")

    mp.ChangeDutyCycle(100)

    gpio.output(DMOTOR["IN1"], gpio.HIGH)
    gpio.output(DMOTOR["IN2"], gpio.LOW)

    time.sleep(5)

    gpio.output(DMOTOR["IN1"], gpio.LOW)
    gpio.output(DMOTOR["IN2"], gpio.LOW)

    mp.ChangeDutyCycle(0)

    time.sleep(2)

def dropperMotorRev():
    global p

    print("DROPPER ACTIVATED!")

    p = gpio.PWM(DMOTOR["EN"], 1000)
    p.start(100)

    gpio.output(DMOTOR["IN1"], gpio.LOW)
    gpio.output(DMOTOR["IN2"], gpio.HIGH)

    time.sleep(15)

    gpio.output(DMOTOR["IN1"], gpio.LOW)
    gpio.output(DMOTOR["IN2"], gpio.LOW)

    time.sleep(2)

def solenoid1():
    global ec, ppm, turb, temp

    print("SOLENOID1 ACTIVATED")

    gpio.output(SOL["IN2"], gpio.LOW)
    gpio.output(SOL["IN1"], gpio.HIGH)
    gpio.output(SOL["IN3"], gpio.HIGH)
    gpio.output(SOL["IN4"], gpio.HIGH)
    gpio.output(SOL["IN5"], gpio.HIGH)

    time.sleep(9)

    gpio.output(SOL["IN2"], gpio.HIGH)

    print("TURNING OFF SOLENOID1")

    time.sleep(2)

    ec, ppm, turb, temp = get_vals()

def solenoid2():
    print("SOLENOID2 ACTIVATED")

    gpio.output(SOL["IN1"], gpio.LOW)
    gpio.output(SOL["IN2"], gpio.HIGH)
    gpio.output(SOL["IN3"], gpio.HIGH)
    gpio.output(SOL["IN4"], gpio.HIGH)
    gpio.output(SOL["IN5"], gpio.HIGH)

    time.sleep(10)

    gpio.output(SOL["IN1"], gpio.HIGH)

def solenoid3():
    print("SOLENOID3 ACTIVATED")

    gpio.output(SOL["IN1"], gpio.HIGH)
    gpio.output(SOL["IN2"], gpio.HIGH)
    gpio.output(SOL["IN3"], gpio.LOW)
    gpio.output(SOL["IN4"], gpio.HIGH)
    gpio.output(SOL["IN5"], gpio.HIGH)

    time.sleep(20)

    gpio.output(SOL["IN3"], gpio.HIGH)

def solenoid4():
    print("SOLENOID4 ACTIVATED")

    gpio.output(SOL["IN1"], gpio.HIGH)
    gpio.output(SOL["IN2"], gpio.HIGH)
    gpio.output(SOL["IN3"], gpio.HIGH)
    gpio.output(SOL["IN4"], gpio.LOW)
    gpio.output(SOL["IN5"], gpio.HIGH)

    time.sleep(20)

    gpio.output(SOL["IN4"], gpio.HIGH)

def solenoid5():
    print("SOLENOID5 ACTIVATED")

    gpio.output(SOL["IN1"], gpio.HIGH)
    gpio.output(SOL["IN2"], gpio.HIGH)
    gpio.output(SOL["IN3"], gpio.HIGH)
    gpio.output(SOL["IN4"], gpio.HIGH)
    gpio.output(SOL["IN5"], gpio.LOW)

    time.sleep(20)

    gpio.output(SOL["IN5"], gpio.HIGH)

def vibratorMotor():
    print("VIBRATOR ACTIVATED")

    gpio.output(VMOTOR, gpio.HIGH)

    time.sleep(15)

    gpio.output(VMOTOR, gpio.LOW)

def inpCamera():
    try:
        import cv2
    except:
        os.system("sudo apt-get purge python3-opencv opencv-data")
        os.system("sudo apt-get install python3-opencv opencv-data")
        import cv2

    print("CAMERA ACTIVATED")
    cap = cv2.VideoCapture(0)
    try:
        _, frame = cap.read()
        cv2.imshow("frame", frame)

        cv2.waitKey(2000)
        cv2.destroyAllWindows()

        ph = predict(frame, model)
        print(f"The pH is {ph}")

    except:
        os.system("sudo apt-get purge python3-opencv opencv-data")
        os.system("sudo apt-get install python3-opencv opencv-data")
        import cv2

        _, frame = cap.read()
        cv2.imshow("frame", frame)

        cv2.waitKey(2000)
        cv2.destroyAllWindows()

        ph = predict(frame, model)
        print(f"The pH is {ph}")

    cap.release()

    return ph

def main():
    actions = [(solenoid1, 11, "1st Solenoid"), (dropperMotor, 7, "Dropper"), (vibratorMotor, 20, "Mixer"), (inpCamera, 4, "Camera"), (solenoid2, 10, "2nd Solenoid"), (send_water, 20, "")]

    run = True
    progress = 0

    action_no = 0
    time_spent = 0

    total_time = 72

    result = "6"

    while run:
        pygame.time.delay(10)

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                run = False
                break

        if action_no == len(actions):
            draw_window(progress)
        else:
            draw_window(progress, actions[action_no][2] + " activated!")

        if action_no < len(actions):
            if actions[action_no][0] == send_water:
                send_water(float(int(result)), progress)
            else:
                out = actions[action_no][0]()

                if type(out) == str:
                    result = out

            time_spent += actions[action_no][1]

            progress = (time_spent / total_time) * 100

            action_no += 1

if __name__ == "__main__":
    try:
        initBoard()
     #dropperMotorRev()

        gpio.wait_for_edge(BUTTON, gpio.FALLING)

        time.sleep(0.5)

        while True:
            if gpio.input(BUTTON):
                main()
                break

    finally:
        gpio.cleanup()