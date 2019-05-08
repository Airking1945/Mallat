% AUTHOR: P. Carr? XLIM Lab. CNRS 7252 University of Poitiers, France
%         philippe.carre@univ-poitiers.fr
%
% 2010
%
function res=interpol(source,v,mx,j);    %插值样条曲线算法
%其中source为原曲线，v为平滑后的曲线，mx为maxima，hj为横坐标
%subfunction for the reconstruction: this is the interpolation step (for smooth the maxima)

n=length(source);                        %求source字符串的长度
res=zeros(1,n);                          %给结果字符串赋零
exponent = 2/ 2^j;
r1 = 1/ realpow(5.8 , exponent);         %realpow仅实数输出的数组幂，即5.8的exponent的幂%5.8?

u0=0;                                    %各系数初始化
j0=1;
b=1;
indice=find(mx>0);                       %0或1数值的骰子
stop=0;                                  %循环一次




if length(indice)>0
% bord
% 设定边界
v1(1:indice(1))=zeros(1,(indice(1)));       %设定v1的初值
v1(indice(length(indice)):length(v1))=zeros(1,1+length(v1)-indice(length(indice)));

while(stop==0)
 if (b>length(indice))   %indice骰子=1时，则j1=n然后跳出循环
    j1=n;
    % modification pour les bords  %修改边界
    % r1=0;
    un=0;
    stop=1; 
 else                   %当indice骰子=0时，则j1=1，un为原信号和所用插值的相差
    j1=indice(b);
    un=source(j1)-v(j1); %source为小波分解后得到的原信号，v为分解后用插值所得到的值
 end;
 nn=j1-j0;   %j1和j0两者的差值，其中j0等于0, j1的值为上述两个条件所决定

 % interpol 平滑曲线化
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


 % calcul de gi sur linterval %计算间隔内的gi
 for x=0:(nn-1)
    res(x+j0)=v(x+j0)+u(x+1);
 end;


 j0=j1;
 u0=un;
 b=b+1;
end;
%end while des intervalles %结束间隔
end;


