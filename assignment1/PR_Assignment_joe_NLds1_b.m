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
%%Average of covariance matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
avg_cov=(covariance1+covariance2+covariance3)/3;
inv_avg_cov=inv(avg_cov);
%%%class1,2%%%%%%%%%%
figure(2);
hold on
%%%shade the area under decision boundary%%%%%%%%
C1_point=[]; C2_point=[]; C3_point=[];
w1=inv_avg_cov*(mean1-mean2)';
x01=(mean2+mean1)/2;
w2=inv_avg_cov*(mean2-mean3)';
x02=(mean3+mean2)/2;
w3=inv_avg_cov*(mean3-mean1)';
x03=(mean3+mean1)/2;
for l=(min_x1-5):.3:(max_x1+5)
    for m=(min_x2-5):.3:(max_x2+5)
        x=[l m]';
        C1=(w1'*x)-(w1'*x01');
        C2=(w2'*x)-(w2'*x02');
        C3=(w3'*x)-(w3'*x03');
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
plot(C1_x,C1_y,'.','color',[.8,.5,.5])
plot(C2_x,C2_y,'oc')
plot(C3_x,C3_y,'om')

axis([min_x1-5 max_x1+5 min_x2-5 max_x2+5]);
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
grid on
hold off
%%%confusion matrix variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a1=0;a2=0;a3=0;b1=0;b2=0;b3=0;c1=0;c2=0;c3=0;covb=eye(2,2);
dcov1=diag(covariance1);covb(1,1)=dcov1(1,1);covb(2,2)=dcov1(2,1);
w1=(mean1)*(inv(covb));
x01=(mean1)/2;
dcov2=diag(covariance2);covb(1,1)=dcov2(1,1);covb(2,2)=dcov2(2,1);
w2=(mean2)*(inv(covb));
x02=(mean2)/2;
dcov3=diag(covariance3);covb(1,1)=dcov3(1,1);covb(2,2)=dcov3(2,1);
w3=(mean3)*(inv(covb));
x03=(mean3)/2;
for k=(1:125)
    g12=(w1(1)*Class_test_data1(k,1))+(w1(2)*Class_test_data1(k,2))-(x01*w1');
    g23=(w2(1)*Class_test_data1(k,1))+(w2(2)*Class_test_data1(k,2))-(x02*w2');
    g31=(w3(1)*Class_test_data1(k,1))+(w3(2)*Class_test_data1(k,2))-(x03*w3');
    [gval,gindx]=max([g12;g23;g31]);
    if gval==g12
        a1=a1+1;
    elseif gval==g23
        b1=b1+1;
    else
        c1=c1+1;
    end
end
for k=(1:125)
    g12=(w1(1)*Class_test_data2(k,1))+(w1(2)*Class_test_data2(k,2))-(x01*w1');
    g23=(w2(1)*Class_test_data2(k,1))+(w2(2)*Class_test_data2(k,2))-(x02*w2');
    g31=(w3(1)*Class_test_data2(k,1))+(w3(2)*Class_test_data2(k,2))-(x03*w3');
    [gval,gindx]=max([g12;g23;g31]);
    if gval==g12
        a2=a2+1;
    elseif gval==g23
        b2=b2+1;
    else
        c2=c2+1;
    end
end
for k=(1:125)
    g12=(w1(1)*Class_test_data3(k,1))+(w1(2)*Class_test_data3(k,2))-(x01*w1');
    g23=(w2(1)*Class_test_data3(k,1))+(w2(2)*Class_test_data3(k,2))-(x02*w2');
    g31=(w3(1)*Class_test_data3(k,1))+(w3(2)*Class_test_data3(k,2))-(x03*w3');
    [gval,gindx]=max([g12;g23;g31]);
    if gval==g12
        a3=a3+1;
    elseif gval==g23
        b3=b3+1;
    else
        c3=c3+1;
    end
end
cm_sd1_b=zeros(3,3);
cm_sd1_b(1,1)=a1;cm_sd1_b(1,2)=a2;cm_sd1_b(1,3)=a3;
cm_sd1_b(2,1)=b1;cm_sd1_b(2,2)=b2;cm_sd1_b(2,3)=b3;
cm_sd1_b(3,1)=c1;cm_sd1_b(3,2)=c2;cm_sd1_b(3,3)=c3;
cm_sd1_b
%%%%end%%%%

