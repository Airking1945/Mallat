%2D code
img=double(imread('house256.bmp'));

img2=(img(:,:,1)+img(:,:,2)+img(:,:,3))/3;

wc=mallat2d(img2,4,0); %Decomposition into 4 levels of Wavelet

%If you want to apply a direct wavelet reconstruction you can use

rec=mallat2d(wc,4,1);

imagesc(rec);

%You have a perfect reconstruction rec==img2

mx=max2d(wc,4); %Detection of 2D wavelet maxima see the comment of the function

%To see the maxima at scale 2 for example
imagesc(abs(mx(2).dligne+i*mx(2).dcolone));


sb=edge_2d(mx,30,4); %Reconstruction from the maxima (4 scales) with 30 iteraions
%In this Matlab version I have some problem with border effect. I have no
%problem with my C code

figure(1)
imagesc(sb)
colormap(gray)

