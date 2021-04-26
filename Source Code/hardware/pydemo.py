import pygame
import pygame.camera
from PIL import Image

pygame.init()
pygame.camera.init()

cam = pygame.camera.Camera("/dev/video0", (75, 75))
cam.start()

img = cam.get_image()
strimg = pygame.image.tostring(img, "RGBA", False)

fimg = Image.frombytes("RGBA", (75, 75), bytes(strimg))
print(fimg)
fimg.show()