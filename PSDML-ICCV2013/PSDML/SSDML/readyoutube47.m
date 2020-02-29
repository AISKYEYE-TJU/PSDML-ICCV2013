function  [tr_dat,tt_dat,trls,ttls]=readyoutube47(fold)
%function: load YouTube data
%Note: For copyright reason, please prepare the youtube47 data by yourself.
%Input:
%fold 
%Output:
%tr_dat   training image sets (cell data)
%tt_dat   test image sets (cell data)
%trls     training label
%ttls     test label

load youtube47  
s1=0;
s2=0;
num_train=3;
num_test=6;
for i=1:47
    temp=youtube47{i};
    for j=1:num_train
        s1=s1+1;
    tr_dat{s1}=temp{ccc{i}(fold,j)};
    end
    for j=num_train+1:num_test+num_train
        s2=s2+1;
    tt_dat{s2}=temp{ccc{i}(fold,j)};
    end
end

trls=[];
ttls=[];
for i=1:47
trls=[trls,ones(1,num_train)*i];
ttls=[ttls,ones(1,num_test)*i];
end

clear youtube47