function mx=ss_max2d(dligne,dcolone,code);
% function mx=max2d(dligne,dcolone)
% cette fonction recherche le max par interpolation
% cf Analyse d'images p 150


[n,m]=size(dligne);
grad=sqrt(dligne.^2+dcolone.^2);
mx=zeros(n,m);
for ii=2:(n-1),
    for j=2:(m-1),
    ang=code(ii,j);
     if (ang==5) | (ang==1)
        if ( (grad(ii,j-1)<grad(ii,j))&(grad(ii,j+1)<grad(ii,j)))
           mx(ii,j)=dligne(ii,j)+dcolone(ii,j)*i;
        end;
      else
       if (ang==2) | (ang==6)
         if ( (grad(ii+1,j-1)<grad(ii,j))&(grad(ii-1,j+1)<grad(ii,j)))
            mx(ii,j)=dligne(ii,j)+dcolone(ii,j)*i;
         end;
       else
          if (ang==3) | (ang==7)
             if ( (grad(ii+1,j)<grad(ii,j))&(grad(ii-1,j)<grad(ii,j)))
                  mx(ii,j)=dligne(ii,j)+dcolone(ii,j)*i;
             end;
          else
            if (ang==4) | (ang==8)
             if ( (grad(ii-1,j-1)<grad(ii,j))&(grad(ii+1,j+1)<grad(ii,j)))
                  mx(ii,j)=dligne(ii,j)+dcolone(ii,j)*i;
             end;
            end;
         end;
      end;
     end;


    end;
end;
