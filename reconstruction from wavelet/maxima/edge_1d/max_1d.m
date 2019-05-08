function maxindex=max_1d(f) 
% Detection of maxima form the multiscale gradient decomposition

m=length(f);           
res=abs(f);            
maxindex=zeros(1,m);       
for j=1:m
		if (res(j)>res(j-1))&&(res(j)>res(j+1))
		   maxindex(j)=f(j);
        end
end;
