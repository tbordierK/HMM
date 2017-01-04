function [log_alpha,log_beta,log_p,log_p_1,log_p_2] = forward_backward(mu,sigma,ln_A,u,T,ln_q)

% Compute log(alphas)

log_alpha = alpha_message(mu,sigma,ln_A,u,T,ln_q);

% Compute log(betas)

log_beta = beta_message(mu,sigma,ln_A,u,T);

% Compute log(p(u1,...,uT))

log_p = zeros(T,4);
for t=1:T
    log_p(t,:) = ones(1,4)*(efficient_log_sum(log_alpha(t,:)+log_beta(t,:)));
end

% for i=10:15
%     display(efficient_log_sum(log_alpha(i,:)+log_beta(i,:)));
% end

% Compute log(p(qt|u1,...,uT))

% log_p_1 = zeros(T,4);
% for t=1:T
%     for i=1:4
%         log_p_1(t,i) = efficient_log_sum([log_alpha(t,i),log_beta(t,i),-log_p]);
%         log_p_1(t,i) = log_alpha(t,i)+log_beta(t,i)-log_p;
%     end
% end

% log_p_1 = log_alpha + log_beta - log_p*ones(T,4);
log_p_1 = log_alpha + log_beta - log_p;

% Compute log(p(qt,q(t+1)|u1,...,uT))

log_p_2 = zeros(T-1,4,4);

for i=1:(T-1)
    for j=1:4
        for k=1:4
            ln_p = log_normal_density(u(i+1,:),mu(k,:),reshape(sigma(:,:,k),2,2));
            log_p_2(i,j,k) = log_alpha(i,j) + log_beta(i+1,k) + ln_A(j,k) + ln_p - log_p(i,j);
%             log_p_2(i,j,k) = log_alpha(i,j) + log_beta(i+1,k) + ln_A(j,k) + ln_p;
        end
    end
%     ln_z = efficient_log_sum(reshape(log_p_2(i,:,:),1,16));
%     log_p_2(i,:,:) = log_p_2(i,:,:) - ln_z;
end

% for i=10:15
%     display(efficient_log_sum(log_p_2(i,2,:))-log_p_1(i,2));
% end

end