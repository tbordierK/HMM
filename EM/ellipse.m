function y=ellipse(x,mu,sigma)
    y=(x-mu)'*inv(sigma)*(x-mu);
end