function y = upsample(x)
% increasing the size of the signal with upsampling by adding 0
	n = length(x)*2;
	y = zeros(1,n);
	y(1:2:(n-1) )=x;

