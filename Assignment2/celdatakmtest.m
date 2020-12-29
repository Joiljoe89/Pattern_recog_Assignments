clc
clear all
close all

kmeans1=0;
gmm1=1;
load('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/group02/Train/Train_MVF.mat');
data=MVF;
clear MVF
l1=size(data,1);
l=ceil(l1/12);
data=data(1:l,:);

if(kmeans1==1)
noc=3;  % No of class
[ids,mu]=kmeans(data,noc);
save('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/ids1','ids');
save('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/mus1','mu');
end

if(gmm1==1)
 noc=3;
[ids,mu_0]=kmeans(data,noc);
CD=cell(noc,1);
CD{1,1}=data(ids==1,:);
CD{2,1}=data(ids==2,:);
CD{3,1}=data(ids==3,:);
 k=2;  % No of mix
iteration=6;  
[mu_1,sigma_1,pi_1,N_k1,ll1,IL1]=gussianMixMod(CD{1,1},k,iteration);
[mu_2,sigma_2,pi_2,N_k2,ll2,IL2]=gussianMixMod(CD{2,1},k,iteration);
[mu_3,sigma_3,pi_3,N_k3,ll3,IL3]=gussianMixMod(CD{3,1},k,iteration);

save('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/sigma_g1','sigma_1');
save('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/mu_g1','mu_1');
save('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/pi_g1','pi_1');

save('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/sigma_g2','sigma_2');
save('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/mu_g2','mu_2');
save('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/pi_g2','pi_2');

save('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/sigma_g3','sigma_3');
save('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/mu_g3','mu_3');
save('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/pi_g3','pi_3');
end