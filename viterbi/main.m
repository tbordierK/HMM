% Read data
data = readtable('../../data/EMGaussian.dat');

% q_t is the latent variable, u_t is the observed variable. 

%%
K = 4;

cov(1,:,:) = [[ 78.54401893, -12.84437224],[-12.84437224,  90.78764067]];
cov(2,:,:) = [[ 147.75989735,  125.2911245 ],[ 125.2911245 ,  260.00244456]];
cov(3,:,:) = [[  66.42545545,  -17.28857348],[ -17.28857348,  148.37708026]];
cov(4,:,:) = [[ 111.95076506,   81.84131494],[  81.84131494,  149.86068575]];

mu = [[ 2.77038086, -1.67913142];[ 2.60287341,  3.77181522];[-0.97792624,  3.34085819];[-2.8693756 , -3.04391594]];

A = zeros(4,4);
for k=1:4
    for i=1:4
       A(k,i) = 1/6;
    end
end
for k=1:4
    A(k,k) = 1/2;
end

pi_distribution = 1/4*ones(1,K);
%% Defines HMM undirected graph for a HMM of length T
% If graph(i,j) = 1 iff i is connected to j.
T = 5;
n_nodes = 2*T;
graph = zeros(n_nodes,n_nodes);
for i=1:n_nodes
    if mod(i,2) == 0
        graph(i,max(i-1,1)) = 1;
        graph(max(i-1,1),i) = 1;
        
    else
        graph(i,max(i-2,1)) = 1;
        graph(max(i-2,1),i) = 1;
        
    end
    graph(i,i) = 0;
end


%%
observed_sequence = zeros(2,T);
for k=1:T
   observed_sequence(1,k) = rand(1,1);
   observed_sequence(2,k) = rand(1,1);
end


[Message,Delta] = viterbi(observed_sequence,graph,mu,cov,A,pi_distribution);
