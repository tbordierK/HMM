function [mu,sigma] = Gaussian_mixture(data,K)

n=length(data);
w=zeros(K,n); %membership weights
p=zeros(K,n); %probabilities
sigma=zeros(2,2,K); %covariance matrices

% We set the covariance matrix for each cluster to be equal to the covariance of the full training set

for k=1:K
    sigma(:,:,k)=cov(data)
end

mu=K_means(data,K); %clusters
mu_previous=zeros(K,2);
alpha=rand(K,1);
alpha=alpha/sum(alpha);

while(norm(mu-mu_previous)>5)

mu_previous=mu;
% E-step: compute all the membership weights

% Compute the p(i,k)
for i=1:n
   for k=1:K
       p(k,i)=1/(2*pi*sqrt(abs(det(sigma(:,:,k)))))*exp(-0.5*(data(i,:)-mu(k,:))*(sigma(:,:,k)\transpose(data(i,:)-mu(k,:))));
   end
end

% Compute the w(i,k)
for i=1:n
   for k=1:K
       w(k,i)=alpha(k)*p(k,i)/(sum(alpha.*p(:,i)));
   end
end

% M-step 

for k=1:K
    alpha(k)=sum(w(k,:))/n;
end

for k=1:K
    mu(k,:)=1/(n*alpha(k))*sum(transpose(w(k,:).*transpose(data)));
end

sigma=zeros(2,2,K);

for k=1:K
    for i=1:n
    sigma(:,:,k)=sigma(:,:,k)+w(k,i)*transpose(data(i,:)-mu(k,:))*(data(i,:)-mu(k,:));
    end
    sigma(:,:,k)=1/(n*alpha(k))*sigma(:,:,k);
end

end

%Compute posterior probabilities

post=zeros(n,1);

for i=1:n
   for k=1:K
       p(k,i)=1/(2*pi*sqrt(abs(det(sigma(:,:,k)))))*exp(-0.5*(data(i,:)-mu(k,:))*(sigma(:,:,k)\transpose(data(i,:)-mu(k,:))));
   end
end

for i=1:n
   for k=1:K
       w(k,i)=alpha(k)*p(k,i)/(sum(alpha.*p(:,i)));
   end
end

for i=1:n
   post(i)=indice_max(w(:,i));
end

plot_ellipses(data,mu,sigma,post,4);

% %Question 4: log-likelihood
% 
% l=0;
% for i=1:n
%     l=l+log(alpha'*p(:,i));
% end
% 
% hold off
% 
% %log-likelihood
% display(l);


end



