%true mean absolute error
function y = trueError(a, c)%augmented matrix, solutions
    [n,m] = size(a);
    y = 0; 
    
    %calculate True Mean Absolute Error for solution
    for i = 1:n
        temp = 0;
        for j = 1:n
            temp = temp + a(i,j)*c(j);%vpa increases precision
        end
        y = y + abs(temp-a(i,m));
    end
    y = y/n;
end