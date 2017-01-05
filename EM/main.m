load EMGaussian.data
load EMGaussian.test
u = importdata('EMGaussian.data');
u_test=importdata('EMGaussian.test');
K=4; % number of possible states for q 
currentPrecision = 32;

[mu,sigma,log_like] = EM_HMM(u)
[mu_test,sigma_test,log_like_test] = EM_HMM(u_test)

figure
plot(log_like)
hold on
plot(log_like_test)
legend('Training data','Test data')
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