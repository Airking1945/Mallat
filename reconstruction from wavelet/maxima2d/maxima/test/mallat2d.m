function res=mallat2d(img,l,sens);
% fonction resultat=mallat2d(img,L,sens)
% algorithme de decomposition (ou re) des bors
% L : resolution a atteindre 达到的分辨率
% sens 0 forward 1 inverse   0 正向分解 1 反向还原
% en retour on obtient une matrice contenant la trame
% les coef d'ondelettes sont sauve dans des fichiers
%作为结果，我们得到一个包含帧的矩阵，小波的系数保存在文件中


%coef=[1.5 1.12 1.03 1.01 1]; 系数
coef=ones(1,20); %ones——生成全1的矩阵1×20 zeros——生成全0的矩阵

if sens==0
[n,m]=size(img);
%把图片的长和宽放入n和m中

trame=img;

res=struct();%把结果作为结构体进行保存
%forward
qmf=[ 0 0.125 0.375 0.375 0.125 ];
%低通
qmfb=[  0 -2 2  ];
%高通



for i=1:l,
	[trame,dligne,dcolone]=sousmala(trame,qmf,qmfb);
    %
	dcolone=dcolone./coef(i);
	dligne=dligne./coef(i);
    res(i).dligne=dligne;
    res(i).dcolone=dcolone;
    %phrase = ['save i' num2str(i) ' dligne dcolone;'];
	clear dligne dcolone
    % Dilatation du filtre
	qmf=upsample(qmf);
        qmf=qmf(1:(length(qmf)-1));
        qmfb=upsample(qmfb);
        qmfb=qmfb(1:(length(qmfb)-1));
end;
res(l+1).trame=trame;

else
% inverse
h=[ 0 0.125 0.375 0.375 0.125 ];
k=-1*[0 0.0078125 0.054685 0.171875 -0.171875 -0.054685 -0.0078125 ];
ll=[0.0078125 0.046875 0.1171875 0.65625 0.1171875 0.046875 0.0078125];

trame=img(l+1).trame;
[n,m]=size(trame);

for i=l:-1:1,
	fh=h;fk=k;fl=ll;
       for j=1:(i-1),
            fh=upsample(fh);
            fk=upsample(fk);
            fk=fk(1:(length(fk)-1));
            fh=fh(1:(length(fh)-1));
            fl=upsample(fl);
            fl=fl(1:(length(fl)-1));
        end;

        trame=smallat2(trame,img(i).dligne,img(i).dcolone,fh,fl,fk,coef(i));
end;
res=trame;
end;

