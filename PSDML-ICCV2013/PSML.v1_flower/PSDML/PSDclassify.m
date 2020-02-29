function accu=PSDclassify(tr_dat,tt_dat,trls,ttls,kappa,M)
%function: Point to Set Distance (PSD) based classification
%Input:
%tr_dat  training set  
%tt_dat  test set
%trls    training label
%ttls    test label
%kappa   regularization parameter 
%M       Learned Matrix M

%Output:
% accu   Classification accuracy

%% projection matrix computation 
Class_NUM=length(unique(trls));
Proj_M=cell(1,Class_NUM);
for i=1:Class_NUM
Dc       =  tr_dat(:,trls==i);
Proj_M{i}= (inv(Dc'*Dc+kappa*eye(size(Dc,2))))*Dc';
end
%% testing
num_test=size(tt_dat,2);
ID=zeros(1,num_test);
for indst=1:num_test
  error=zeros(1,Class_NUM);  
  for ci = 1:Class_NUM
     coef_c    =  Proj_M{ci}*tt_dat(:,indst);
     Dc        =  tr_dat(:,trls==ci);
     temp=tt_dat(:,indst)-Dc*coef_c;
     error(ci) =temp'*M*temp;
  end
  [~,ID(indst)]=min(error);
end
accu=sum(ID==ttls)/length(ttls);
