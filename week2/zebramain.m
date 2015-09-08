clear all;
img = imread('zebra_1.tif');
imhist(img)
figure(1)
img = img(:,:,1);
imshow(img);


img1 = glcm(img, 8);

figure(2)
imshow(img1)


%{
First, try to implement your own GLCM function that takes as input an image
window and number of image greyscales and outputs a co-occurence matrix.
Derive variance, contrast and entropy from the GLCM of a sliding window at a
suitable size.
Try to use a simple tresholding of these features to mask out the zebras in the
images.
Then compare your result with the first order texture measures: variance and
entropy by using the Matlab functions: stdfilt and entropyfilt.
If you have time, try to use Laws texture masks to analyze the image with a
suitable mask or two. Remember to average energy over windows. Laws masks
can be built and applied with conv2 function in Matlab. 
%}