function mx=max_2d(grad,l);
% Detection of Wavelet maxima
% Outpout
%mx a struct
%mx(l+1).trame is the coarse approximation
%mx(b).dligne is the maxima coefficient associated with the decompsoition
%along the line for the scale b
%mx(b).dcolone is the maxima coefficient associated with the decompsoition
%along the column for the scale b
%mx(b).code is the freeman code (the discrete direction) associated with
%the maxima

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
