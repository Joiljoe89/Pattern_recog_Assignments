clc
clear all
close all

% % aa=load('/media/sukesh/NEW VOLUME/group2/train/24D_data.mat');
% % data1_tr=aa.aRGB_24bins;
% % data2_tr=aa.bRGB_24bins;
% % data3_tr=aa.cRGB_24bins;

 load('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/group2/train/coast/coast.mat');
 data1_tr=BC;
 clear 'BC'
 l1=size(data1_tr,1);

 load('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/group2/train/kennel_outdoor/kennel_outdoor.mat');
data2_tr=BC;
clear 'BC'
 l2=size(data2_tr,1);
 
 load('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/group2/train/volleyball_court_indoor/volleyball_court_indoor.mat');
 data3_tr=BC;
clear 'BC'
 l3=size(data3_tr,1);


noc=3;  % No of class

load('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/group2/test/coast/coast.mat');
data1_ts=BC;
clear 'BC'
td1l=size(data1_ts,1);
 
load('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/group2/test/kennel_outdoor/kennel_outdoor.mat');
data2_ts=BC;
clear 'BC'
td2l=size(data2_ts,1);
 
load('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/group2/test/volleyball_court_indoor/volleyball_court_indoor.mat');
data3_ts=BC;
clear 'BC'
td3l=size(data3_ts,1);
 
data_ts=[data1_ts;data2_ts;data3_ts];
ts_l=size(data_ts,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Training %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

K=16; % no of mix/gaussian
iteration=7;

[mu1,sigma1,pi1,N_k1,ll1,IL1]=gussianMixMod(data1_tr,K,iteration);
[mu2,sigma2,pi2,N_k2,ll2,IL2]=gussianMixMod(data2_tr,K,iteration);
[mu3,sigma3,pi3,N_k3,ll3,IL3]=gussianMixMod(data3_tr,K,iteration);

 figure(1)
 plot(IL1(:,1),IL1(:,2),'m','linewidth',2);
 hold on
 plot(IL2(:,1),IL2(:,2),'g','linewidth',2);
 hold on
 plot(IL3(:,1),IL3(:,2),'b','linewidth',2);
 legend('Coast', 'Outdoor', 'Indoor')
 xlabel('Iteration');
 ylabel('Log likihood');
 title('Iteration Vs Log likelihood');

%%%%%%%%%%%%%%%%%%%%%% Testing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
di=size(data_ts,2);
Cls=cell(noc,1);
RD=[];WD=[];  % Right and wrong decision
CM=zeros(noc,noc);% Confusion matrix

for jj=1:1:ts_l
    td=data_ts(jj,:);  % single Test data
    
    if(jj<=td1l)   % From ground truth
            cflag=1;
        elseif(jj>td1l && jj<=td1l+td2l)
            cflag=2;
        else
            cflag=3;
    end
    
    llt_c1=0;  % ll for test data for class 1
    llt_c2=0;
    llt_c3=0;
    for jj1=1:1:K
        llt_c1=llt_c1+pi1(jj1)*(1/((2*pi)^(di/2))*((det(sigma1{jj1,1}))^0.5))*exp(-0.5*(td-mu1(jj1,:))*inv(sigma1{jj1,1})*(td-mu1(jj1,:))');
        llt_c2=llt_c2+pi2(jj1)*(1/((2*pi)^(di/2))*((det(sigma2{jj1,1}))^0.5))*exp(-0.5*(td-mu2(jj1,:))*inv(sigma2{jj1,1})*(td-mu2(jj1,:))');
        llt_c3=llt_c3+pi3(jj1)*(1/((2*pi)^(di/2))*((det(sigma3{jj1,1}))^0.5))*exp(-0.5*(td-mu3(jj1,:))*inv(sigma3{jj1,1})*(td-mu3(jj1,:))');
    end
    
    llt=[llt_c1;llt_c2;llt_c3];
    [max1,cl]=max(llt);
    Cls{cl,1}=[Cls{cl,1};td];
    cflag;
    cl;
    
    if(cl==cflag)
            RD=[RD;td];
        else
            WD=[WD;td];
    end  
   
     CM(cl,cflag)=CM(cl,cflag)+1;
       
end
Accuracy=(size(RD,1)/ts_l)*100   % Accuracy

 C1=Cls{1,1};
 C2=Cls{2,1};
 C3=Cls{3,1};
