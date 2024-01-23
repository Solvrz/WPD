import pickle

import numpy as np
from PIL import Image

model = pickle.load(open("knn.pickle", "rb"))


def predict(data, model, size=75):
    data = Image.fromarray(data)
    px = data.load()
    img = data.convert(mode="L")
    img.thumbnail((size, size))

    img = np.array(px[38, 38]).reshape(-1, 1)

    pred = model.predict(img)

    return pred[0]
