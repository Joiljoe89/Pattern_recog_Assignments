%This program is to extract features from data set 2(c)

clc
clear all
close all

dirp=pwd;
p1=strcat(dirp,'/group02');

f1=dir(p1);
fn1=char(f1.name);
fn1=fn1(3:end,:);

 for i=1:1:length(fn1(:,1))
        p2=strcat(p1,'/',fn1(i,:));
        f2=dir([p2 '/*.png']);
        fn2=char(f2.name);
        MVF=[];         
        for i1=1:1:length(fn2(:,1))
                p3=strcat(p2,'/',fn2(i1,:))
                I=imread(p3);
                fe=cellDataFe(I);
% %                 I=double(I);
% %                 
% %                 [r1,c1]=size(I);
% %                 m1=7;m2=7;
% %                 n1=ceil(r1/m1); n2=ceil(c1/m2); 
% %                 r=m1*n1;c=m2*n2;
% %                 Ir=imresize(I,[r c]);
% %                 
% %                 fe=[];
% %                 for k=1:1:r-m1
% %                     for l=1:1:c-m2
% %                         I1=Ir(k:k+m1-1,l:l+m2-1);
% %                        
% %                         mu=sum(I1(:))/length(I1(:));
% %                         var=sum((I1(:)-(repmat(mu,length(I1(:)),1))).^2)/(length(I1(:))-1);
% %                         fe=[fe;mu var];
% %                         
% %                     end
% %                 end
                
                 save([p3(1:end-4) '_MVF'],'fe'); 
                MVF=[MVF;fe];
         end
            
     save([p2 '/' fn1(i,:) '_MVF'],'MVF'); 
        
 end