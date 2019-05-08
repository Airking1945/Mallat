function y = symm_aconv(sf,x)
% a classical filtering by periodic convolution (with time reverse of sf
% for perfect reconstruction with wavelet algorithm) （通过周期性卷积的经典滤波（具有小波算法的完美重构的sf的时间反转））
	n = length(x);                      %取要进行卷积的信号长度x
	p = length(sf);                     %取小波的长度sf
	if p < n
	   xpadded = [x x(1:p)];            %把要进行卷积的的信号进行加长到n+p-1
	else
	   z = zeros(1,p);
	   for i=1:p
		   imod = 1 + rem(i-1,n);       %rem除后的余数  准备进行循环卷积的数组，p
		   z(i) = x(imod);
	   end
	   xpadded = [x z];
	end

	fflip = reverse(sf);                %reverse()函数反转字符串，将sf字符串中的字符顺序进行翻转
	ypadded = filter(fflip,1,xpadded);  %filter()函数1维数字滤波器，滤波过程即卷积 

	if p < n                           %调整数据顺序，把n到n+p的字符与p到n的序列的字符调换一下顺序
		y = [ypadded((n+1):(n+p)) ypadded((p+1):(n))];
	else
	    for i=1:n
		   imod = 1 + rem(p+i-1,n);     %
		   y(imod) = ypadded(p+i);
	    end
	end

	shift = (p-1)/ 2 ;                 %取低通的一半结果
	shift = 1 + rem(shift-1, n);
	y = [y((1+shift):n) y(1:(shift))] ;

