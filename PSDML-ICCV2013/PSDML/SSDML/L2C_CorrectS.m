function [dist,sampepair] =  L2C_CorrectS(X1,X2,lambda1,lambda2)

X1  =  X1./( repmat(sqrt(sum(X1.*X1)), [size(X1,1),1]) );
X2  =  X2./( repmat(sqrt(sum(X2.*X2)), [size(X2,1),1]) );

[num1] = SET_PCA_my(X1);
[num2] = SET_PCA_my(X2);

newy = [zeros(size(X1,1),1); 1;1];
tem1 = [ones(1,size(X1,2)) zeros(1,size(X2,2))];
tem2 = [zeros(1,size(X1,2)) sqrt(lambda1/lambda2)*ones(1,size(X2,2))];
newD = [[X1 -sqrt(lambda1/lambda2)*X2];tem1;tem2];

DD            =  newD'*newD;
Dy            =  newD'*newy;
x             =  (DD+lambda1*eye(size(newD,2)))\Dy;

coef1      = x(1:size(X1,2),1);
coef2      = sqrt(lambda1/lambda2)*x(size(X1,2)+1:end,1);
dist       = norm(X1*coef1-X2*coef2,2)^2*(num1+num2);
sampepair=[X1*coef1; X2*coef2]*sqrt(num1+num2);