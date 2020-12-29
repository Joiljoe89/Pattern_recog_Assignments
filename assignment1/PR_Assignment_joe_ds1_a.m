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
        mean1=mean(Class_train_data1,1)
        var1=var(Class_train_data1)
        covariance1=cov(Class_train_data1)
                       
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
        mean2=mean(Class_train_data2,1)
        var2=var(Class_train_data2)
        covariance2=cov(Class_train_data2)
                       
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
        mean3=mean(Class_train_data3)
        var3=var(Class_train_data3)
        covariance3=cov(Class_train_data3)
               
        Class_test_data3 = M([0.75*size(M)+1:end],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\testing\Test_data_class3.txt','w');
        fprintf(fileID,'%f %f\n',Class_test_data3);
        fclose(fileID);        
    end
end
%%Bayes Classifier case-a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=size(M);
n_class=3;
n_train=size(Class_train_data3);

min_x1=min([Class_train_data1(:,1);Class_train_data2(:,1);Class_train_data3(:,1)]);
max_x1=max([Class_train_data1(:,1);Class_train_data2(:,1);Class_train_data3(:,1)]);
min_x2=min([Class_train_data1(:,2);Class_train_data2(:,2);Class_train_data3(:,2)]);
max_x2=max([Class_train_data1(:,2);Class_train_data2(:,2);Class_train_data3(:,2)]);

gx1=linspace(min_x1-5,max_x1+5,n(1));
%%Average of diagonal variance matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
avg_var=mean(diag((var1+var2+var3)/n_class));
%%%class1,2%%%%%%%%%%
figure(1);
hold on
%%%decision boundary class1,2%%%
w12=(mean1-mean2)./avg_var;
x012=(mean2+mean1)/2;
x0=repmat(x012,n(1),1);
g12_x2=(-w12(1)/w12(2)).*(gx1-x0(:,1)')+x0(:,2)';
plot(gx1,g12_x2,'-r','linewidth',1);
%%%class2,3%%%
w23=(mean2-mean3)./avg_var;
x023=(mean3+mean2)/2;
x0=repmat(x023,n(1),1);
g12_x2=(-w23(1)/w23(2)).*(gx1-x0(:,1)')+x0(:,2)';
plot(gx1,g12_x2,'-g','linewidth',1);
%%%class3,1%%%
w31=(mean3-mean1)./avg_var;
x031=(mean3+mean1)/2;
x0=repmat(x031,n(1),1);
g12_x2=(-w31(1)/w31(2)).*(gx1-x0(:,1)')+x0(:,2)';
plot(gx1,g12_x2,'-b','linewidth',1);

axis([min_x1-5 max_x1+5 min_x2-5 max_x2+5]);
%%%shade the area under decision boundary%%%%%%%%
fill([7.765,8.6568,33.65,33.65],[-19.32,-1.1735,12.975,-19.32],...
    [1,.8,.8],[-14.06,33.65,33.65,8.6568,-14.06],...
    [21.95,21.95,12.975,-1.1735,13.7],[.8,1,.8],...
    [-14.06,8.6568,7.765,-14.06],[13.7,-1.1735,-19.32,-19.32],[.8,.8,1]);
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
%%%confusion matrix variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a1=0;a2=0;a3=0;b1=0;b2=0;b3=0;c1=0;c2=0;c3=0;
w1=(mean1)./avg_var;
x01=(mean1)/2;
w2=(mean2)./avg_var;
x02=(mean2)/2;
w3=(mean3)./avg_var;
x03=(mean3)/2;
for k=(1:125)
    g1=(w1(1)*Class_test_data1(k,1))+(w1(2)*Class_test_data1(k,2))-(w1*x01');
    g2=(w2(1)*Class_test_data1(k,1))+(w2(2)*Class_test_data1(k,2))-(w2*x02');
    g3=(w3(1)*Class_test_data1(k,1))+(w3(2)*Class_test_data1(k,2))-(w3*x03');
    [gval,gindx]=max([g1;g2;g3]);
    if gval==g1
        a1=a1+1;
    elseif gval==g2
        b1=b1+1;
    else
        c1=c1+1;
    end
end
for k=(1:125)
    g1=(w1(1)*Class_test_data2(k,1))+(w1(2)*Class_test_data2(k,2))-(w1*x01');
    g2=(w2(1)*Class_test_data2(k,1))+(w2(2)*Class_test_data2(k,2))-(w2*x02');
    g3=(w3(1)*Class_test_data2(k,1))+(w3(2)*Class_test_data2(k,2))-(w3*x03');
    [gval,gindx]=max([g1;g2;g3]);
    if gval==g1
        a2=a2+1;
    elseif gval==g2
        b2=b2+1;
    else
        c2=c2+1;
    end
end
for k=(1:125)
    g1=(w1(1)*Class_test_data3(k,1))+(w1(2)*Class_test_data3(k,2))-(w1*x01');
    g2=(w2(1)*Class_test_data3(k,1))+(w2(2)*Class_test_data3(k,2))-(w2*x02');
    g3=(w3(1)*Class_test_data3(k,1))+(w3(2)*Class_test_data3(k,2))-(w3*x03');
    [gval,gindx]=max([g1;g2;g3]);
    if gval==g1
        a3=a3+1;
    elseif gval==g2
        b3=b3+1;
    else
        c3=c3+1;
    end
end
cm_sd1_a=zeros(3,3);
cm_sd1_a(1,1)=a1;cm_sd1_a(1,2)=a2;cm_sd1_a(1,3)=a3;
cm_sd1_a(2,1)=b1;cm_sd1_a(2,2)=b2;cm_sd1_a(2,3)=b3;
cm_sd1_a(3,1)=c1;cm_sd1_a(3,2)=c2;cm_sd1_a(3,3)=c3;
cm_sd1_a
%%%%end%%%%

