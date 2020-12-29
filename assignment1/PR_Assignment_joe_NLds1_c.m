%%%PR Assignment1%%%%%%Joe_D17024%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
%%Fetching 2D Dataset
%%Fetching first 500x2 2D NL Dataset
fpath = 'D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\';
data = load(strcat(fpath,'non-linear_data2.txt'),'-ascii');
Class_data1=data(1:500,:);

%%Fetching second 500x2 2D NL Dataset
Class_data2=data(501:1000,:);

%%Fetching third 500x2 2D NL Dataset
Class_data3=data(1001:1500,:);

    %%Fetching DS1,Class1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Class_train_data1=Class_data1(1:375,:);
        
        mean1=mean(Class_train_data1,1)
        var1=var(Class_train_data1)
        covariance1=cov(Class_train_data1)
                       
        Class_test_data1=Class_data1(1:125,:);%test data
    %%Fetching DS1,Class2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Class_train_data2=Class_data2(1:375,:);
        mean2=mean(Class_train_data2,1)
        var2=var(Class_train_data2)
        covariance2=cov(Class_train_data2)
                       
        Class_test_data2=Class_data2(1:125,:);%test data
    %%Fetching DS1,Class3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Class_train_data3=Class_data3(1:375,:);
        mean3=mean(Class_train_data3)
        var3=var(Class_train_data3)
        covariance3=cov(Class_train_data3)
               
        Class_test_data3=Class_data3(1:125,:);%test data        
%%Bayes Classifier case-a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=[500 2];
n_class=3;
n_train=size(Class_train_data3);

min_x1=min([Class_train_data1(:,1);Class_train_data2(:,1);Class_train_data3(:,1)]);
max_x1=max([Class_train_data1(:,1);Class_train_data2(:,1);Class_train_data3(:,1)]);
min_x2=min([Class_train_data1(:,2);Class_train_data2(:,2);Class_train_data3(:,2)]);
max_x2=max([Class_train_data1(:,2);Class_train_data2(:,2);Class_train_data3(:,2)]);

gx1=linspace(min_x1-5,max_x1+5,n(1));
%%Diagonal covariance matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cov1=eye(2,2).*covariance1;
cov2=eye(2,2).*covariance2;
cov3=eye(2,2).*covariance3;
inv_cov1=inv(cov1);
inv_cov2=inv(cov2);
inv_cov3=inv(cov3);

figure(3);
hold on
axis([min_x1-5 max_x1+5 min_x2-5 max_x2+5]);
%%%shade the area under decision boundary%%%%%%%%
o31=-(inv_cov3-inv_cov1).*(.5);
w31=((mean3*inv_cov3)-(mean1*inv_cov1));
w031=(-.5.*((mean3*inv_cov3*mean3')-(mean1*inv_cov1*mean1')))...
            -(.5*log(det(cov3)/det(cov1)));
o12=-(inv_cov1-inv_cov2).*(.5);
w12=((mean1*inv_cov1)-(mean2*inv_cov2));
w012=(-.5.*((mean1*inv_cov1*mean1')-(mean2*inv_cov2*mean2')))...
            -(.5*log(det(cov1)/det(cov2)));
o23=-(inv_cov2-inv_cov3).*(.5);
w23=((mean2*inv_cov2)-(mean3*inv_cov3));
w023=(-.5.*((mean2*inv_cov2*mean2')-(mean3*inv_cov3*mean3')))...
            -(.5*log(det(cov2)/det(cov3)));
