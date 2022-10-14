function [x] = feeGaussSeidel(A, tolerance, p)
    
    [n,m] = size(A);
    approx = zeros(n);
    iter=0;
    
    A = ufferPartialPivot(A);
    
    for i=1:n
        b(i)=A(i,m);
    end
    
    for i=1:n
        
        b(i)=b(i)/A(i,i); % here we transform biases b dividing them by a diagonal element from a corresponding row
        x(i)= approx(i); % starting value contains initial approximations; new contains current approximations
        old(i)=x(i);
        
        for j=1:n % here we transform matrix A of our system dividing all elements in each row by a diagonal element from this row
            if i~=j % we do this to avoid redundant operations in the main loop
                A(i,j)=A(i,j)/A(i,i);
            end
        end
    end
    
    error=10;
    
    while (error>tolerance)
        iter=iter+1;
        error=0;
        
        for i=1:n
            x(i)=b(i);
            for j=1:n
                if i~=j
                    x(i)=x(i)-A(i,j)*x(j);
                end
            end
            
            if p == 1
                error=error+abs(x(i) - old(i)); % accumulation of approximate absolute errors calculated for each unknown.
            elseif p == 2
                error = error + abs((x(i)-old(i))^2);
            else
                disp("Invalid choice")
            end
            old(i)=x(i);
        end
        
        if p==1 %MAE
            error=error/n;
        end
        if p==2 %RMSE
            error=(error/n)^(1/2);
        end

    end
end