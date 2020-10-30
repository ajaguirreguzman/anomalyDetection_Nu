% meanvariance(x) returns the mean (mu) and
% variance (sigma2) of the data in x

function [mu,sigma2]=fitparam(x)

% number of training examples
m=length(x);

% mean
mu=(1/m)*sum(x);

% variance
error2=(x-mu).^2;
sigma2=(1/m)*sum(error2);

end