%%%shade the area under decision boundary%%%%%%%%
C1_point=[]; C2_point=[]; C3_point=[];
for l=(min_x1-5):.3:(max_x1+5)
    for m=(min_x2-5):.3:(max_x2+5)
        x=[l m]';
        C1=(x'*o12*x)+(w12*x)+w012;
        C2=(x'*o23*x)+(w23*x)+w023;
        C3=(x'*o31*x)+(w31*x)+w031;
        [Cval, Cindx]=max([C1,C2,C3]);
        if  Cindx==1
            C1_point=[C1_point,x];
        elseif Cindx==2
            C2_point=[C2_point,x];
        else
            C3_point=[C3_point,x];
        end
    end
end
C1_x=C1_point(1,:);C1_y=C1_point(2,:);
C2_x=C2_point(1,:);C2_y=C2_point(2,:);
C3_x=C3_point(1,:);C3_y=C3_point(2,:);
plot(C1_x,C1_y,'oy')
plot(C2_x,C2_y,'oc')
plot(C3_x,C3_y,'om')
%%%plot test data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(Class_test_data1(:,1),Class_test_data1(:,2),'r*');
plot(Class_test_data2(:,1),Class_test_data2(:,2),'g*');
plot(Class_test_data3(:,1),Class_test_data3(:,2),'b*');
%%%contour for class1%%%%
        x1 = (min_x1-5):.5:(max_x1+5); x2 = (min_x2-5):.5:(max_x2+5);
        [X1,X2] = meshgrid(x1,x2);
        F = mvnpdf([X1(:) X2(:)],mean1,covariance1);
        F = reshape(F,length(x2),length(x1));
        contour(x1,x2,F,10);
%%%contour for class2%%%%
        x1 = (min_x1-5):.5:(max_x1+5); x2 = (min_x2-5):.5:(max_x2+5);
        [X1,X2] = meshgrid(x1,x2);
        F = mvnpdf([X1(:) X2(:)],mean2,covariance2);
        F = reshape(F,length(x2),length(x1));
        contour(x1,x2,F);
%%%contour for class3%%%%
        x1 = (min_x1-5):.5:(max_x1+5); x2 = (min_x2-5):.5:(max_x2+5);
        [X1,X2] = meshgrid(x1,x2);
        F = mvnpdf([X1(:) X2(:)],mean3,covariance3);
        F = reshape(F,length(x2),length(x1));
        contour(x1,x2,F);
hold off
%%%confusion matrix variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a1=0;a2=0;a3=0;b1=0;b2=0;b3=0;c1=0;c2=0;c3=0;
for k=(1:1:125)
    %%%class1,2%%
    x=[Class_test_data1(k,1) Class_test_data1(k,2)]';
    g1=(x'*o12*x)+(w12*x)+w012;
    g2=(x'*o23*x)+(w23*x)+w023;
    g3=(x'*o31*x)+(w31*x)+w031;
    [gval,gindx]=max([g1;g2;g3]);
    if gval==g1
        a1=a1+1;
    elseif gval==g2
        b1=b1+1;
    else
        c1=c1+1;
    end
    %%%class2,3%%
    x=[Class_test_data2(k,1) Class_test_data2(k,2)]';
    g1=(x'*o12*x)+(w12*x)+w012;
    g2=(x'*o23*x)+(w23*x)+w023;
    g3=(x'*o31*x)+(w31*x)+w031;
    [gval,gindx]=max([g1;g2;g3]);
    if gval==g1
        a2=a2+1;
    elseif gval==g2
        b2=b2+1;
    else
        c2=c2+1;
    end
    %%%class3,1%%
    x=[Class_test_data3(k,1) Class_test_data3(k,2)]';
    g1=(x'*o12*x)+(w12*x)+w012;
    g2=(x'*o23*x)+(w23*x)+w023;
    g3=(x'*o31*x)+(w31*x)+w031;
    [gval,gindx]=max([g1;g2;g3]);
    if gval==g1
        a3=a3+1;
    elseif gval==g2
        b3=b3+1;
    else
        c3=c3+1;
    end
end
cm_sd1_c=zeros(3,3);
cm_sd1_c(1,1)=a1;cm_sd1_c(1,2)=a2;cm_sd1_c(1,3)=a3;
cm_sd1_c(2,1)=b1;cm_sd1_c(2,2)=b2;cm_sd1_c(2,3)=b3;
cm_sd1_c(3,1)=c1;cm_sd1_c(3,2)=c2;cm_sd1_c(3,3)=c3;
cm_sd1_c
%%%%end%%%%