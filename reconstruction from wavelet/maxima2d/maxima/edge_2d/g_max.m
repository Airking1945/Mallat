function mx=max_2d(grad,l);
% function qui creer les fichiers correspondant au maximum de chaque niveau

trame=grad(l+1).trame;
dim=size(trame);

mx=struct();

for b=1:l,
    code =freeman(grad(b).dligne+i*grad(b).dcolone);
    tmp=ss_max2d(grad(b).dligne,grad(b).dcolone,code);
    mx(b).dligne=real(tmp);mx(b).dcolone=imag(tmp);mx(b).code=code;
    %mx=sparse(mx);
    %list=chaine(full(mx));
end;

mx(l+1).trame=trame;
