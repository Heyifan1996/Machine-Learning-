function [ y ] = p( x,u,n,covs )%매쪽쵱똑변鑒
y=exp(-(n/2)*log(2*pi) - 0.5*log(det(covs))-0.5*(x-u)*covs^-1*(x-u)');
end

