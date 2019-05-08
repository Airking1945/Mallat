% AUTHOR: P. Carré, XLIM Lab. CNRS 7252 University of Poitiers, France
%         philippe.carre@univ-poitiers.fr
%
% 2010
%

function decomp2=max_1d(decomp);
% Detection of maxima form the multiscale gradient decomposition

dim=size(decomp);
n=dim(2)
l=dim(1)-1
res=abs(decomp);
indice=zeros(l,n);
decomp2=zeros(l+1,n);
for j=1:l,
        k=0;
	for i=2:n-1

		if (res(j,i)>res(j,i-1))&(res(j,i)>res(j,i+1))
		   indice(j,k+1)=i;
		   decomp2(j,i)=decomp(j,i);
		   k=k+1;
		end
		%if (res(j,i)<res(j,i-1))&(res(j,i)<res(j,i+1))
		%   indice(j,k+1)=i;
		%   decomp2(j,i)=decomp(j,i);
		 %  k=k+1;
		%end
	end;
        indice(j,k+1)=n;
end;
decomp2(l+1,:)=decomp(l+1,:);