function res=mallat2d(img,l,sens);
% fonction resultat=mallat2d(img,L,sens)
% algorithme de decomposition (ou re) des bors
% L : resolution a atteindre �ﵽ�ķֱ���
% sens 0 forward 1 inverse   0 ����ֽ� 1 ����ԭ
% en retour on obtient une matrice contenant la trame
% les coef d'ondelettes sont sauve dans des fichiers
%��Ϊ��������ǵõ�һ������֡�ľ���С����ϵ���������ļ���


%coef=[1.5 1.12 1.03 1.01 1]; ϵ��
coef=ones(1,20); %ones��������ȫ1�ľ���1��20 zeros��������ȫ0�ľ���

if sens==0
[n,m]=size(img);
%��ͼƬ�ĳ��Ϳ����n��m��

trame=img;

res=struct();%�ѽ����Ϊ�ṹ����б���
%forward
qmf=[ 0 0.125 0.375 0.375 0.125 ];
%��ͨ
qmfb=[  0 -2 2  ];
%��ͨ



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

