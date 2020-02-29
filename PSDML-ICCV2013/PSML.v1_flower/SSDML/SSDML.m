function  accu=SSDML(tr_dat,tt_dat,trls,ttls,set_length,chit,cmiss,lambda1,lambda2)

%function: Set to Set Distance Metric Learning 
%Input
%tr_dat        training sets (cell data: one image set per cell e.g., image 
%              set size 900*160 900 is feature dimension  160 is number of frames)
%tt_dat        test sets (cell data: one image set per cell)
%trls          training label
%ttls          test label
%set_length    num of frames per set
%chit          num of positive pairs per set
%cmiss         num of negative pairs per set
%lambda1       parameter in RNP
%lambda2       parameter in RNP

%Output
%accu          set to set distance based classification accuracy

%% positive/negative pair generation
[zr,yr]=SSDpair(tr_dat,trls,set_length,chit,cmiss,lambda1,lambda2);

%% metric learning
[SVM_model,~]=svmtraintime(yr',zr','-t 5 -h 0 -f 1');
M=getM(SVM_model,0);
[vecs,vals] = eig(0.5 * (M+M'));
L= real(abs(vals)).^0.5 * vecs';  

%% set to set distance based classification
for k=1:length(tr_dat)
    tr_dat{k}=L*tr_dat{k};
end
for k=1:length(tt_dat)
    tt_dat{k}=L*tt_dat{k};
end

accu=SSDclassify(tr_dat,tt_dat,trls,ttls,lambda1,lambda2,set_length);
fprintf(['recogniton rate of SSDML is ' num2str(accu)]);
fprintf('\n')