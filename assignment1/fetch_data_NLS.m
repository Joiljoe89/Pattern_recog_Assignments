clc
close all
clear all
%%Fetching first 500x2 2D NL Dataset
fpath = 'D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\';
data1 = load(strcat(fpath,'non-linear_data2.txt'),'-ascii');
Class_data1=data1(1:500,:);
fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\NLS_Group2\class1.txt','w');
fprintf(fileID,'%f %f\n',Class_data1);
fclose(fileID);
%%Fetching second 500x2 2D NL Dataset
data2 = load(strcat(fpath,'non-linear_data2.txt'),'-ascii');
Class_data2=data2(501:1000,:);
fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\NLS_Group2\class2.txt','w');
fprintf(fileID,'%f %f\n',Class_data2);
fclose(fileID);
%%Fetching third 500x2 2D NL Dataset
data3 = load(strcat(fpath,'non-linear_data2.txt'),'-ascii');
Class_data3=data3(1001:1500,:);
fileID = fopen('D:\IIT Mandi\even_course_feb18\CS669_PR\Assignment1\NLS_Group2\class3.txt','w');
fprintf(fileID,'%f %f\n',Class_data3);
fclose(fileID);