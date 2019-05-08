% AUTHOR: P. Carr? XLIM Lab. CNRS 7252 University of Poitiers, France
%         philippe.carre@univ-poitiers.fr
%
% 2010
%
function res=interpol(source,v,mx,j);    %��ֵ���������㷨
%����sourceΪԭ���ߣ�vΪƽ��������ߣ�mxΪmaxima��hjΪ������
%subfunction for the reconstruction: this is the interpolation step (for smooth the maxima)

n=length(source);                        %��source�ַ����ĳ���
res=zeros(1,n);                          %������ַ�������
exponent = 2/ 2^j;
r1 = 1/ realpow(5.8 , exponent);         %realpow��ʵ������������ݣ���5.8��exponent����%5.8?

u0=0;                                    %��ϵ����ʼ��
j0=1;
b=1;
indice=find(mx>0);                       %0��1��ֵ������
stop=0;                                  %ѭ��һ��




if length(indice)>0
% bord
% �趨�߽�
v1(1:indice(1))=zeros(1,(indice(1)));       %�趨v1�ĳ�ֵ
v1(indice(length(indice)):length(v1))=zeros(1,1+length(v1)-indice(length(indice)));

while(stop==0)
 if (b>length(indice))   %indice����=1ʱ����j1=nȻ������ѭ��
    j1=n;
    % modification pour les bords  %�޸ı߽�
    % r1=0;
    un=0;
    stop=1; 
 else                   %��indice����=0ʱ����j1=1��unΪԭ�źź����ò�ֵ�����
    j1=indice(b);
    un=source(j1)-v(j1); %sourceΪС���ֽ��õ���ԭ�źţ�vΪ�ֽ���ò�ֵ���õ���ֵ
 end;
 nn=j1-j0;   %j1��j0���ߵĲ�ֵ������j0����0, j1��ֵΪ������������������

 % interpol ƽ�����߻�
 u=zeros(1,nn+1);
 rn1 = r1;
  for i=1:nn-1
    	rn1=rn1*r1;
   end;
  r2nb2 = rn1 * rn1;
  rb1 = 1/ r1;
  rb2 = rb1 * rb1;%4
  r2 = r1 * r1;
  r2n = r2nb2 * r2;

  a0 = u0  / (1. - r2n);
  an = un  / (1. - r2n);
  u(1) = u0;
  r2nb2i = r2nb2;
  r2i = r2;
  ri = r1;
  rn_i = rn1;
  for i = 1:nn-1 
    u(i+1) = a0 * ri * (1 - r2nb2i) + an * rn_i * (1 - r2i) ;

    r2nb2i=r2nb2i*rb2;
    r2i=r2i*r2;
    ri=ri*r1;
    rn_i=rn_i*rb1;
  end;
  u(nn+1) = un;


 % calcul de gi sur linterval %�������ڵ�gi
 for x=0:(nn-1)
    res(x+j0)=v(x+j0)+u(x+1);
 end;


 j0=j1;
 u0=un;
 b=b+1;
end;
%end while des intervalles %�������
end;


