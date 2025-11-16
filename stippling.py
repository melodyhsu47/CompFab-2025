import numpy as np
import math
from image_processing import Stippler
import matplotlib.pyplot as plt

s = Stippler()

# test files:
# '/Users/melodyhsu/Desktop/alice.jpg'
# '/Users/melodyhsu/Desktop/apple.png'

greyscale_image = s.process('/Users/melodyhsu/Desktop/apple.png',200)

stippled_points = s.macqueen(greyscale_image,300)

path, _ = s.tsp_path(stippled_points)

np.savetxt("points.csv",stippled_points,delimiter=',',fmt='%.3f')

np.savetxt("path.csv",path,delimiter=',',fmt='%d')

#print(path[:30])

#px = [p[0] for p in stippled_points]
#py = [p[1] for p in stippled_points]

#plt.scatter(px,py,s=1)
#plt.show()
































