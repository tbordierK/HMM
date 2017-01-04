function log_beta = beta_message(mu,sigma,ln_A,u,T)
%computes the beta message alpha_t(q_t)
%Input: 
%t: time step
% q_t : vector of R4
% mu: matrix of mean vectors (size 4*2)
% sigma: matrix of covariance matrices (size 4*2*2)
% ln_A: ln of the transition matrix (size 4*4)
% u : data

log_beta = zeros(T,4); 

log_beta(T,:) = zeros(1,4);
    
for t=(T-1):-1:1
    
    for i=1:4
        
        u_after = u(t+1,:);
        l = zeros(1,4);
        
        for j=1:4
            ln_p = log_normal_density(u_after,mu(j,:),reshape(sigma(:,:,j),2,2)); %probability p(u_t|q_t)
            l(j) = ln_p+ln_A(i,j)+log_beta(t+1,j);
        end
        log_beta(t,i) = efficient_log_sum(l);
        %~=
    end
end


end