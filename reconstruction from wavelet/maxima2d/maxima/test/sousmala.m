function [trame,dligne,dcolone]=sousmala(trame,qmf,qmfb);

taille=floor(length(qmf)/2); %大小
source =trame;
[n,m]=size(trame);

% ligne行
	for lig=1:n,
            tmp(lig,:) = (symm_aconv(qmf,source(lig,:)));
            %dligne(lig,:) = symm_iconv(qmfb,lshift(source(lig,:)));
            dligne(lig,:) = symm_iconv(qmfb,source(lig,:));
end;

% colo列
        for colo=1:m,
            trame(:,colo)=symm_aconv(qmf,tmp(:,colo)')';
            %dcolone(:,colo)=symm_iconv(qmfb,lshift(source(:,colo)'))';
            dcolone(:,colo)=symm_iconv(qmfb,source(:,colo)')';
        end;

