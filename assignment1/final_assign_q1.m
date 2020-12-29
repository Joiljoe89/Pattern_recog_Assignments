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
        
        %patch([-10 -10 9.938], [9.0841 -15 -.976], [1 .8 0.8]);
        gx1=[7.87,8.59,30,30];
        gy1=[-20,-1.9,12.778,-20];
        c1=[1 .8 .8];
        gx2=[-10,-10,30,30,9.938,8.654];
        gy2=[9.0841,20,20,12.778,-.976,-.326];
        c2=[.8 1 .8];
        gx3=[-10,8.654,7.87,-10];
        gy3=[9.0841,-.326,-20,-20];
        c3=[.8 .8 1];
        
        fill(gx1,gy1,c1,gx2,gy2,c2,gx3,gy3,c3);
        
        %contour(X,Y,covariance1);
        hold on
        %plot(mean1(1),mean1(2),'r*');
        %plot(Class_train_data(:,1),Class_train_data(:,2),'g*');
        
                
        Class_test_data = M([0.75*size(M)+1:end],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\testing\Test_data_class1.txt','w');
        fprintf(fileID,'%f %f\n',Class_test_data);
        fclose(fileID);
        mean_test1=mean(Class_test_data,1)
        var_test1=var(Class_test_data)
        covariance_test1=cov(Class_test_data)
        plot(Class_test_data(:,1),Class_test_data(:,2),'r*');
        
    elseif n==2
        Class_train_data = M([1:0.75*size(M)],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\training\Train_data_class2.txt','w');
        fprintf(fileID,'%f %f\n',Class_train_data);
        fclose(fileID);
        mean2=mean(Class_train_data,1)
        var2=var(Class_train_data)
        covariance2=cov(Class_train_data)
        
        %plot(mean2(1),mean2(2),'r*');
        %plot(Class_train_data(:,1),Class_train_data(:,2),'c*');
        
        Class_test_data = M([0.75*size(M)+1:end],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\testing\Test_data_class2.txt','w');
        fprintf(fileID,'%f %f\n',Class_test_data);
        fclose(fileID);
        mean_test2=mean(Class_test_data,1)
        var_test2=var(Class_test_data)
        covariance_test2=cov(Class_test_data)
        plot(Class_test_data(:,1),Class_test_data(:,2),'g*');
        
    else
        Class_train_data = M([1:0.75*size(M)],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\training\Train_data_class3.txt','w');
        fprintf(fileID,'%f %f\n',Class_train_data);
        fclose(fileID);
        mean3=mean(Class_train_data)
        var3=var(Class_train_data)
        covariance3=cov(Class_train_data)
        
        %plot(mean3(1),mean3(2),'g*');
        %plot(Class_train_data(:,1),Class_train_data(:,2),'r*');
        m1=[mean1(1) mean2(1)];
        m2=[mean1(2) mean2(2)];
        %plot(m1,m2)
        
        x1=[m1;m2];
        x1=median(x1,2);
        x1=[x1]';
        %plot(x1(1),x1(2),'black*')
        
         s1 = (mean2(2) - mean1(2)) / (mean2(1)-mean1(1));
         PLm1 = -1/s1;
         PLc1 = x1(2) - PLm1*x1(1);
         x1=[-10:30];
         y1=PLm1*x1+(PLc1);
         %plot(x1,y1)
        
        m3=[mean2(1) mean3(1)];
        m4=[mean2(2) mean3(2)];
        %plot(m3,m4)
               
        x2=[m3;m4];
        x2=median(x2,2);
        x2=[x2]';
        %plot(x2(1),x2(2),'black*')
        
        s2=(m4(2)-m3(2))/(m4(1)-m3(1));
        PLm2=(1/s2);
        PLc2=x2(2)-PLm2*x2(1);
        y2=PLm2*x1+PLc2;
        %plot(x1,y2)
        
        
        m5=[mean3(1) mean1(1)];
        m6=[mean3(2) mean1(2)];
        %plot(m5,m6)
        
        x3=[m5;m6];
        x3=median(x3,2);
        x3=[x3]';
        %plot(x3(1),x3(2),'black*')
        
        x1 = [8:9];
        s3=(m6(2)-m6(1))/(m5(2)-m5(1));
        PLm3=-(1/s3)
        PLc3=x3(2)-PLm3*x3(1);
        y3=PLm3*x1+PLc3;
        %plot(x1,y3)
        
                
        Class_test_data = M([0.75*size(M)+1:end],:);
        fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\LS_Group2\testing\Test_data_class3.txt','w');
        fprintf(fileID,'%f %f\n',Class_test_data);
        fclose(fileID);
        mean_test3=mean(Class_test_data)
        var_test3=var(Class_test_data)
        covariance_test3=cov(Class_test_data)
        plot(Class_test_data(:,1),Class_test_data(:,2),'b*');
        
        hold off
        grid on
    end

	
end