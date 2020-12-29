% Program to creat 24 bin vector for each class of images.
clc; close all; clear all;


fpath='D:\Seafile\Seafile\My Library\IIT Mandi\even_course_feb18\CS669_PR\assignment3\Scene image data 3 class\group2\test\volleyball_court_indoor\'; 
%pagoda\;  %coast\ 
srcFiles = dir(strcat(fpath,'*.jpg'));  % the folder in which ur images exists
fprintf('Total image files in the folder:');disp(length(srcFiles))
RGB_24bins=[];

for i =1:length(srcFiles)
    filename = strcat(fpath,srcFiles(i).name);
    I = imread(filename);
    %I=imresize(I,[256,256]);
    if size(I,3)==3
    RGB_24bins=color_hist_new(RGB_24bins,I);
    else
        disp(['Please note!!! Image no:',num2str(i),' ignored since it is not a color image'])
        figure
        imshow(I)
        disp(srcFiles(i).name)
    end
    
end

% saving_path='C:\Users\Mahe\Desktop\Pattern Recognition Assignment1\Assignment2\Data2b\group1\train\'
% disp('RGB_24bins Data not saved ')
save('test_volleyball_court_indoor_data')
