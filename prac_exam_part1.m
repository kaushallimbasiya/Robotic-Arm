close all;
clear;
im = imread("new_work.jpg");

%1
test_img = imread("IMG_1783.jpg");
test_img = imrotate(test_img, -90);
%red
R_t=test_img(:,:,1);
Rnormal_t=double(R_t)/255;

%Green
G_t=test_img(:,:,2);
Gnormal_t=double(G_t)/255;

%Blue
B_t=test_img(:,:,3);
Bnormal_t=double(B_t)/255;

imR = Rnormal_t.^2.5;
imG = Gnormal_t.^2.5;
imB = Bnormal_t.^2.5;


imr=imR./(imR+imG+imB);
img=imG./(imR+imG+imB);

imrThings_t =imr>0.5;
imgThings_t =img>0.5;
imrThings_t = imopen(imrThings_t, strel('square', 9));
imgThings_t = imopen(imgThings_t, strel('square', 9));

r_t = iblobs(imrThings_t, 'area',[600, 3200000], 'boundary', 'touch', 0);
g_t = iblobs(imgThings_t, 'area',[600, 3200000], 'boundary', 'touch', 0);

init = [r_t , g_t];
centers = zeros(3,2);
areas_red_i = [];
for i = 1:length(r_t)
    areas_red_i(i) = r_t(i).area;
end

areas_green_i = [];
for i = 1:length(g_t)
    areas_green_i(i) = g_t(i).area;
end

for i = 1:length(init)
    centers(i, 1) = init(i).uc;
    centers(i, 2) = init(i).vc;
end
centers = sort(centers);
sort_init_i = r_t;

for i=1:length(init)
    if(double(init(i).uc) == centers(1,1) && double(init(i).vc) == centers (1,2))
        sort_init_i(1)=init(i);
    elseif(double(init(i).uc) == centers(2,1) && double(init(i).vc) == centers (2,2))
        sort_init_i(2)=init(i);
    else
        sort_init_i(3)=init(i);
    end
end


%destination image
test_img1 = imread("IMG_1777.jpg");
test_img1 = imrotate(test_img1, -90);
%red
R_t=test_img1(:,:,1);
Rnormal_t=double(R_t)/255;

%Green
G_t=test_img1(:,:,2);
Gnormal_t=double(G_t)/255;

%Blue
B_t=test_img1(:,:,3);
Bnormal_t=double(B_t)/255;

imB = Bnormal_t.^2.5;
imR = Rnormal_t.^2.5;
imG = Gnormal_t.^2.5;


imr=imR./(imR+imG+imB);
img=imG./(imR+imG+imB);

imrThings_t_d =imr>0.5;
imgThings_t_d =img>0.5;
imrThings_t_d = imopen(imrThings_t_d, strel('square', 9));
imgThings_t_d = imopen(imgThings_t_d, strel('square', 9));


r_t_d = iblobs(imrThings_t_d, 'area',[600, 3200000], 'boundary', 'touch', 0);
g_t_d = iblobs(imgThings_t_d, 'area',[600, 3200000], 'boundary', 'touch', 0);


init_d = [r_t_d , g_t_d];
centers_d = zeros(3,2);

areas_red_d = [];
for i = 1:length(r_t_d)
    areas_red_d(i) = r_t_d(i).area;
end

areas_green_d = [];
for i = 1:length(g_t_d)
    areas_green_d(i) = g_t_d(i).area;
end


for i = 1:length(init_d)
    centers_d(i, 1) = init_d(i).uc;
    centers_d(i, 2) = init_d(i).vc;
end
centers_d = sort(centers_d);
sort_init_d = r_t_d;

for i=1:length(init_d)
    if(double(init_d(i).uc) == centers_d(1,1) && double(init_d(i).vc) == centers_d(1,2))
        sort_init_d(1)=init_d(i);
    elseif(double(init_d(i).uc) == centers_d(2,1) && double(init_d(i).vc) == centers_d(2,2))
        sort_init_d(2)=init_d(i);
    else
        sort_init_d(3)=init_d(i);
    end
end


for x=1:3
    a1 = sort_init_i(x).area;
    a2 = sort_init_d(x).area;
    c1 = sort_init_i(x).circularity;
    c2 = sort_init_d(x).circularity;
    s1 = " ";
    s2 = " ";
    size1 = " ";
    size2 = " ";
    col1 = " ";
    col2 = " ";
    
    %size
    if(a1> 450000)
        size1 = "large";
    else
        size1 = "small";
    end
    
    if(a2> 450000)
        size2 = "large";
    else
        size2 = "small";
    end
    
    %shape
    if(c1>0.95)
        s1="circle";
    elseif(c1>0.7)
        s1="square";
    else
        s1="triangle";
    end
    
    if(c2>0.95)
        s2="circle";
    elseif(c2>0.7)
        s2="square";
    else
        s2="triangle";
    end
    
    %col
    if( ismember(a1,areas_green_i) )
        col1 = "green";
    else
        col1 = "red";
    end
    
    if( ismember(a2,areas_green_d) )
        col2 = "green";
    else
        col2 = "red";
    end
    
    formatSpec = "Go from: %s %s %s to: %s %s %s ";
    str = sprintf(formatSpec,size1, col1, s1 , size2, col2, s2);
    disp(str);
end


