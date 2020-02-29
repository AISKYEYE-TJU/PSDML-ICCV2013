function   accu=PSDML(tr_dat,tt_dat,tv_dat,trls,ttls,tvls,kappa,k,psd_option)
%function: Point to Set Distance Metric Learning (PSDML)
%Input:
%tr_dat  training set  
%tt_dat  test set
%trls    training label
%ttls    test label
%kappa   regularization parameter 
%k       number of negative pairs per sample
%psd_option  0- Positive semidefinite 1- no constraint on M

%Output:
% accu   Classification accuracy

%% positive/negative sample pairs
% tr_dat       =    tr_dat./ repmat(sqrt(sum(tr_dat.*tr_dat)),[size(tr_dat,1) 1]); % unit norm 2
% tt_dat       =    tt_dat./ repmat(sqrt(sum(tt_dat.*tt_dat)),[size(tt_dat,1) 1]); % unit norm 2
[proto,zr]=PSDpair_flower(tr_dat,tv_dat,trls,tvls,kappa,k);
%% metric learning by SVM
para='-t 5 -h 0 -f 1';
[SVM_model,~]=svmtraintime(zr',proto',para);
M=getM(SVM_model,psd_option);
%% classification by the learned matrix
accu=PSDclassify(tr_dat,tt_dat,trls,ttls,kappa,M);
fprintf(['recogniton rate of PSDML is ' num2str(accu)]);
fprintf('\n')