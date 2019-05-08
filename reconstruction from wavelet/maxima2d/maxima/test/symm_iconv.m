function y = symm_iconv(sf,x)
% a classical filtering by periodic convolution

	n = length(x);
	p = length(sf);
	if p <= n,
	   xpadded = [x((n+1-p):n) x];
	else
	   z = zeros(1,p);
	   for i=1:p,
		   imod = 1 + rem(p*n -p + i-1,n);
		   z(i) = x(imod);
	   end
	   xpadded = [z x];
	end
	ypadded = filter(sf,1,xpadded);
	y = ypadded((p+1):(n+p));
	
	shift = (p+1)/2;
	shift = 1 + rem(shift-1, n);
	y = [y(shift:n) y(1:(shift-1))];
	
	

%
% Copyright (c) 1995. Shaobing Chen and David L. Donoho
%     
    
    
    
%   
% Part of WaveLab version .700
% Built Friday, December 8, 1995 8:36:37 PM
% This is Copyrighted Material
% For copying permissions see copying.m
% Comments? e-mail wavelab@playfair.stanford.edu
%   
    
   
% Auto name mapping to DOS conventions  Saturday, December 9, 1995 1:46:58 PM
