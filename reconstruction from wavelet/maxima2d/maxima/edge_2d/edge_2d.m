function sb=edge_2d(mx,nbr_boucle,l);
%l=4;

trame=mx(l+1).trame;
grad=struct();
grad(l+1).trame=trame;
[n,m]=size(trame);

%init de g
for j=1:l,
    grad(j).dligne=zeros(n,m);
    grad(j).dcolone=zeros(n,m);
end;

for boucl=1:nbr_boucle,
	boucl
    % projection sur t
   for j=1:l,
       % pour chaque niveau
       
       % calcul par ligne
        modul=abs(mx(j).dligne+i*mx(j).dcolone);

	for b=1:n,
         %res=interpol(limg(b,:),dligne(b,:),abs((mx(b,:))),j);
         grad(j).dligne(b,:)=interpol2(mx(j).dligne(b,:),grad(j).dligne(b,:),modul(b,:),j);
     end;

        % calcul par colone
        for b=1:m,
            %res=interpol(cimg(:,b)',dcolone(:,b)',abs((mx(:,b)))',j);
            grad(j).dcolone(:,b)=(interpol2(mx(j).dcolone(:,b)',grad(j).dcolone(:,b)',modul(:,b)',j))';
            %dcolone(:,b)=res';
        end;
 	[grad(j).dligne,grad(j).dcolone]=clipping(grad(j).dligne,grad(j).dcolone,modul);       
	%phrase = ['save  i' num2str(j) ' dligne dcolone;'];
    %   eval(phrase);
    end; % end de for des niveaux

     	
     % projection sur v

    sb=mallat2d(grad,l,1);
% 	borne_oui=0;
% 	if borne_oui==1
% 		maxb=max(max(sb));
% 		minb=min(min(sb));
% 		b=255/(1-(maxb/minb));
% 		a=-b/minb;
% 		sb=sb.*a+b;
% 		sb=round(sb);
% 	end;
    grad=mallat2d(sb,l,0);
%     if boucl==nbr_boucle
%     	sb=mallat2d(grad,l,1);
%      end;
    grad(l+1).trame=trame;
   
end;
