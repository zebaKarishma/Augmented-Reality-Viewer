# Augmented-Reality-Viewer
A simple augmented reality viewer that displays artificial objects overlaid on images of real 3D scene

Its an offline implementation using COLMAP, RANSAC and 3D to 2D transfomations of world and camera coordinate systems.

To execute this app, run main file in the project folder.
It inturn calls RANSAC routine and transform file to achieve all mentioned tasks of the project.

Directory structure:
-------------------------
- src (Contains all the code files)
    1) main.m       - drive code to call all the routines
    2) Ransac2.m    - ransac implementation
    3) box.m        - Creation of 3D virtual object
    4) transform.m  - Transformation of 3D virtual object to scene coordinates
    5) integrate.m  - 3D to 2D projection of inliers and box coordinates
    6) draw2Dbox.m  - formation of 2D box surfaces
- colmap_model (Contains the output of COLMAP)
    1) cameras.txt  - Contains intrinsic camera parameters
    2) images.txt   - Contains extrinsic camera parameters
    3) points3D.txt - 3D points outputted by COLMAP
    4) project      - configuration settings file of colmap
    5) col_img      - Image showing the point cloud formed by COLMAP

- images (Dataset used for the project - Contains 17 images of study table)



