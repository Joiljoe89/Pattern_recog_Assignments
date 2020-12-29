clc
clear all

I=imread('/home/sukesh/IIT_Mandi/pr/2018/Assignment2_codeNdata/group2/train/coast/sun_aacnxjqfcwffnkqp.jpg');

[r1,c1,ch1]=size(I);
Ir=I(:,:,1);
Ig=I(:,:,2);
Ib=I(:,:,3);
                
br=linspace(0,255,8);
m1=32;m2=32;
n1=ceil(r1/m1); n2=ceil(c1/m2);

Irr=imresize(Ir,[m1*n1 m2*n2]);
Igr=imresize(Ig,[m1*n1 m2*n2]);
Ibr=imresize(Ib,[m1*n1 m2*n2]);
                
BC=[];

                
                for j=1:1:n1
                    for j1=1:1:n2
                        
                        Ir1=Irr((j-1)*m1+1:(j-1)*m1+m1,(j1-1)*m2+1:(j1-1)*m2+m2);
                        Ig1=Igr((j-1)*m1+1:(j-1)*m1+m1,(j1-1)*m2+1:(j1-1)*m2+m2);
                        Ib1=Ibr((j-1)*m1+1:(j-1)*m1+m1,(j1-1)*m2+1:(j1-1)*m2+m2);
        
                        [bc_r]=histc(Ir1(:),br);
                        [bc_g]=histc(Ig1(:),br);
                        [bc_b]=histc(Ib1(:),br);
        
                        bc=[bc_r' bc_g' bc_b'];
                        BC=[BC;bc];
                       
                        
                        
                    end
                end