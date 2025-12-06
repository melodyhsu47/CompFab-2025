import numpy as np
import math
from image_processing import Stippler
import matplotlib.pyplot as plt
import time

start_time = time.perf_counter()

s = Stippler()

# test files:
# '/Users/melodyhsu/Desktop/alice.jpg'
# '/Users/melodyhsu/Desktop/apple.png'
# '/Users/melodyhsu/Desktop/trees.jpg'
# '/Users/melodyhsu/Desktop/red-fox.jpg'
# '/Users/melodyhsu/Desktop/bird.jpeg'

greyscale_image = s.process('/Users/melodyhsu/Desktop/bonsai.jpg',300)

stippled_points = s.macqueen(greyscale_image,600)

path, _ = s.tsp_path(stippled_points)

np.savetxt("path_drawing/points.csv",stippled_points,delimiter=',',fmt='%.3f')

np.savetxt("path_drawing/path.csv",path,delimiter=',',fmt='%d')

px = [p[0] for p in stippled_points]
py = [p[1] for p in stippled_points]

end_time = time.perf_counter()
elapsed = end_time-start_time
print(elapsed)

plt.scatter(px,py,s=1)
plt.savefig("pointfig.png")
plt.show()


# fox: 1111 seconds
# tree: 846 seconds
































