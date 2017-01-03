function [message,delta] = collect(i,j,graph,message,delta,evidence,mu,cov,A)
    n_j = find(graph(j,:));
    for k=n_j
        if k~=i
            [message,delta] = collect(j,k,graph,message,delta,evidence,mu,cov,A);
        end
    end
    [message,delta] = sendMessage(j,i,message,delta,evidence,mu,cov,A,graph);
end
