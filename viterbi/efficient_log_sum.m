function y = efficient_log_sum(l)
%efficiently computes the log of the sum of the exponential of l

n = size(l,2);

if n==1
    
    y = l(1);
    
else

    indice = indice_max(l);
    b=zeros(1,n-1);
    for j=1:n
        if j<indice
            b(j) =  l(j)-l(indice);
        elseif (j>indice)
            b(j-1) =  l(j)-l(indice);
        end
    end
    
    y = l(indice) + log(1 + exp(efficient_log_sum(b)));
    
end

end