function ptr1d(res); %��ʾһά����ֵ��ʾ
%clf;
hold on;                 %��ǰ�ἰͼ�α��ֶ�����ˢ�£�׼�����ܴ˺󽫻���
[m,n]=size(res);         %��ʾ��ÿһ����ֵ��ķ�ֵ�Լ�λ��
for i=1:m,
	coef=max(abs(res(i,:))); %ȡ��ֵ��Ĵ�С��coef=����
	if (coef>0)
		affich=res(i,:)/((2*coef)+0.1) + i; %affich=��ʾ
		plot(affich,'k');
		%stem(affich,'k');
	else
		affich=zeros(1,length(res(i,:))) + i; 
		plot(affich,'k:');
	end;

end;