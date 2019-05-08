% AUTHOR: P. Carré, XLIM Lab. CNRS 7252 University of Poitiers, France
%         philippe.carre@univ-poitiers.fr
%
% 2010
%
function sb=edge_w(decomp,nbr_boucle);
%Reconstruction from 1-D maxima (decomp) with nbre_boucle iterations
% decomp is the struct that contains the maxima representation


dim=size(decomp);
n=dim(2);
l=dim(1)-1;
g=zeros(l+1,n);
g(l+1,:)=decomp(l+1,:);
for boucl=1:nbr_boucle,

    % projection sur t
    for j=1:l,
        g(j,:)=interpol(decomp(j,:),g(j,:),abs(decomp(j,:)),j);
    end; % end de for des niveaux
	
    % projection sur v
    g(l+1,:)=decomp(l+1,:);	
    tmp=mallat1d(g,l,1);
    g=mallat1d(tmp,l,0);
end;
sb=mallat1d(g,l,1);