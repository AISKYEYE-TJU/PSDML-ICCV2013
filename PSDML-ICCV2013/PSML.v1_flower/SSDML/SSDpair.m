function  [zr,yr]=SSDpair(tr_dat,trls,set_length,chit,cmiss,lambda1,lambda2)

%function:  positive and negative pairs generation for set to set distance
%Input
%tr_dat       training sets (cell data: one image set per cell)
%trls          training label
%set_length    num of frames per set
%chit          num of positive pairs per set
%cmiss         num of negative pairs per set
%lambda1       parameter in RNP
%lambda2       parameter in RNP

%Output
%zr            positive and negative pairs
%yr            label of positive/negative pairs

sampleNum=length(tr_dat);
dim=size(tr_dat{1},1);
zr=zeros(2*dim,chit*cmiss*sampleNum);
yr=ones(1,chit*cmiss*sampleNum);
indexzr=1;

for i=1:length(tr_dat) 
    
    Distik=zeros(sampleNum);
    sampepair=cell(sampleNum);
    AA=tr_dat{i};
    if size(AA,2)<set_length
      X1=tr_dat{i};
    else
      X1=tr_dat{i}(:,1:set_length);
    end  
    X1 = X1./(repmat(sqrt(sum(X1.*X1)),[size(X1,1),1]));
    
    for j=1:length(tr_dat) 
     AA=tr_dat{j};
     if size(AA,2)<set_length
       X2=tr_dat{j};
     else
       X2=tr_dat{j}(:,1:set_length);
     end  
    X2 = X2./(repmat(sqrt(sum(X2.*X2)),[size(X2,1),1]));
    %Tips: RNP is used here. You can also use AHISD, CHISD, SANP, MMD or
    %other set to set distance 
    [Distik(j),sampepair{j}]=L2C_CorrectS(X1,X2,lambda1,lambda2);    
    end
    
    HitDist=Inf*ones(sampleNum,1);
    MissDist=Inf*ones(sampleNum,1);
    SameLabel=find(trls==trls(i));
    DiffLabel=find(trls~=trls(i));
    HitDist(SameLabel)=Distik(SameLabel);
    MissDist(DiffLabel)=Distik(DiffLabel);
    HitDist(i)=Inf;
    [~,SortedHitIndex]=sort(HitDist);
    [~,SortedMissIndex]=sort(MissDist);
    HitSet=SortedHitIndex(1:chit);
    MissSet=SortedMissIndex(1:cmiss);
    for k=union(HitSet',MissSet')
        zr(:,indexzr)=sampepair{k};
        if trls(i)==trls(k)
            yr(indexzr)=-1;
        else
            yr(indexzr)=1;
        end
        indexzr=indexzr+1;
    end
        
end