function y = symm_aconv(sf,x)
% a classical filtering by periodic convolution (with time reverse of sf
% for perfect reconstruction with wavelet algorithm) ��ͨ�������Ծ���ľ����˲�������С���㷨�������ع���sf��ʱ�䷴ת����
	n = length(x);                      %ȡҪ���о�����źų���x
	p = length(sf);                     %ȡС���ĳ���sf
	if p < n
	   xpadded = [x x(1:p)];            %��Ҫ���о���ĵ��źŽ��мӳ���n+p-1
	else
	   z = zeros(1,p);
	   for i=1:p
		   imod = 1 + rem(i-1,n);       %rem���������  ׼������ѭ����������飬p
		   z(i) = x(imod);
	   end
	   xpadded = [x z];
	end

	fflip = reverse(sf);                %reverse()������ת�ַ�������sf�ַ����е��ַ�˳����з�ת
	ypadded = filter(fflip,1,xpadded);  %filter()����1ά�����˲������˲����̼���� 

	if p < n                           %��������˳�򣬰�n��n+p���ַ���p��n�����е��ַ�����һ��˳��
		y = [ypadded((n+1):(n+p)) ypadded((p+1):(n))];
	else
	    for i=1:n
		   imod = 1 + rem(p+i-1,n);     %
		   y(imod) = ypadded(p+i);
	    end
	end

	shift = (p-1)/ 2 ;                 %ȡ��ͨ��һ����
	shift = 1 + rem(shift-1, n);
	y = [y((1+shift):n) y(1:(shift))] ;

