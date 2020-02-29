function accu=SSDclassify(tr_dat,tt_dat,trls,ttls,lambda1,lambda2,set_length)

%function:  positive and negative pairs generation for set to set distance
%Input
%tr_dat        training sets (cell data: one image set per cell)
%tt_dat        test sets (cell data: one image set per cell)
%trls          training label
%ttls          test label
%set_length    num of frames per set
%lambda1       parameter in RNP
%lambda2       parameter in RNP

%function: set to set distance based classification
s=0;
num_test=length(tt_dat);
num_train=length(tr_dat);
label=zeros(1,num_test);
for i=1:num_test
         s=s+1;  
         AA=tt_dat{i};
         if size(AA,2)<set_length
          X1=tt_dat{i};
         else
          X1=tt_dat{i}(:,1:set_length);
         end
          X1 = X1./(repmat(sqrt(sum(X1.*X1)),[size(X1,1),1]));
          
          dist=zeros(1,num_train);
          for k=1:num_train
           AA=tr_dat{k};
           if size(AA,2)<set_length
             X2=tr_dat{k};
           else
             X2=tr_dat{k}(:,1:set_length);
           end  
           X2 = X2./(repmat(sqrt(sum(X2.*X2)),[size(X2,1),1]));
           
           dist(k)=L2C_CorrectS(X1,X2,lambda1,lambda2);
          end
          
          [~,index]=min(dist);
          fprintf(['The percentage of classified image sets is' num2str(s) '/' num2str(num_test)]);
          fprintf('\n')
          label(s)=trls(index);
end
accu=sum(ttls==label)/length(label); 