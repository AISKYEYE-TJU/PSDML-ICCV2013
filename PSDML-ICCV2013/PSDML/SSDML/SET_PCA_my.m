function [num] = SET_PCA_my(X)

[variances] = svd(X);
index       = find(variances>=0.1*variances(1));
num = sum(variances);


