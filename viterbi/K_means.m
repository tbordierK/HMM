function cluster=K_means(data,K)

n=length(data);

cluster=zeros(K,2);

closest_cluster=zeros(n,1);
nb_points=zeros(K,1);
next_cluster=rand(K,2)*6;

while(norm(cluster-next_cluster)>0.1)
 
cluster=next_cluster;
next_cluster=zeros(K,2);
nb_points=zeros(K,1);
closest_cluster=zeros(n,1);

for i=1:n
    
    c=0;
    d=1000;
    
    for j=1:K 
       no=norm(data(i,1:2)-cluster(j,:));
       if no<d
           d=no;
           c=j;
       end
    end
    
    closest_cluster(i)=c;
    nb_points(c)=nb_points(c)+1;
    next_cluster(c,:)=next_cluster(c,:)+data(i,1:2);
    
end

next_cluster=next_cluster./nb_points;

end

cluster=next_cluster;

% % Figure
% 
% figure
% gscatter(data(:,1),data(:,2),closest_cluster,[],'ox+*sdv^<>ph.')
% hold on
% scatter(cluster(:,1),cluster(:,2),'filled','k');
% title('K-means algo')
% hold off

end

