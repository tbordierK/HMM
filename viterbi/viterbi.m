function [Message,Delta] = viterbi(observed_sequence,graph,mu,cov,A,initial_distribution)

    T = size(observed_sequence,2);
    K=4; % Number of possible states for discrete variables

    root = 1; % Root is the first node for HMM
    n_root = find(graph(root,:)); % Root's neighbors for HMM
    
    Message = zeros(2*T,2*T,4);
    delta = zeros(2*T,2*T,4);
    
    % COLLECT
    for e=n_root
        [Message,Delta] = collect(root,e,graph,Message,delta,observed_sequence,mu,cov,A);
    end
    
    % MAP
    MAP_values = zeros(1,K);
    for x_f=1:K
        product = 1;
        for neighbor=n_root
           product = product*Message(neighbor,root,x_f);
        end
        MAP_values(x_f) = initial_distribution(x_f)*product;
    end
    [MAP,x_f_star] = max(MAP_values);
    
    % DISTRIBUTE
    

end