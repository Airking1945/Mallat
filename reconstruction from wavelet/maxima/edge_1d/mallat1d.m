% AUTHOR: P. Carre XLIM Lab. CNRS 7252 University of Poitiers, France
%         philippe.carre@univ-poitiers.fr
%
% 2010
%

function res=mallat1d(s,l,sens)
% function resultat=mallat1d(signal,L,sens)
% algorithm of decomposition or reconstruction of multisclale gradient
% l : the number of sclae
% sens 0 forward 1 backward         %sensֵΪ0ʱΪ���ֽ⣬sensֵΪ1ʱΪ�滹ԭ
% if sens ==0 res is a matrix that contians the different scales
% res(i) = resolution i
% otherwise res is the reconstructed signal
 
if sens==0
%forward
n=length(s);%length()�����õ�������ĳ��ȣ���mallat�źŵĳ��ȣ�Ȼ������ŵ�tmp
tmp=s;
%res=s';   %decomposition
res=[];
qmf=[0 0 0.125 0.375 0.375 0.125 0]; %��ͨ�˲���
qmfb=[0 0 0 -5 5 0 0];               %��ͨ�˲���
for i=1:l
        tmpb = tmp;                             %�����ֵs�ĳ���
        tmp = symm_aconv(qmf,tmp);              %��ͨ
        tmpb = symm_iconv(qmfb,lshift(tmpb));   %��ͨ

	res=[res tmpb'];

         %Dilatation du filtre
	qmf=upsample(qmf);
        qmf=qmf(1:(length(qmf)-1));
        qmfb=upsample(qmfb);
        qmfb=qmfb(1:(length(qmfb)-1));
end;
res = [ res tmp']; %���һ����������Ԫ�ص����� %"'"��ת��
res=res';

else
% inverse     %reconstruction%
qqmf=[0 0 0.125 0.375 0.375 0.125 0];                                             %��ͨ�˲���
qmfb=-1*[0 0.0078125 0.054685 0.171875 -0.171875 -0.054685 -0.0078125 ];          %��ͨ�˲���
trame=s(l+1,:);

for i=l:-1:1                          %��ÿ���ؽ������ص�����ϲ���
	f=qqmf;f2=qmfb;                   
        if (i>1)
	   for j=1:(i-1)
             f=upsample(f);           %�ϲ���
            f2=upsample(f2);          %�ٴν����ϲ���
            f =f(1:(length(f)-1));    
            f2=f2(1:(length(f2)-1));
	   end;
        end;
        c =  symm_iconv(f, trame );
        detail=s(i,:);
        w = symm_aconv( f2, rshift( detail ) );
        trame=(c+w);
end;
 res=trame;                           %���ظ�ͨ
end;

