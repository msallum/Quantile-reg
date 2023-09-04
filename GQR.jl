using Optim
using Random, Distributions
using LogExpFunctions

function b_filter(Y, D, t)
   mu_up(b) =(sum(Y.<=D.*b')/length(Y)-t)^2
   mu_low(b) =(sum(Y.<=D.*b')/length(Y)-t+1/length(Y))^2
   up = Optim.optimize(mu_up,zeros(size(D, 2)))
   low = Optim.optimize(mu_low,zeros(size(D, 2)))
   bound = [Optim.minimizer(low), Optim.minimizer(up)]
end

Y = rand(Uniform(0,1), 10000)
D = [ones(10000) randn(10000)]

b_filter(Y, D[:,2], 0.4)

function delta_hat(b, X, D, Y)
   ml(delta)= sum((Y.<=D.*b)log(LogExpFunctions.logistic(X.*delta'))+(Y.>D.*b)log(1-LogExpFunctions.logistic(X.*delta')))
   optimize(ml, ones(size(X, 2)))