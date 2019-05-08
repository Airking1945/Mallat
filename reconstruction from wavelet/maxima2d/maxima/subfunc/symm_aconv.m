function y = symm_aconv(sf,x)
% a classical filtering by periodic convolution (with time reverse of sf for perfect reconstruction with wavelet algorithm) 
	n = length(x);
	p = length(sf);
	if p < n,
	   xpadded = [x x(1:p)];
	else
	   z = zeros(1,p);
	   for i=1:p,
		   imod = 1 + rem(i-1,n);
		   z(i) = x(imod);
	   end
	   xpadded = [x z];
	end

	fflip = reverse(sf);
	ypadded = filter(fflip,1,xpadded);

	if p < n,
		y = [ypadded((n+1):(n+p)) ypadded((p+1):(n))];
	else
	    for i=1:n,
		   imod = 1 + rem(p+i-1,n);
		   y(imod) = ypadded(p+i);
	    end
	end

	shift = (p-1)/ 2 ;
	shift = 1 + rem(shift-1, n);
	y = [y((1+shift):n) y(1:(shift))] ;

