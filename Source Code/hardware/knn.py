import numpy as np
import pickle, os

try:
    import cv2
except:
    os.system("sudo apt-get purge python3-opencv opencv-data")
    os.system("sudo apt-get install python3-opencv opencv-data")
    import cv2

from PIL import Image
from sklearn.neighbors import KNeighborsClassifier as KNN
from sklearn.metrics import accuracy_score

model = pickle.load(open("knn.pickle", "rb"))

def predict(data, model, size=75):
    data = Image.fromarray(data)
    px = data.load()
    img = data.convert(mode="L")
    img.thumbnail((size, size))

    img = np.array(px[38, 38]).reshape(-1, 1)

    pred = model.predict(img)

    return pred[0]