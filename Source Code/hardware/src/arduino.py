from pyfirmata import Arduino, util
import time

board = Arduino("/dev/ttyACM0")

iterator = util.Iterator(board)
iterator.start()

EC = board.get_pin("a:0:i")
LDR = board.get_pin("a:1:i")
LM35 = board.get_pin("a:2:i")

time.sleep(1)

def get_vals():
    ecVal = 0
    ldrVal = 0
    lmVal = 0

    for _ in range(5):
        lmVal += LM35.read()
        ecVal += EC.read()
        ldrVal += LDR.read()
        time.sleep(0.5)

    lmVal = (lmVal * 50) / 5
    ec = ((ecVal * 5) / 1024) / 5
    ecVal = (((ecVal * 5) / 1024) * 500) / 5
    ldrVal = ((37.0 / 780.0) * ldrVal) / 5

    return [round(ec, 2), round(ecVal, 2), round(ldrVal, 2), round(lmVal, 2)]
