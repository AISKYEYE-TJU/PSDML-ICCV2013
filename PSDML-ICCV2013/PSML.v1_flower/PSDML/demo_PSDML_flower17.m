load flower
kappa=0.001;
psd_option=0;
k_neg=16;
for f_index=1:7
for i=1:3
trls=label(trn{i});
ttls=label(tst{i});
tvls=label(val{i});
mu = 1/mean(mean(D{f_index}(trn{i},trn{i})));
KM = exp(-mu*D{f_index});
tr_dat=KM(trn{i},trn{i});
tt_dat=KM(trn{i},tst{i});
tv_dat=KM(trn{i},val{i});
accu_tm(i)=PSDML(tr_dat,tt_dat,tv_dat,trls,ttls,tvls,kappa,k_neg,psd_option);
end
rate(f_index)=mean(accu_tm);
fprintf('\n')
fprintf(['recogniton rate is ' num2str(rate*100,3)]);
fprintf('\n')
end