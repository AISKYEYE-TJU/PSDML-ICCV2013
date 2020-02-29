function demo_PSDML(dataname,k_neg,fea_dim)

%Input:
% dataname  name of data
% k_neg     number of negative pairs per sample 
% fea_dim   feature dimension for PCA

%Usage:
% demo_PSDML('yaleB_PSDML',1,50)
% demo_PSDML('yaleB_PSDML',2,100)
% demo_PSDML('yaleB_PSDML',2,150)

load(dataname); %load the data set
kappa=0.001;
psd_option=0;
accu_tm=zeros(1,20);

for mp=1:20
    
%get training and test set for random experiment    
tr_dat=[];
tt_dat=[];
trls=[];
ttls=[];
k_train=15;
randpp=randp{mp};
for i=1:38
   temp=find(label==i);
   temp_dat=featureMat(:,temp);
   rand_temp=randpp{i};
   tr_dat=[tr_dat,temp_dat(:,rand_temp(1:k_train))];
   tt_dat=[tt_dat,temp_dat(:,rand_temp(k_train+1:end))];
   trls=[trls,ones(1,k_train)*i];
   ttls=[ttls,ones(1,length(temp)-k_train)*i];
end
P=Eigenface_f(tr_dat,fea_dim);
tr_dat=P'*tr_dat;
tt_dat=P'*tt_dat;
tr_dat       =    tr_dat./ repmat(sqrt(sum(tr_dat.*tr_dat)),[size(tr_dat,1) 1]); % unit norm 2
tt_dat       =    tt_dat./ repmat(sqrt(sum(tt_dat.*tt_dat)),[size(tt_dat,1) 1]); % unit norm 2
%point to set distance metric learning
accu_tm(mp)=PSDML(tr_dat,tt_dat,trls,ttls,kappa,k_neg,psd_option);
end
rate=mean(accu_tm);

fprintf('\n')
fprintf(['recogniton rate is ' num2str(rate*100,3)]);
fprintf('\n')