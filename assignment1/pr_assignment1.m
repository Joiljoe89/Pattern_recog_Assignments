clear all;
close all;
folder = ('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2');
filePattern = fullfile(folder, '*class*');
G = dir(filePattern);
numberOfFiles = length(G);
for n = 1 : numberOfFiles
	baseFileName = G(n).name;
	fullFileName = fullfile(folder, baseFileName);
    M = dlmread(fullFileName);
    if  n==1
        Class_train_data = M([1:0.75*size(M)],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\training\Train_data_class1.txt','w');
        fprintf(fileID,'%f %f\n',Class_train_data);
        fclose(fileID);
        mean1=mean(Class_train_data,1)
        var1=var(Class_train_data)
        covariance1=cov(Class_train_data)
        [X,Y]=meshgrid(mean1(1):(mean1(1)+1),mean1(2):mean1(2)+1)
        figure(1)
        %contour(X,Y,covariance1);
        hold on
        plot(mean1(1),mean1(2),'r*');
        plot(Class_train_data(:,1),Class_train_data(:,2),'g*');
        %hold off
        
        Class_test_data = M([0.75*size(M)+1:end],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\testing\Test_data_class1.txt','w');
        fprintf(fileID,'%f %f\n',Class_test_data);
        fclose(fileID);
        mean_test1=mean(Class_test_data,1)
        var_test1=var(Class_test_data)
        covariance_test1=cov(Class_test_data)
        
    elseif n==2
        Class_train_data = M([1:0.75*size(M)],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\training\Train_data_class2.txt','w');
        fprintf(fileID,'%f %f\n',Class_train_data);
        fclose(fileID);
        mean2=mean(Class_train_data,1)
        var2=var(Class_train_data)
        covariance2=cov(Class_train_data)
        
        plot(mean2(1),mean2(2),'r*');
        plot(Class_train_data(:,1),Class_train_data(:,2),'c*');
        
        Class_test_data = M([0.75*size(M)+1:end],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\testing\Test_data_class2.txt','w');
        fprintf(fileID,'%f %f\n',Class_test_data);
        fclose(fileID);
        mean_test2=mean(Class_test_data,1)
        var_test2=var(Class_test_data)
        covariance_test2=cov(Class_test_data)
        
    else
        Class_train_data = M([1:0.75*size(M)],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\training\Train_data_class3.txt','w');
        fprintf(fileID,'%f %f\n',Class_train_data);
        fclose(fileID);
        mean3=mean(Class_train_data)
        var3=var(Class_train_data)
        covariance3=cov(Class_train_data)
        
        plot(mean3(1),mean3(2),'g*');
        plot(Class_train_data(:,1),Class_train_data(:,2),'r*');
        
        m1=[mean1(1) mean2(1)];
        m2=[mean1(2) mean2(2)];
        plot(m1,m2)
        
        x1=[m1;m2];
        x1=median(x1,2)
        x1=[x1]'
        plot(x1(1),x1(2),'black*')
        
        m3=[mean2(1) mean3(1)];
        m4=[mean2(2) mean3(2)];
        plot(m3,m4)
        
        x2=[m3;m4];
        x2=median(x2,2)
        x2=[x2]'
        plot(x2(1),x2(2),'black*')
        
        m5=[mean3(1) mean1(1)];
        m6=[mean3(2) mean1(2)];
        plot(m5,m6)
        
        x3=[m5;m6];
        x3=median(x3,2)
        x3=[x3]'
        plot(x3(1),x3(2),'black*')
        
        hold off
        
        Class_test_data = M([0.75*size(M)+1:end],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\testing\Test_data_class3.txt','w');
        fprintf(fileID,'%f %f\n',Class_test_data);
        fclose(fileID);
        mean_test3=mean(Class_test_data)
        var_test3=var(Class_test_data)
        covariance_test3=cov(Class_test_data)
    end

	
end