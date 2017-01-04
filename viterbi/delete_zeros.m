function y = delete_zeros(a)
% Input : array a
% deletes the zeros of a

n = size(a,2);
accu = 0;
for j=1:n
    if a(j)~=0
        accu = accu+1;
    end
end

y=zeros(1,accu);
accu = 1;
for j=1:n
    if a(j)~=0
        y(accu) = a(j);
        accu = accu + 1;
    end
end


end