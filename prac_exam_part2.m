close all;
clear;
im = imread("needles_practice.png");
bw = rgb2gray(im);
bw1 = imbinarize(bw, 170/255);

im1 = (imerode(bw1, strel('square',2)));
im2 = (imerode(im1, strel('square',2)));

[L, num] = bwlabel(im2);
imshow(im2);
pause(10);
needle = iblobs(im1, 'area', [1150 1320], 'boundary');


for i=1:length(needle)
    if (needle(i).circularity > 0.85)
        needle.plot('r*');
    end
end
pause(10);

disp("Number of needle caps detected: " + num);
