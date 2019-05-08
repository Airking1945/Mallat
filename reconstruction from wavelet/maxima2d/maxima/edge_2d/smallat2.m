function trame=smallat2(trame,dligne,dcolone,fh,fl,fk,coeff);
[n,m]=size(trame);	
for colo=1:m,
            c(:,colo) =symm_iconv(fh,trame(:,colo)')';
            w1(:,colo) =symm_iconv(fl,dligne(:,colo)')';
            %w2(:,colo) =symm_aconv(fk,rshift(dcolone(:,colo)'))';
            w2(:,colo) =symm_aconv(fk,dcolone(:,colo)')';
	end;

	% ligne

        for lig=1:n,
            c(lig,:)=symm_iconv(fh,c(lig,:));
            % w1(lig,:)=coeff*symm_aconv(fk,rshift(w1(lig,:)));
            w1(lig,:)=coeff*symm_aconv(fk,w1(lig,:));
            w2(lig,:)=coeff*symm_iconv(fl,w2(lig,:));
        end;
trame=(w1+w2+c);
