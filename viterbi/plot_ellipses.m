function y = plot_ellipses(data,mu,sigma,post,K)



figure
title('Gaussian mixture')
% scatter(data(:,1),data(:,2));
gscatter(data(:,1),data(:,2),post,[],'ox+*sdv^<>ph.')
hold on
scatter(mu(:,1),mu(:,2),'filled','k');

for k=1:K %plot the ellipse
    r_ellipse=error_ellipse(data,sigma(:,:,k),mu(k,:));
end

y = 0;

end