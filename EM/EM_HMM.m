function [mu,sigma,log_like] = EM_HMM(u)

    K = 4;
    T=size(u,1);
    ln_A = [-log(2),-log(6),-log(6),-log(6);-log(6),-log(2),-log(6),-log(6);-log(6),-log(6),-log(2),-log(6);-log(6),-log(6),-log(6),-log(2)]; %transition matrix (sum over the rows =1)
    [mu,sigma] = Gaussian_mixture(u,K);
    I = eye(4);
    ln_q = log(0.25)*ones(1,4); %initial random distribution

    Z = 10; %number of iterations
    log_like = zeros(Z,1);

    for z=1:Z

        display(z);

        [log_alpha,log_beta,log_p,log_p_1,log_p_2] = forward_backward(mu,sigma,ln_A,u,T,ln_q);
        if z==1
            plot_states(log_p_1);
        end
        ln_q = log_p_1(1,:);
        exp(ln_q)

        for i=1:4
            for j=1:4
                ln_A(i,j) = efficient_log_sum(reshape(log_p_2(:,i,j),1,T-1))-efficient_log_sum(reshape(log_p_2(1:(T-1),i,:),1,4*(T-1)));
            end
        end
        exp(ln_A)

        for k=1:4
            mu(k,:) = u'*exp(log_p_1(:,k))/exp(efficient_log_sum(reshape(log_p_1(:,k),1,T)));
        end

        for k=1:4
            sigma(:,:,k) = zeros(2,2);
            for i=1:T
                sigma(:,:,k) = sigma(:,:,k)+ exp(log_p_1(i,k))*(u(i,:)-mu(k,:))'*(u(i,:)-mu(k,:))/exp(efficient_log_sum(reshape(log_p_1(:,k),1,T)));
            end
        end
    %     display(sigma);

        log_like(z) = log_likelihood(ln_q,log_p_1,log_p_2,ln_A,u,mu,sigma,T);
    end

end