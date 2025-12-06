import numpy as np
import math
import random
from PIL import Image
from python_tsp.distances import euclidean_distance_matrix
from python_tsp.heuristics import solve_tsp_local_search

class Stippler:
    def __init__(self):
        pass

    def process(self,imagepath,new_width):
        # image: filepath
        # new_width: desired new resolution of image
        img = Image.open(imagepath)
        original_width, original_height = img.size
        aspect_ratio = original_height/original_width
        new_height = int(new_width*aspect_ratio)
        resized = img.resize((new_width,new_height),Image.LANCZOS)
        resized = resized.convert('L')
        resized.save('/Users/melodyhsu/Desktop/image_new1.jpg',quality=85)

        return resized

    def macqueen(self,image,k,iters=5000):
        # image is a greyscale image object
        pixel_values = np.subtract(255,np.array(image))
        #pixel_values = np.array(image)

        # make probability distribution for image
        dist = np.ndarray.flatten(pixel_values/np.sum(pixel_values))


        # set the positions of k points;
        # - assume that the point at [i,j] has prob(dist[i,j])
        dim_y = len(pixel_values) # number of rows
        dim_x = len(pixel_values[0]) # number of columns

        values = [i for i in range(len(dist))]

        sampled_points = []
        for i in range(k):
            p_i = np.random.choice(values,p=dist)
            sampled_points.append([p_i % dim_x, dim_y-(p_i//dim_y),0])
            # each point has three elements, the i,j coordinate and resistance
            # (important for macqueen's)

        # run macqueen's to make the positions nicer

        # this table stores the "resistance" of some point

        smallest_x = 0
        smallest_y = 0

        for i in range(iters):
            beam = np.random.choice(values,p=dist)
            beam_xy = [beam % dim_x,dim_y-(beam//dim_y)]
            # just ignore if you generate a point that already exists

            closest_pt = min(sampled_points, key=lambda x: math.dist(beam_xy,x[0:2]))
            closest_ind = sampled_points.index(closest_pt)
            closest_pt[2] += 1
            closest_pt[0] = beam_xy[0]*(1/(closest_pt[2]+1)) + \
                            closest_pt[0]*(closest_pt[2]/(closest_pt[2]+1))
            closest_pt[1] = beam_xy[1]*(1/(closest_pt[2]+1)) + \
                            closest_pt[1]*(closest_pt[2]/(closest_pt[2]+1))
            sampled_points[closest_ind] = closest_pt

            smallest_x = min(closest_pt[0],smallest_x)
            smallest_y = min(closest_pt[1],smallest_y)


        # shift points to all positive if macqueen made them negative
        for p in sampled_points:
            p[0] += abs(smallest_x)
            p[1] += abs(smallest_y)


        return sampled_points

    def tsp_path(self,points):
        # points should be flattened
        dm = euclidean_distance_matrix(points)
        xopt, fopt = solve_tsp_local_search(dm)

        return xopt, fopt



    # partition the search space

























