function y = lshift(x)
	n = length(x);
	y = [x(2:n)  x(1)];

