% Code 1D

load mallat.txt

res=mallat1d(mallat(:)',4,0); % 4 scales for the gradient representation

ptr1d(res)%Shows the decomposition 

mx=max_1d(res); %Extraction of Maxima

ptr1d(mx); %Shows the maxima representation

sb=edge_w(mx,20); % Reconstruction with 20 iterations

figure(2)

plot(sb);

clear all


