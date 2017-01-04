function log_like = log_likelihood(ln_q,log_p_1,log_p_2,ln_A,u,mu,sigma,T)
    log_like = 0;

    for i=1:4
        log_like = log_like + ln_q(i)*exp(log_p_1(1,i));
    end

    for t=1:(T-1)
        for i=1:4
            for j=1:4
                log_like = log_like + exp(log_p_2(t,i,j))*ln_A(i,j);
            end
        end
    end

    for t=1:T
        for i=1:4
            log_like = log_like + exp(log_p_1(t,i))*log_normal_density(u(t,:),mu(i,:),reshape(sigma(:,:,i),2,2));
        end
    end

end