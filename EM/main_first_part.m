load EMGaussian.data
load EMGaussian.test
u = importdata('EMGaussian.data');
u_test=importdata('EMGaussian.test');
K=4; % number of possible states for q 
currentPrecision = 32;

T=size(u,1);
ln_A = [-log(2),-log(6),-log(6),-log(6);-log(6),-log(2),-log(6),-log(6);-log(6),-log(6),-log(2),-log(6);-log(6),-log(6),-log(6),-log(2)]; %transition matrix (sum over the rows =1)
[mu,sigma] = Gaussian_mixture(u,K);
I = eye(4);
ln_q = log(0.25)*ones(1,4); %initial random distribution

Z = 16; %number of iterations
log_like = zeros(Z,1);

for z=1:Z

    display(z);
    
    [log_alpha,log_beta,log_p,log_p_1,log_p_2] = forward_backward(mu,sigma,ln_A,u,T,ln_q);
    if z==1
        plot_states(log_p_1);
    end
    ln_q = log_p_1(1,:);
    % display(exp(ln_q))

    for i=1:4
        for j=1:4
            ln_A(i,j) = efficient_log_sum(log_p_2(:,i,j))-efficient_log_sum(log_p_1(1:(T-1),i));
        end
    end
%     display(ln_A);
%     display(exp(ln_A));
%     display(efficient_log_sum(ln_A(1,:)));

    for k=1:4
        mu(k,:) = 1/(exp(ln_q(k))*T)*u'*exp(log_p_1(:,k));
    end
%     display(mu);
    % display(exp(log_p_1(:,1)));

    for k=1:4
        sigma(:,:,k) = zeros(2,2);
        for i=1:T
            sigma(:,:,k) = sigma(:,:,k)+ 1/(exp(ln_q(k))*T)*exp(log_p_1(i,k))*(u(i,:)-mu(k,:))'*(u(i,:)-mu(k,:));
        end
    end
%     display(sigma);

    log_like(z) = log_likelihood(ln_q,log_p_1,log_p_2,ln_A,u,mu,sigma,T);
end


figure
plot(log_like)
xlabel('Iterations')
ylabel('log_likelihood')

figure
title('Gaussian mixture')
scatter(u(:,1),u(:,2));
hold on
scatter(mu(:,1),mu(:,2),'filled','k');
for k=1:K %plot the ellipse
    r_ellipse=error_ellipse(u,sigma(:,:,k),mu(k,:));
end
