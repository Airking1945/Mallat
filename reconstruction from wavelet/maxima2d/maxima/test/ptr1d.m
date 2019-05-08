function ptr1d(res);
%clf;
hold on;
[m,n]=size(res);
for i=1:m,
	coef=max(abs(res(i,:)));
	if (coef>0)
		affich=res(i,:)/((2*coef)+0.1) + i;
		plot(affich,'k');
		%stem(affich,'k');
	else
		affich=zeros(1,length(res(i,:))) + i;
		plot(affich,'k:');
	end;

end;