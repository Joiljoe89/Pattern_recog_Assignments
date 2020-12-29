%  PR Assignment

clc
clear all

caseI=0;
caseII=1;
caseIII=0;

fpath = '/home/sukesh/IIT_Mandi/pr/2018/LS_Group2/';

data = load(strcat(fpath,'Class1.txt'),'-ascii');
x_c1=data;
l1=size(x_c1,1);

data = load(strcat(fpath,'Class2.txt'),'-ascii');
x_c2=data;
l2=size(x_c2,1);

data = load(strcat(fpath,'Class3.txt'),'-ascii');
x_c3=data;
l3=size(x_c3,1);

pot=0.75;  % Percentence of training data(75%)
noc=3;  % No of class
n=500;

min_x1=min([x_c1(:,1);x_c2(:,1);x_c3(:,1)]);
max_x1=max([x_c1(:,1);x_c2(:,1);x_c3(:,1)]);

g_x1=linspace(min_x1-5,max_x1+5,n);

min_x2=min([x_c1(:,2);x_c2(:,2);x_c3(:,2)]);
max_x2=max([x_c1(:,2);x_c2(:,2);x_c3(:,2)]);



l11=ceil(pot*l1);
l22=ceil(pot*l2);
l33=ceil(pot*l3);

x_c1_train=x_c1(1:l11,:);   % Train data separation
x_c2_train=x_c2(1:l22,:);
x_c3_train=x_c3(1:l33,:);

x_c1_test=x_c1(l11+1:end,:);   % Test data separation
x_c2_test=x_c2(l22+1:end,:);
x_c3_test=x_c3(l33+1:end,:);

test_all=[x_c1_test;x_c2_test;x_c3_test];
l_test=size(test_all,1);

mu1=mean(x_c1_train);          % Mean of every class
mu2=mean(x_c2_train);
mu3=mean(x_c3_train);


