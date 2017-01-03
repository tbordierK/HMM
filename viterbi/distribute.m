function [message,delta] = distribute(j,i,message,delta,evidence,mu,cov,A,graph)
 n_j = find(graph(j,:));
    for k=n_j
        if k~=i
            [message,delta] = collect(j,k,graph,message,delta,evidence,mu,cov,A);
        end
    end 
end