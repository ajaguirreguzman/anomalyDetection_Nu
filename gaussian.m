% gaussian(x,mu,sigma2) returns the probability
% density function of reach example in x,
% where mu is its mean and sigma2 its variance

function p=gaussian(x,mu,sigma2)

% density
error2=(x-mu).^2;
p=(1/sqrt(2*pi*sigma2))*exp(-error2/2/sigma2);

end
