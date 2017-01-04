function best_sequence = viterbi_algo(observations,A,mu,sigmas,T,K)
    probability = zeros(K,T);
    path = zeros(K,T);

    for k=1:K
        probability(k,1) = log(mvnpdf(observations(1,:),mu(k,:),reshape(sigmas(:,:,k),2,2)));
    end
   
    for t=2:T
        for k = 1:K
            %log(p(u_t|q_t))
            log_p_u_q = log(mvnpdf(observations(t,:),mu(k,:),reshape(sigmas(:,:,k),2,2)));
            [probability(k,t), path(k,t)] = max(probability(:,t-1) + log(A(:, k)) + log_p_u_q);
        end
    end

    % Retrieve best path
    best_sequence = zeros(1,T); 
    [~, best] = max(probability(:,T));
    best_sequence(T) = best; 
    
    for t=T:-1:2
        best_sequence(t - 1) = path(best_sequence(t),t);
    end


    
end