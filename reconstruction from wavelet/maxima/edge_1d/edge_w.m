% AUTHOR: P. Carr? XLIM Lab. CNRS 7252 University of Poitiers, France
%         philippe.carre@univ-poitiers.fr
%
% 2010
%
function sb=edge_w(decomp,nbr_boucle) %��1D��maxima�н����ν��л�ԭ%ͶӰ�㷨
%Reconstruction from 1-D maxima (decomp) with nbre_boucle iterations
% decomp is the struct that contains the maxima representation
% %decomp�����ǰ����˸���ֵ����


dim=size(decomp);       %���С���ֽ��õ����к���
n=dim(2);               %nΪ��
l=dim(1)-1;             %lΪ��
g=zeros(l+1,n);         %��g��Ϊ����ʽ���г�ʼ������
g(l+1,:)=decomp(l+1,:); %��С���ֽ�õ��Ľ���ŵ�g��
for boucl=1:nbr_boucle  %nbr_boucle is for number of loop %nbr_boucle���ظ��Ĵ���

    % projection sur t %tƽ�� is type of projection%
    for j=1:l 
        g(j,:)=interpol(decomp(j,:),g(j,:),abs(decomp(j,:)),j);
    end; % end de for des niveaux %ѭ������
	
    % projection sur v %vƽ�� is the other type of projection%
    g(l+1,:)=decomp(l+1,:);	
    tmp=mallat1d(g,l,1); %������ԭ��С���ֽ�õ��ĸ��߶ȵĲ��η���tmp��
    g=mallat1d(tmp,l,0); %��tmp�ĸ����������½����滹ԭ�õ����źŷ���g��
end;
sb=mallat1d(g,l,1); %wavelet reconstrution%sb����