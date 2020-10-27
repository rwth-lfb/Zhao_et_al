%code by: Martin.Strauch@lfb.rwth-aachen.de
%
%local_smoothness_filter(X(1,:), size(I,1), size(I,2), C_indices(1), 0.25);
%
function X = local_smoothness_filter_3d(X, m, n, o, index, threshold)

S = reshape(X, m ,n, o);

z = ceil(index/(m*n));
x = ceil( (index - ((z-1)*m*n))/m );
y = index - ((z-1)*m*n) - (x-1)*m;

reference = S(y,x,z);


set(0,'RecursionLimit',5000);

[L, checked, counter] = check_neighbourhood(S,x,y,z, m, n, o, zeros(m,n,o), zeros(m,n,o), 0, threshold*reference);

S(find(L==0))=0;
X = reshape(S,m*n*o,1);

end




function [L, checked, counter] = check_neighbourhood(S, x,y,z, m,n,o, L, checked, counter, threshold)
 
  counter=counter+1;
  if(counter>=5000) return; end

   
  for i = -1:1
    for j = -1:1
        for k=-1:1
            if ((x+j)>0 && (x+j)<=n && (y+i)>0 && (y+i)<=m && (z+k)>0 && (z+k)<=o)
           
                if(S(y+i, x+j, z+k)>threshold)        
                    L(y+i,x+j,z+k) = 1;
                end
            end    
        end
    end
  end
  
  
  checked(y,x,z)=1;
  
  [ypos, xpos, zpos] = ind2sub(size(L),find(L==1));
  for i=1:length(xpos)
    if ( checked(ypos(i),xpos(i),zpos(i))==0 && xpos(i)>1 && ypos(i)>1 &&zpos(i)>1 && xpos(i)<n && ypos(i)<m && zpos(i)<o)
       [L, checked, counter] = check_neighbourhood(S,xpos(i),ypos(i), zpos(i), m, n, o, L, checked, counter, threshold); 
    end
  end
  
end




