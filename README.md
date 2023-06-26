# eye-blood-vessels
This repository contains a MATLAB script that implements a pipeline for image processing, mainly for feature extraction and enhancement. The aim is to prepare the image for further analysis or processing tasks.
# Description
The steps followed by this script are:

Image reading: The script reads the image from the specified location.

Green channel extraction: The green channel of the image is extracted for further processing as it generally gives the best contrast for vessel visualization.

Thresholding and Masking: The script performs thresholding on the image and generates a mask using erosion.

Image Filtering and Equalization: The image is first filtered using Gaussian filtering to reduce noise, and then the script performs contrast enhancement using the CLAHE method.

Homomorphic Filtering: The script applies homomorphic filtering to the image, reducing the effect of illumination and increasing the visibility of features.

Frangi Filtering: The script applies Frangi filtering to highlight tubular structures (like blood vessels) in the image.

Image Adjustment and Masking: The output is adjusted and further thresholding is applied to refine the mask.

Noise Removal and Image Smoothing: Finally, the script removes noise points, fills up broken lines, and performs morphological operations like erosion and diffusion filtering.

The script will display intermediate and final results.

Dependencies
The script is implemented in MATLAB and uses the following MATLAB functions:

Make sure you have the required MATLAB version and Image Processing Toolbox installed in your MATLAB environment.

##  Usage
To use this script, replace the path of the test image in the imread function with the path of your own image and run the script. The script will process the image and display the result at each step.

##  matlab
Copy code
image = imread('Your image path here');
Please note that the script assumes the input image is an RGB image.

##  Contribute
Feel free to fork this project, make your changes, or propose a pull request if you have improvements to suggest.

##  License
This project is under the MIT license.
