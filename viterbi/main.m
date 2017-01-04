% Read data
data = readtable('../../data/EMGaussian.dat');
% q_t is the latent variable, u_t is the observed variable. 

%%

T = 100;
n_nodes = 2*T;
load('A.mat')
load('mu.mat')
load('sigma.mat')

observed_sequence = zeros(T,2);
for k=1:T
   observed_sequence(k,1) = data.Var1(k);
   observed_sequence(k,2) = data.Var1(k);
end


%%

[seq] = viterbi_algo(observed_sequence,A,mu,sigma,T,K);

