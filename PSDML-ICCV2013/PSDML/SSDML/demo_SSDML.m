function demo_SSDML(set_length)
%function demo for Set to Set Distance Metric Learning (SSDML)

%Input:
%set_length  number of frames per set   
%% parameter setting
lambda1 = 1e-3;  %the first parameter in RNP
lambda2 = 1e-1;  %the second parameter in RNP
chit=1;          %number of positive pairs per set
cmiss=3;         %number of negative pairs per set
accu=zeros(1,5);

%% 5-fold experiment 

for fold=1:5    
%get the training set 
[tr_dat,tt_dat,trls,ttls]=readyoutube47(fold);
%set to set distance metric learning(SSDML)
accu(fold)=SSDML(tr_dat,tt_dat,trls,ttls,set_length,chit,cmiss,lambda1,lambda2);
end     

rate=mean(accu);
fprintf(['recogniton rate of SSDML is ' num2str(rate)]);
fprintf('\n')
