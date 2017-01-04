function p = log_normal_density(x,mu,sigma)
p = log(1/((2*pi)*sqrt(abs(det(sigma)))))-0.5*(x-mu)*pinv(sigma)*(x-mu)';
end