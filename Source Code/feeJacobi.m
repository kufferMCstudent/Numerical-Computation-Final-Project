function [x] = feeJacobi(A, tolerance,p)
    approx = [0; 0; 0;];
    [n,m] = size(A);
    iter=0;
    
    A=ufferPartialPivot(A);
    
    for i=1:n
        b(i)=A(i,m);
    end
    
    for i=1:n
        b(i)=b(i)/A(i,i);
        x(i)=approx(i);
        for j=1:n
            if (i~=j)
                A(i,j)=A(i,j)/A(i,i);
            end
        end
    end
    
    error = 10;

    while(error>tolerance)
        iter=iter+1;
        error = 0;
        for i=1:n
            old(i)=x(i);
            x(i)=b(i);
        end
        
        for i=1:n
            for j=1:n
                if i~=j
                    x(i)=x(i)-A(i,j)*old(j);
                end
            end
            
            
            if p == 1
                error = error+abs(x(i)-old(i));
            elseif p == 2
                error = error+((x(i)-old(i))^2);
            else
                disp("Error with stopping method")
            end
        end
        
        if (p==1) %MAE
            error=error/n;
        end
        if (p==2) %RMSE
            error = sqrt(error/n);
        end
    
end