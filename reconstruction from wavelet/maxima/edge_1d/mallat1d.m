% AUTHOR: P. Carre XLIM Lab. CNRS 7252 University of Poitiers, France
%         philippe.carre@univ-poitiers.fr
%
% 2010
%

function res=mallat1d(s,l,sens)
% function resultat=mallat1d(signal,L,sens)
% algorithm of decomposition or reconstruction of multisclale gradient
% l : the number of sclae
% sens 0 forward 1 backward         %sens值为0时为正分解，sens值为1时为逆还原
% if sens ==0 res is a matrix that contians the different scales
% res(i) = resolution i
% otherwise res is the reconstructed signal
 
if sens==0
%forward
n=length(s);%length()函数得到该数组的长度，即mallat信号的长度，然后把它放到tmp
tmp=s;
%res=s';   %decomposition
res=[];
qmf=[0 0 0.125 0.375 0.375 0.125 0]; %低通滤波器
qmfb=[0 0 0 -5 5 0 0];               %高通滤波器
for i=1:l
        tmpb = tmp;                             %赋予初值s的长度
        tmp = symm_aconv(qmf,tmp);              %低通
        tmpb = symm_iconv(qmfb,lshift(tmpb));   %高通

	res=[res tmpb'];

         %Dilatation du filtre
	qmf=upsample(qmf);
        qmf=qmf(1:(length(qmf)-1));
        qmfb=upsample(qmfb);
        qmfb=qmfb(1:(length(qmfb)-1));
end;
res = [ res tmp']; %获得一个具有两个元素的数组 %"'"求转置
res=res';

else
% inverse     %reconstruction%
qqmf=[0 0 0.125 0.375 0.375 0.125 0];                                             %低通滤波器
qmfb=-1*[0 0.0078125 0.054685 0.171875 -0.171875 -0.054685 -0.0078125 ];          %高通滤波器
trame=s(l+1,:);

for i=l:-1:1                          %对每个重建的像素点进行上采样
	f=qqmf;f2=qmfb;                   
        if (i>1)
	   for j=1:(i-1)
             f=upsample(f);           %上采样
            f2=upsample(f2);          %再次进行上采样
            f =f(1:(length(f)-1));    
            f2=f2(1:(length(f2)-1));
	   end;
        end;
        c =  symm_iconv(f, trame );
        detail=s(i,:);
        w = symm_aconv( f2, rshift( detail ) );
        trame=(c+w);
end;
 res=trame;                           %返回高通
end;

