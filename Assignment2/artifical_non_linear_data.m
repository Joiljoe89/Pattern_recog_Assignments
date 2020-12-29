clc
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  GMM for Artificially nonlinearly separable data (DS-1) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = load('D:/Seafile/Seafile/My Library/IIT Mandi/even_course_feb18/CS669_PR/assignment2/data/asgn1_data/non-linear_data2.txt','-ascii');

data1=data(1:500,:);
lc1=size(data1,1);
data2=data(501:1000,:);
lc2=size(data2,1);
data3=data(1001:1500,:);
lc3=size(data3,1);

pot=0.75;  % Percentence of training data(75%)
noc=3;  % No of class
lc1tr=ceil(pot*lc1);
lc2tr=ceil(pot*lc2);
lc3tr=ceil(pot*lc3);

data1_tr=data1(1:lc1tr,:);   % Train data
data2_tr=data2(1:lc2tr,:);
data3_tr=data3(1:lc3tr,:);

data1_ts=data1(lc1tr+1:end,:);  % Test data
data2_ts=data2(lc2tr+1:end,:);
data3_ts=data3(lc3tr+1:end,:);

td1l=length(data1_ts(:,1));   % Length of test data of class 1
td2l=length(data2_ts(:,1));
td3l=length(data3_ts(:,1));
data_ts=[data1_ts;data2_ts;data3_ts];
ts_l=size(data_ts,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Training %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

K=4; % no of mix/gaussian
iteration=25;

[mu1,sigma1,pi1,N_k1,ll1,IL1]=gussianMixMod(data1_tr,K,iteration);
[mu2,sigma2,pi2,N_k2,ll2,IL2]=gussianMixMod(data2_tr,K,iteration);
[mu3,sigma3,pi3,N_k3,ll3,IL3]=gussianMixMod(data3_tr,K,iteration);
 figure(1)
 plot(IL1(:,1),IL1(:,2),'m','linewidth',2);
 hold on
 plot(IL2(:,1),IL2(:,2),'g','linewidth',2);
 hold on
 plot(IL3(:,1),IL3(:,2),'b','linewidth',2);
 legend('Class1', 'Class2', 'Class3')
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
 
 n=250;
 min_x1=min([data1_tr(:,1);data2_tr(:,1);data3_tr(:,1)]);
 max_x1=max([data1_tr(:,1);data2_tr(:,1);data3_tr(:,1)]);
 X=linspace(min_x1-5,max_x1+5,n);

 min_x2=min([data1_tr(:,2);data2_tr(:,2);data3_tr(:,2)]);
 max_x2=max([data1_tr(:,2);data2_tr(:,2);data3_tr(:,2)]);
 Y=linspace(min_x2-5,max_x2+5,n);
 
 figure(2)
 plot(C1(:,1),C1(:,2),'*m','linewidth',2);
 hold on
 plot(C2(:,1),C2(:,2),'*g','linewidth',2);
 hold on
 plot(C3(:,1),C3(:,2),'*b','linewidth',2);
 axis([min_x1-1 max_x1+1 min_x2-1 max_x2+1]);
 xlabel('X1');
 ylabel('X2');
 title('Test data(2D Artificial)');

  figure(3)
  plot(data1_tr(:,1),data1_tr(:,2),'*r','linewidth',2);  % Plottig the Training data
  hold on
  plot(data2_tr(:,1),data2_tr(:,2),'*g','linewidth',2);  % Plottig the Training data
  hold on
  plot(data3_tr(:,1),data3_tr(:,2),'*b','linewidth',2);  % Plottig the Training data
  hold on
  
  for j1=1:1:K
     P=cdcP(X,Y,mu1(j1,:),sigma1{j1,1});
     contour(X,Y,P,'k','linewidth',2);
     hold on
     P=cdcP(X,Y,mu2(j1,:),sigma2{j1,1});
     contour(X,Y,P,'k','linewidth',2);
     hold on
     P=cdcP(X,Y,mu3(j1,:),sigma3{j1,1});
     contour(X,Y,P,'k','linewidth',2);
     hold on
  end
  
  axis([min_x1-1 max_x1+1 min_x2-1 max_x2+1]);
  xlabel('X1');
  ylabel('X2');
  title('Constant density contour with training data(2D Artificial)');
  
  
 n1=130;
 X=linspace(min_x1-1,max_x1+1,n1);
 Y=linspace(min_x2-1,max_x2+1,n1);
 
 figure(4)
 plot(data1_tr(:,1),data1_tr(:,2),'*r','linewidth',2);  % Plottig the Training data
 hold on
 plot(data2_tr(:,1),data2_tr(:,2),'*g','linewidth',2);  % Plottig the Training data
 hold on
 plot(data3_tr(:,1),data3_tr(:,2),'*b','linewidth',2);  % Plottig the Training data
 hold on
 legend('Class1', 'Class2', 'Class3')
 
 for k1=1:1:n1
     for l1=1:1:n1
         d=[X(k1) Y(l1)];
         
         llt_c1=0;  % ll for test data for class 1
         llt_c2=0;
         llt_c3=0;
         for jj1=1:1:K
            llt_c1=llt_c1+pi1(jj1)*(1/((2*pi)^(di/2))*((det(sigma1{jj1,1}))^0.5))*exp(-0.5*(d-mu1(jj1,:))*inv(sigma1{jj1,1})*(d-mu1(jj1,:))');
            llt_c2=llt_c2+pi2(jj1)*(1/((2*pi)^(di/2))*((det(sigma2{jj1,1}))^0.5))*exp(-0.5*(d-mu2(jj1,:))*inv(sigma2{jj1,1})*(d-mu2(jj1,:))');
            llt_c3=llt_c3+pi3(jj1)*(1/((2*pi)^(di/2))*((det(sigma3{jj1,1}))^0.5))*exp(-0.5*(d-mu3(jj1,:))*inv(sigma3{jj1,1})*(d-mu3(jj1,:))');
         end
    
        llt=[llt_c1;llt_c2;llt_c3];
        [max1,cl]=max(llt);
        if(cl==1)
           plot(X(k1),Y(l1),'.','color',[.8 0 0],'linewidth',1);    
           hold on
         elseif(cl==2)
           plot(X(k1),Y(l1),'.','color',[0 0.8 0],'linewidth',1);
           hold on
          else
           plot(X(k1),Y(l1),'.','color',[0 0 0.8],'linewidth',1);
           hold on
        end
         
     end
 end
 
 axis([min_x1-1 max_x1+1 min_x2-1 max_x2+1]);
 xlabel('X1');
 ylabel('X2');
 title('Decision region  with training data(2D Artificial)');
