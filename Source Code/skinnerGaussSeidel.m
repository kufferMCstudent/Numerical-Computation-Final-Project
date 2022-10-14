function [x] = skinnerGaussSeidel(A,tolerance,stoppingMethod)
    a=A;
    [n,m]=size(A);
    inApprox = zeros(n,1);

    %Add Partial Pivot here begin:
    A=ufferPartialPivot(A); 
    %Add Partial Pivot here end.
    
    %Creates matrix b
    for i=1:n
        b(i)= A(i,m);
    end
    
    for i=1:n
        b(i)=b(i)/A(i,i);
        x(i)=inApprox(i);
        old_x(i)=x(i);

        for j=1:n
            if (i~=j)
                A(i,j)=A(i,j)/A(i,i);
            end
        end
    end

    error = 9999;
    
    %Performs operation until threshold
    while(error > tolerance)
        
        error = 0;
        for i=1:n
            x(i)=b(i);
            for j=1:n
               if i~=j
                  x(1,i)=x(1,i)-A(i,j)*x(1,j);
               end
            end
            
            if stoppingMethod == 1
                error = error + abs(x(i)-old_x(i));
            elseif stoppingMethod == 2
                error = error + abs((x(i)-old_x(i))^2);
            else
                 disp("Error choosing stopping method");   
            end
            old_x(i)=x(i);         
        end
        %Stopping method --> moved to right spot
        if stoppingMethod == 1
            error=error/n;
        elseif stoppingMethod == 2
            error = abs((error/n)^(1/2));
        else
            disp("Error in stopping method choice.");
        end
    end
end