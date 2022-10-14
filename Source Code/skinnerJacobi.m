
function [x] = skinnerJacobi(A,tolerance, stoppingMethod)
    a = A;
    [n,m]=size(A);
    inApprox = zeros(n,1);


    A = ufferPartialPivot(A);
    
    for i=1:n
        b(i)= A(i,m);
    end
        

    for i=1:n
        b(i)=b(i)/A(i,i);
        new_x(i)=inApprox(i);

        for j=1:n
            if(i ~= j)
                A(i,j)=A(i,j)/A(i,i);
            end
        end
    end

    error = 9999;
    
 
    
    while(error>tolerance)
        error = 0;
        for i=1:n
            old_x(i)=new_x(i);
            new_x(i)=b(i);
        end
        for i=1:n
            for j=1:n
                if(i~=j)
                    new_x(i)=new_x(i)-A(i,j)*old_x(j);
                end
            end
        
            if stoppingMethod == 1
                error = error+abs(new_x(i)-old_x(i));
            elseif stoppingMethod == 2
                error = error+(new_x(i)-old_x(i))^2;
            else
                disp("Error with stopping method")
            end
        end

        if stoppingMethod == 1
            error=error/n;%
        elseif stoppingMethod == 2
            error = (error/n)^(1/2);
        else
            disp("Error with stopping method")
        end
    end
    
    for i=1:n
        x(i)=new_x(i);
    end
end

    
