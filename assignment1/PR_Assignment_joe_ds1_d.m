%%%PR Assignment1%%%%%%Joe_D17024%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
%%Fetching 2D Dataset
folder = ('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2');
filePattern = fullfile(folder, '*class*');
G = dir(filePattern);
numberOfFiles = length(G);
for n = 1 : numberOfFiles
	baseFileName = G(n).name;
	fullFileName = fullfile(folder, baseFileName);
    M = dlmread(fullFileName);
    %%Fetching DS1,Class1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if  n==1
        Class_train_data1 = M([1:0.75*size(M)],:);%training data
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\training\Train_data_class1.txt','w');
        fprintf(fileID,'%f %f\n',Class_train_data1);
        fclose(fileID);
        mean1=mean(Class_train_data1,1);
        var1=var(Class_train_data1);
        covariance1=cov(Class_train_data1);
                       
        Class_test_data1 = M([0.75*size(M)+1:end],:);%test data
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\testing\Test_data_class1.txt','w');
        fprintf(fileID,'%f %f\n',Class_test_data1);
        fclose(fileID);       
    %%Fetching DS1,Class2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif n==2
        Class_train_data2 = M([1:0.75*size(M)],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\training\Train_data_class2.txt','w');
        fprintf(fileID,'%f %f\n',Class_train_data2);
        fclose(fileID);
        mean2=mean(Class_train_data2,1);
        var2=var(Class_train_data2);
        covariance2=cov(Class_train_data2);
                       
        Class_test_data2 = M([0.75*size(M)+1:end],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\testing\Test_data_class2.txt','w');
        fprintf(fileID,'%f %f\n',Class_test_data2);
        fclose(fileID);
    %%Fetching DS1,Class3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    else
        Class_train_data3 = M([1:0.75*size(M)],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\training\Train_data_class3.txt','w');
        fprintf(fileID,'%f %f\n',Class_train_data3);
        fclose(fileID);
        mean3=mean(Class_train_data3);
        var3=var(Class_train_data3);
        covariance3=cov(Class_train_data3);
               
        Class_test_data3 = M([0.75*size(M)+1:end],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\testing\Test_data_class3.txt','w');
        fprintf(fileID,'%f %f\n',Class_test_data3);
        fclose(fileID);        
    end
end
%%Bayes Classifier case-b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=size(M);
n_class=3;
n_train=size(Class_train_data3);

min_x1=min([Class_train_data1(:,1);Class_train_data2(:,1);Class_train_data3(:,1)]);
max_x1=max([Class_train_data1(:,1);Class_train_data2(:,1);Class_train_data3(:,1)]);
min_x2=min([Class_train_data1(:,2);Class_train_data2(:,2);Class_train_data3(:,2)]);
max_x2=max([Class_train_data1(:,2);Class_train_data2(:,2);Class_train_data3(:,2)]);

gx1=linspace(min_x1-5,max_x1+5,375);
%%inverse of different covariance matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%covariance12=[1 0;0 -10];
inv_cov1=inv(covariance1);
inv_cov2=inv(covariance2);
inv_cov3=inv(covariance3);
figure(4);
hold on
%%%class3,1%%%%%%%%%%
        o31=-(inv_cov3-inv_cov1).*(.5);
        w31=((mean3*inv_cov3)-(mean1*inv_cov1));
        w031=(-.5.*(((mean3*inv_cov3)*mean3')-((mean1*inv_cov1)*mean1')))...
            -(.5*log(det(covariance3)/det(covariance1)));
        o11_12=(o31(1,1)+o31(1,2));
        o21_22=(o31(2,1)+o31(2,2));
        for t=(1:1:375)
            g31_x2(t)=-(((gx1(t)^2).*o11_12)+(w31(1)*gx1(t))+w031)...
                /((gx1(t)*o21_22)+w31(2));
        end
        plot(gx1,g31_x2,'-','color',[0 0 1],'linewidth',1);
%%%class1,2%%%%%%%%%%
        o12=-(inv_cov1-inv_cov2).*(.5);
        w12=((mean1*inv_cov1)-(mean2*inv_cov2));
        w012=(-.5.*(((mean1*inv_cov1)*mean1')-((mean2*inv_cov2)*mean2')))...
            -(.5*log(det(covariance1)/det(covariance2)));
        o11_12=(o12(1,1)+o12(1,2));
        o21_22=(o12(2,1)+o12(2,2));
        for t=(1:1:375)
            g12_x2(t)=-(((gx1(t)^2).*o11_12)+(w12(1)*gx1(t))+w012)...
                /((gx1(t)*o21_22)+w12(2));
        end
        plot(gx1,g12_x2,'-','color',[1 0 0],'linewidth',1);
%%%class2,3%%%%%%%%%%       
        o23=-(inv_cov2-inv_cov3).*(.5);
        w23=((mean2*inv_cov2)-(mean3*inv_cov3));
        w023=(-.5.*((mean2*inv_cov2*mean2')-(mean3*inv_cov3*mean3')))...
            -(.5*log(det(covariance2)/det(covariance3)));
        o11_12=(o23(1,1)+o23(1,2));
        o21_22=(o23(2,1)+o23(2,2));
        for t=(1:1:375)
            g23_x2(t)=-(((gx1(t)^2).*o11_12)+(w23(1)*gx1(t))+w023)...
                /((gx1(t)*o21_22)+w23(2));
        end
        plot(gx1,g23_x2,'-','color',[0 1 0],'linewidth',1);
   
axis([min_x1-5 max_x1+5 min_x2-5 max_x2+5]);
%%%shade the area under decision boundary%%%%%%%%
C1_point=[]; C2_point=[]; C3_point=[];
o31=-(inv_cov3).*(.5);
w31=(mean3*inv_cov3);
w031=(-.5.*(((mean3*inv_cov3)*mean3'))-(.5*log(det(covariance3))));
o12=-(inv_cov1).*(.5);
w12=(mean1*inv_cov1);
w012=(-.5.*(((mean1*inv_cov1)*mean1'))-(.5*log(det(covariance1))));
o23=-(inv_cov2).*(.5);
w23=(mean2*inv_cov2);
w023=(-.5.*((mean2*inv_cov2)*mean2')-(.5*log(det(covariance2))));
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
plot(C1_x,C1_y,'.','color',[.8,.5,.5])
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
cm_sd1_d=zeros(3,3);
cm_sd1_d(1,1)=a1;cm_sd1_d(1,2)=a2;cm_sd1_d(1,3)=a3;
cm_sd1_d(2,1)=b1;cm_sd1_d(2,2)=b2;cm_sd1_d(2,3)=b3;
cm_sd1_d(3,1)=c1;cm_sd1_d(3,2)=c2;cm_sd1_d(3,3)=c3;
cm_sd1_d
%%%%end%%%%

