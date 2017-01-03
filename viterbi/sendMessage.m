function [message,delta] = sendMessage(j,i,message,delta,evidence,mu,cov,A,graph)
    
    K = 4;
    if mod(j,2) == 0 
        % x_j is a real valued variable and is a leaf (HMM structure)
        % mu,cov,A for parametrisation
        x_j = [evidence(1,j/2),evidence(2,j/2)];
        psi_x_i_x_j = zeros(K,1);
        for x_i=1:K
            psi_x_i_x_j(x_i) = mvnpdf(x_j,mu(x_i,:),reshape(cov(x_i,:,:),2,2));
        end
        % The max over x_j is for x_j = x_j_evidence
        message(j,i,:) = 1*psi_x_i_x_j*1;
        delta(j,i,:) = j;
    
    else
        % x_j has K possible states
            % Computing the K possibilities
            neighbors_j = find(graph(j,:));
            for x_i=1:K
                possible_val = zeros(1,K);
                for x_j=1:K
                    product = 1;
                    for neighbor=neighbors_j
                        if neighbor~=i
                            product = product*message(neighbor,j,x_j);
                        end
                    end
                    possible_val(x_j) = A(x_j,x_i)*product;
                end
                [max_val,delta_val] = max(possible_val);
                message(j,i,x_i) = max_val;
                delta(j,i,x_i) = delta_val;
            end
   end
   
end