function ptr1d(res); %显示一维极大值表示
%clf;
hold on;                 %当前轴及图形保持而不被刷新，准备接受此后将绘制
[m,n]=size(res);         %显示出每一个数值点的幅值以及位置
for i=1:m,
	coef=max(abs(res(i,:))); %取极值点的大小，coef=参数
	if (coef>0)
		affich=res(i,:)/((2*coef)+0.1) + i; %affich=显示
		plot(affich,'k');
		%stem(affich,'k');
	else
		affich=zeros(1,length(res(i,:))) + i; 
		plot(affich,'k:');
	end;

end;