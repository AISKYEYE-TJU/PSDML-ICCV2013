function [proto,yr]=PSDpair(tr_dat,tt_dat,trls,ttls,kappa,k)
%function: generate positive&negative pairs for point to set distance
%Input:
%tr_dat  training set  
%tt_dat  test set
%trls    training label
%ttls    test label
%kappa   regularization parameter 
%k       number of negative pairs per sample

%Output: 
%proto   positve and negative pairs
%yr      sample pair label (i.e., negative pair +1, positve pair -1) 

%% projection matrix computation
Class_NUM=length(unique(trls));
Dim=size(tr_dat,1);
Proj_M=cell(1,Class_NUM);
for i=1:Class_NUM
Dc       =  tr_dat(:,trls==i);
Proj_M{i}= (inv(Dc'*Dc+kappa*eye(size(Dc,2))))*Dc';
end

%% get positve and negative pairs
proto=[];
yr=[];
for indst=1:size(tt_dat,2)
  Proj_M1=Proj_M;  
  temp=trls;
  temp(indst)=inf;
  Dc        =  tr_dat(:,temp==ttls(indst));
  Proj_M1{ttls(indst)}= (inv(Dc'*Dc+kappa*eye(size(Dc,2))))*Dc';
  error=zeros(1,Class_NUM);
  temp_pro=zeros(2*Dim,Class_NUM);
  for ci = 1:Class_NUM
     coef_c    =  Proj_M1{ci}*tt_dat(:,indst);
     Dc        =  tr_dat(:,temp==ci);
     error(ci) = (norm(tt_dat(:,indst)-Dc*coef_c))^2;
     temp_pro(:,ci)=[tt_dat(:,indst);Dc*coef_c];
  end
  proto_temp(:,1)=temp_pro(:,ttls(indst));
  temp_pro(:,ttls(indst))=[];
  error(ttls(indst))=[];
  [~,index]=sort(error);
  proto_temp(:,2:k+1)=temp_pro(:,index(1:k));
  zr=[-1,ones(1,k)*1];
  yr=[yr,zr];
  proto=[proto,proto_temp];
end