sigma1=((x_c1_train-repmat(mu1,l11,1))'*(x_c1_train-repmat(mu1,l11,1)))/l11; % Covatiance matrix calculation
sigma2=((x_c2_train-repmat(mu2,l22,1))'*(x_c2_train-repmat(mu2,l22,1)))/l22;
sigma3=((x_c3_train-repmat(mu3,l33,1))'*(x_c3_train-repmat(mu3,l33,1)))/l33;

%%%%%%%%%%%%%%%%%%%%%%% CASE I%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(caseI==1)
    
    V1=mean(diag((sigma1+sigma2+sigma3)/noc));
    sigma11=V1.*eye(l11,l11);

    plot([mu1(1) mu2(1)],[mu1(2) mu2(2)],'-r','linewidth',2);  % Line joining the means
    hold on
    plot([mu2(1) mu3(1)],[mu2(2) mu3(2)],'-g','linewidth',2);
    hold on
    plot([mu3(1) mu1(1)],[mu3(2) mu1(2)],'-m','linewidth',2);
    hold on

   
    W1=(mu1-mu2)./V1;    %  Decision line for g12
    X011=(mu1+mu2)/2;
    X021=repmat(X011,n,1);
    g12_x2=(-W1(1)/W1(2)).*(g_x1-X021(:,1)')+X021(:,2)'; % x2=(-W1/W2 * (X1-x0(1))+x0(2))

    W2=(mu2-mu3)./V1;    %  Decision line for g23
    X012=(mu2+mu3)/2;
    X022=repmat(X012,n,1);
    g23_x2=(-W2(1)/W2(2)).*(g_x1-X022(:,1)')+X022(:,2)';

    W3=(mu1-mu3)/V1;    %  Decision line for g31
    X013=(mu1+mu3)/2;
    X023=repmat(X013,n,1);
    g31_x2=(-W3(1)/W3(2)).*(g_x1-X023(:,1)')+X023(:,2)';

    p1 = polyfit(g_x1,g12_x2,1);  % Class I Area
    p2 = polyfit(g_x1,g31_x2,1);

    %calculate intersection
    x_i = fzero(@(x) polyval(p1-p2,x),1);
    y_i = polyval(p1,x_i);
    in13=[x_i,y_i];

    [m2 id2]=min(g31_x2);

    ml3=[g_x1(id2) m2];
    pt13=[max_x1+5 min_x2-5];
    [max1,id3]=max(g_x1);
    pt14=[max1,g12_x2(id3)];

    patch([in13(1) ml3(1) pt13(1) pt14(1)],[in13(2) ml3(2) pt13(2) pt14(2)],'o');  % plotting the area for class I

    hold on
    [m3,id4]=max(g23_x2);  % Class II Area
    pt12t=[g_x1(id4),m3];


    patch([in13(1) pt14(1) max_x1+5 min_x1-5  pt12t(1)],[in13(2) pt14(2) max_x2+5 max_x1+5 pt12t(2)],'y');

    patch([in13(1) pt12t(1) ml3(1)],[in13(2) pt12t(2) ml3(2)],'m');

    plot(x_c1_train(:,1),x_c1_train(:,2),'*r','linewidth',2);  % Plottig the Training data
    hold on
    plot(x_c2_train(:,1),x_c2_train(:,2),'*k','linewidth',2);
    hold on
    plot(x_c3_train(:,1),x_c3_train(:,2),'*g','linewidth',2);
    title('2D Data of 3 classes');


    plot(g_x1,g12_x2,'-r','linewidth',1);

    plot(g_x1,g23_x2,'-g','linewidth',1);

    plot(g_x1,g31_x2,'-m','linewidth',1);

    axis([min_x1-5 max_x1+5 min_x2-5 max_x2+5]);

    %%%%%%%%%%%%%%%%%%% Testing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    W(1,:)=mu1/V1;
    W(2,:)=mu2/V1;
    W(3,:)=mu3/V1;
    PC(1)=log(1/noc);PC(2)=log(1/noc);PC(3)=log(1/noc);
    W0(1)=-(mu1*mu1')./(2*V1)+PC(1); W0(2)=-(mu2*mu2')./(2*V1)+PC(2); W0(3)=-(mu3*mu3')./(2*V1)+PC(3);
    %TP=[];FP=[];FN=[];TN=[];
    RD=[];WD=[];  % Right and wrong decision
    CM=zeros(noc,noc);;% Confusion matrix

    for i=1:1:l_test
        if(i<=(l1-l11))
            cflag=1;
        elseif(i>(l1-l11) && i<=(l1-l11+l2-l22))
            cflag=2;
        else
            cflag=3;
        end
        t_data=test_all(i,:);
        for j=1:1:noc
            G(j)=W(j,:)*t_data'+W0(j);
        end
        [G_max,mid]=max(G);
   
        if(mid==cflag)
            RD=[RD;t_data];
        else
            WD=[WD;t_data];
        end  
   
        CM(mid,cflag)=CM(mid,cflag)+1;
  
    end
    A=(size(RD,1)/l_test)*100
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Case II %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(caseII==1)
    
    sigma=(sigma1+sigma2+sigma3)/noc;
    V=diag(sigma);
    

    plot([mu1(1) mu2(1)],[mu1(2) mu2(2)],'-r','linewidth',2);  % Line joining the means
    hold on
    plot([mu2(1) mu3(1)],[mu2(2) mu3(2)],'-g','linewidth',2);
    plot([mu3(1) mu1(1)],[mu3(2) mu1(2)],'-m','linewidth',2);

   
 
    W1=(inv(sigma))*(mu1-mu2)';    %  Decision line for g12
    X011=(mu1+mu2)/2;
    X021=repmat(X011,n,1);
    g12_x2=(-W1(1)/W1(2)).*(g_x1-X021(:,1)')+X021(:,2)'; % x2=(-W1/W2 * (X1-x0(1))+x0(2))

    W2=(inv(sigma))*(mu2-mu3)';    %  Decision line for g23
    X012=(mu2+mu3)/2;
    X022=repmat(X012,n,1);
    g23_x2=(-W2(1)/W2(2)).*(g_x1-X022(:,1)')+X022(:,2)';

    W3=(inv(sigma))*(mu1-mu3)';    %  Decision line for g31
    X013=(mu1+mu3)/2;
    X023=repmat(X013,n,1);
    g31_x2=(-W3(1)/W3(2)).*(g_x1-X023(:,1)')+X023(:,2)';

    p1 = polyfit(g_x1,g12_x2,1);  % Class I Area
    p2 = polyfit(g_x1,g31_x2,1);

    %calculate intersection
    x_i = fzero(@(x) polyval(p1-p2,x),1);
    y_i = polyval(p1,x_i);
    in13=[x_i,y_i];

    [m2 id2]=min(g31_x2);

    ml3=[g_x1(id2) m2];
    pt13=[max_x1+5 min_x2-5];
    [max1,id3]=max(g_x1);
    pt14=[max1,g12_x2(id3)];

    patch([in13(1) ml3(1) pt13(1) pt14(1)],[in13(2) ml3(2) pt13(2) pt14(2)],'o');  % plotting the area for class I

    hold on
    [m3,id4]=max(g23_x2);  % Class II Area
    pt12t=[g_x1(id4),m3];


     patch([in13(1) pt14(1) max_x1+5 min_x1-5  pt12t(1)],[in13(2) pt14(2) max_x2+5 max_x1+5 pt12t(2)],'y');

     patch([in13(1) pt12t(1) pt12t(1) ml3(1)],[in13(2) pt12t(2) ml3(2) ml3(2)],'m');

    plot(x_c1_train(:,1),x_c1_train(:,2),'*r','linewidth',2);  % Plottig the Training data
    hold on
    plot(x_c2_train(:,1),x_c2_train(:,2),'*k','linewidth',2);
    hold on
    plot(x_c3_train(:,1),x_c3_train(:,2),'*g','linewidth',2);
    title('2D Data of 3 classes');


    plot(g_x1,g12_x2,'-r','linewidth',1);

    plot(g_x1,g23_x2,'-g','linewidth',1);

    plot(g_x1,g31_x2,'-m','linewidth',1);

    axis([min_x1-5 max_x1+5 min_x2-5 max_x2+5]);

    %%%%%%%%%%%%%%%%%%% Testing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    W(1,:)=(inv(sigma))*mu1';
    W(2,:)=(inv(sigma))*mu2';
    W(3,:)=(inv(sigma))*mu3';
    PC(1)=log(1/noc);PC(2)=log(1/noc);PC(3)=log(1/noc);
    W0(1)=-(mu1*(inv(sigma))*mu1')/2+PC(1); W0(2)=-(mu2*(inv(sigma))*mu2')/2+PC(2); W0(3)=-(mu3*(inv(sigma))*mu3')/2+PC(3);
    %TP=[];FP=[];FN=[];TN=[];
    RD=[];WD=[];  % Right and wrong decision
    CM=zeros(noc,noc);;% Confusion matrix

    for i=1:1:l_test
        if(i<=(l1-l11))
            cflag=1;
        elseif(i>(l1-l11) && i<=(l1-l11+l2-l22))
            cflag=2;
        else
            cflag=3;
        end
        t_data=test_all(i,:);
        for j=1:1:noc
            G(j)=W(j,:)*t_data'+W0(j);
        end
        [G_max,mid]=max(G);
   
        if(mid==cflag)
            RD=[RD;t_data];
        else
            WD=[WD;t_data];
        end  
   
        CM(mid,cflag)=CM(mid,cflag)+1;
  
    end
    A=(size(RD,1)/l_test)*100
    
end