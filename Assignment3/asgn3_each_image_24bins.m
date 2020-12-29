clc; close all; clear all;

fpath='D:\Seafile\Seafile\My Library\IIT Mandi\even_course_feb18\CS669_PR\assignment3\Scene image data 3 class\group2\train\volleyball_court_indoor\'; 
srcFiles = dir(strcat(fpath,'*.jpg'));  % the folder in which ur images exists
fprintf('Total image files in the folder:');disp(length(srcFiles))
%BC = [];
%path = 'D:\Seafile\Seafile\My Library\IIT Mandi\even_course_feb18\CS669_PR\assignment3\scene image\test\volley\';
for i =1:length(srcFiles)
    BC = [];
    filename = strcat(fpath,srcFiles(i).name);
    I = imread(filename);
    BC = color_hist_new(I);
    %f = BC;
    
    save(['D:\Seafile\Seafile\My Library\IIT Mandi\even_course_feb18\CS669_PR\assignment3\scene image\train\volley\train_volley' num2str(i)], 'BC');
end