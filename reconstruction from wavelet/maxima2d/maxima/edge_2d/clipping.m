function [dligne,dcolone]=clipping(dligne,dcolone,mx);

dim=size(dligne);
norm_v=abs(dligne+i*dcolone);
angle_v=angle(dligne+i*dcolone);

%dligne
for b=1:dim(1),
 	indice=find(abs(mx(b,:))>0); 
	j0=1;
	bb=1;
    stop=0;
	while(stop==0),
		if (bb>length(indice))
    			j1=dim(1);
       			stop=1;
 		else
    			j1=indice(bb);
     		end;
 		[val_min,indice_min]=min(norm_v(b,j0:j1));
		indice_min=indice_min+j0-1;
		if norm_v(b,j0)>val_min
			for j=j0+1:(indice_min-1),
				if (abs(abs(angle_v(b,j))/pi-0.5)>0.376 )
					if norm_v(b,j)>norm_v(b,j-1)
						norm_v(b,j)=norm_v(b,j-1);
					end;
				end;
			end;
		end;
		if norm_v(b,j1)>val_min
			for j=j1-1:-1:indice_min+1,
				if (abs(abs(angle_v(b,j))/pi-0.5)>0.376 )
					if norm_v(b,j)>norm_v(b,j+1)
						norm_v(b,j)=norm_v(b,j+1);
					end;
				end;
			end;
		end;
	j0=j1;
	bb=bb+1;
	end;
end;	

%colone
for b=1:dim(2),
 	indice=find(abs(mx(:,b))>0); 
	j0=1;
	bb=1;
	while(stop==0),
		if (bb>length(indice))
    			j1=dim(2);
       			stop=1;
 		else
    			j1=indice(bb);
     		end;
 		[val_min,indice_min]=min(norm_v(j0:j1,b));
		indice_min=indice_min+j0-1;
		if norm_v(j0,b)>val_min
			for j=j0+1:indice_min,
				if (abs(abs(angle_v(b,j))/pi-0.5)<0.126 )
					if norm_v(j,b)>norm_v(j-1,b)
						norm_v(j,b)=norm_v(j-1,b);
					end;
				end;
			end;
		end;
		if norm_v(j1,b)>val_min
			for j=j1-1:-1:indice_min,
				if (abs(abs(angle_v(b,j))/pi-0.5)<0.126 )
					if norm_v(j,b)>norm_v(j+1,b)
						norm_v(j,b)=norm_v(j+1,b);
					end;
				end;
			end;
		end;
	j0=j1;
	bb=bb+1;
	end;
end;	

dligne=norm_v.*cos(angle_v);
dcolone=norm_v.*sin(angle_v);




