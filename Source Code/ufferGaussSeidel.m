%Katherine Uffer
%CMPT 439 - Fall 2021
%Due Date - October 28, 2021
%Project 6

function y = ufferGaussSeidel(matrix, t, s) %augmented matrix, approximations, tolerance, stopping criteria
    A = ufferPartialPivot(matrix);
    sz = size(A);
    v = zeros(1, sz(1));
    y = zeros(1, sz(1)); %x1, x2, x3, ... xn
    newApprox = zeros(1, sz(1));
    oldApprox = zeros(1, sz(1));
    for row = 1:sz(1)
        A(row, sz(2)) = A(row, sz(2))/A(row, row);
        newApprox(1, row) = v(1, row);
        oldApprox(1, row) = newApprox(1, row);
        for col = 1:sz(1)
            if row ~= col
                A(row, col) = A(row, col)/A(row, row);
            end
        end
    end
    
    err = 10;
    
    while err > t
        %y(1, sz(2)) = y(1, sz(2)) + 1;
        err = 0;
        for row = 1:sz(1)
            newApprox(1, row) = A(row, sz(2));
            for col = 1:sz(1)
                if row ~= col
                    newApprox(1, row) = newApprox(1, row) - A(row, col)*newApprox(1, col);
                end
            end
            if s == 1 
                err = err + abs(newApprox(1, row) - oldApprox(1, row));
            elseif s == 2
                err = err + (newApprox(1, row) - oldApprox(1, row))^2;
            end
            oldApprox(1, row) = newApprox(1, row);
        end

        if s == 1 %mean absolute approximate error
            err = err/sz(1);
        elseif s == 2 %approximate root mean square error
            err = (err/sz(1))^(1/2);
        end
        
    end

    for i = 1:sz(1)
        y(1, i) = newApprox(1, i);
    end
end