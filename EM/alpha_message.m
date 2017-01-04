function log_alpha = alpha_message(mu,sigma,ln_A,u,n,ln_q)
%computes the alpha messages alpha_t(q_t) 
%Input: 
%t: time step
% q_t : vector of R4
% mu: matrix of mean vectors (size 4*2)
% sigma: matrix of covariance matrices (size 2*2*4)
% ln_A: ln of the transition matrix (size 4*4)
% u : data
% ln_q: initial distribution pi

log_alpha = zeros(n,4); 

log_alpha(1,:)=ln_q; 
    
for t=2:n 
    
    for i=1:4
        
        u_t = u(t,:);
        ln_p = log_normal_density(u_t,mu(i,:),reshape(sigma(:,:,i),2,2)); %probability p(u_t|q_t)
        l = zeros(1,4);
        for j=1:4
           l(j) = ln_p+ln_A(i,j)+log_alpha(t-1,j);
        end
        log_alpha(t,i) = efficient_log_sum(l);
        %~=
    end
end

end