function code=freeman(mx);
% 4 3 2
% 5   1
% 6 7 8
dim=size(mx);
ang=angle(mx);
clear mx;
ang=(ang<0)*2*pi+ang;
code=zeros(dim(1),dim(2));

b1=(ang<pi/8);
b8=(ang<15*pi/8);
code =((b1+(b8==0))>0);

clear b8
b2=(ang<3*pi/8);
code=code+b2.*(b1==0)*2;

clear b1
b3=(ang<5*pi/8);
code =code+b3.*(b2==0)*3;

clear b2
b4=(ang<7*pi/8);
code =code+b4.*(b3==0)*4;

clear b3
b5=(ang<9*pi/8);
code =code+b5.*(b4==0)*5;

clear b4
b6=(ang<11*pi/8);
code =code+b6.*(b5==0)*6;

clear b5
b7=(ang<13*pi/8);
code =code+b7.*(b6==0)*7;

clear b6
b8=(ang<15*pi/8);
code =code+b8.*(b7==0)*8;
