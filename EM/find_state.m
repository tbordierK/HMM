function indice = find_state(q)
%finds the only i such that q(i)=1
%Input
%q: vector of R4 of the form (0,0,1,0) for example

indice = 0;
for j=1:4
    if q(j)==1
        indice = j;
    end
end

end