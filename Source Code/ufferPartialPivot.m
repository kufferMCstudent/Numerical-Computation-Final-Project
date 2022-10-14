%Katherine Uffer
%CMPT 439 - Fall 2021
%Due Date - October 28, 2021
%Project 6

function y = ufferPartialPivot(A)

    trigger = 0;
    y = A;
    sz = size(y); %must save temp array to access indecies, rows = 1, columns = 2
    for col = 1:sz(1) %starting at the first column, check all elements so see which is largest, then switch rows
        
        maxRow = col; %default largest element is in current row, so (1,1), (2,2), ect.
        
        for row = col:sz(1) %since we are starting at the diagonal and moving down, start at column value
            
            if gt(abs(y(row, col)), abs(y(maxRow, col))) %if the current element is greater than the saved max element
                maxRow = row; %save new max element
                trigger = 1;
            end
        end
        
        for elem = 1:sz(2) %preform row swap
            temp = y(maxRow, elem);%save max element
            y(maxRow, elem) = y(col, elem); %move original element to max element
            y(col, elem) = temp; %move max element to original element
        end
    end
    
    if trigger == 1
        disp("The function was not diagonally dominant")
    end
end