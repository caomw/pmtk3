function [postMean, postCov] = ppcaPost(X, W, mu, sigma2, evals, evecs)
% Probabilistic PCA - computer posterior on Z
% postMean(i,:) = E[Z|X(i,:)]
% postCov(:,:) is the same for all i

[d K] = size(W);
[N d] = size(X);
Lam = evals(1:K)';
U = evecs(:, 1:K);
Minv = diag(1./Lam);
postCov = sigma2*Minv;
MinvWT = (1./Lam) .* sqrt(Lam - sigma2) * U';
postMean = (MinvWT*(X'-repmat(mu(:),1,N)))';

if 0
   M = diag(Lam);
   M2 = W'*W + sigma2*eye(K);
   assert(approxeq(M, M2))
   MinvWT2 = inv(M)*W';
   assert(approxeq(MinvWT, MinvWT2))
end

end