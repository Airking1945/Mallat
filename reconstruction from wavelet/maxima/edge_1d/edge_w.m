% AUTHOR: P. Carr? XLIM Lab. CNRS 7252 University of Poitiers, France
%         philippe.carre@univ-poitiers.fr
%
% 2010
%
function sb=edge_w(decomp,nbr_boucle) %从1D的maxima中将波形进行还原%投影算法
%Reconstruction from 1-D maxima (decomp) with nbre_boucle iterations
% decomp is the struct that contains the maxima representation
% %decomp函数是包含了各极值表达的


dim=size(decomp);       %输出小波分解后得到的行和列
n=dim(2);               %n为行
l=dim(1)-1;             %l为列
g=zeros(l+1,n);         %将g作为行列式进行初始化赋零
g(l+1,:)=decomp(l+1,:); %把小波分解得到的结果放到g中
for boucl=1:nbr_boucle  %nbr_boucle is for number of loop %nbr_boucle是重复的次数

    % projection sur t %t平面 is type of projection%
    for j=1:l 
        g(j,:)=interpol(decomp(j,:),g(j,:),abs(decomp(j,:)),j);
    end; % end de for des niveaux %循环结束
	
    % projection sur v %v平面 is the other type of projection%
    g(l+1,:)=decomp(l+1,:);	
    tmp=mallat1d(g,l,1); %将根据原有小波分解得到的各尺度的波形放入tmp中
    g=mallat1d(tmp,l,0); %将tmp的各个波形重新进行逆还原得到的信号放入g中
end;
sb=mallat1d(g,l,1); %wavelet reconstrution%sb？？