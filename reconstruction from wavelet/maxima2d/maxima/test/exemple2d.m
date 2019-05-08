%2D code
%读入原图像及获取大小  
image = imread('house256.bmp');  
%   分别读取RGB  
image_r=image(:,:,1);  
image_g=image(:,:,2);  
image_b=image(:,:,3);  
%  测试RGB输出  
subplot(2,2,1),imshow(image_r),title('Red component');    
subplot(2,2,2),imshow(image_g),title('green component');    
subplot(2,2,3),imshow(image_g),title('blue component');    
subplot(2,2,4),imshow(image),title('original image');  

img=double(imread('house256.bmp'));

img2=(img(:,:,1)+img(:,:,2)+img(:,:,3))/3;
%定义三组图像取平均

plot(img2);

wc=mallat2d(img2,4,0); 
%Decomposition into 4 levels of Wavelet

%If you want to apply a direct wavelet reconstruction you can use？？

rec=mallat2d(wc,4,1);

%rec为reconstruction的简称

imagesc(rec);
%显示使用经过标度映射的颜色的图像

%You have a perfect reconstruction rec==img2

mx=max2d(wc,4); 
%Detection of 2D wavelet maxima see the comment of the function

%To see the maxima at scale 2 for example
imagesc(abs(mx(2).dligne+i*mx(2).dcolone));
%在两尺度下求极大值


sb=edge_2d(mx,30,4); 
%Reconstruction from the maxima (4 scales) with 30 iteraions

%In this Matlab version I have some problem with border effect. I have no
%problem with my C code

figure(5)
imagesc(sb)
colormap(gray)
%查看并设置当前颜色图

