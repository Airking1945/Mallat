function y = rshift(x)
	n = length(x);
	y = [ x(n) x( 1: (n-1) )];

