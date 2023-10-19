function length = length_koch_fun(x,y)
%LENGTH_KOCH_FUN Summary of this function goes here
%   Detailed explanation goes here
length = 0;
for i=1:size(x,2)-1
    length = length + sqrt((x(i) - x(i+1))^2 + (y(i) - y(i+1))^2);
end

end

