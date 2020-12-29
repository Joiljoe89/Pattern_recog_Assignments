%%%% Working for All data
clc
close all
clear all
% Reading data from the folder
%fpath = 'C:\Users\Mahe\Desktop\Pattern Recognition Assignment1\LS_Group1\'; 
fpath = 'C:\Users\Mahe\Desktop\Pattern Recognition Assignment1\Data\LS_Group1\'; 
% fpath = 'C:\Users\Mahe\Desktop\Pattern Recognition Assignment1\Data1 LS\New folder\LS_Group1_Sukesh\';
fileID = fopen(strcat(fpath,'Class1Train_data_file.txt'),'r');
formatSpec = '%f %f';
Class1_train_data_size = [375,2];
Class1_train_data = fscanf(fileID,formatSpec,Class1_train_data_size);
X1=Class1_train_data(:,1);
Y1=Class1_train_data(:,2);


fileID = fopen(strcat(fpath,'Class2Train_data_file.txt'),'r');
formatSpec = '%f %f';
Class2_train_data_size = [375,2];
Class2_train_data = fscanf(fileID,formatSpec,Class2_train_data_size);
X2=Class2_train_data(:,1);
Y2=Class2_train_data(:,2);

fileID = fopen(strcat(fpath,'Class3Train_data_file.txt'),'r');
formatSpec = '%f %f';
Class1_train_data_size = [375,2];
Class3_train_data = fscanf(fileID,formatSpec,Class1_train_data_size);
X3=Class3_train_data(:,1);
Y3=Class3_train_data(:,2);

%%% To find Min and Max of X and Y axis in the plot 
 x1=min([min(Class1_train_data(:,1)),min(Class2_train_data(:,1)),min(Class3_train_data(:,1))]); 
 x2=max([max(Class1_train_data(:,1)),max(Class2_train_data(:,1)),max(Class3_train_data(:,1))]);   
 Xmin=x1-5; Xmax=x2+5;
 y1=min([min(Class1_train_data(:,2)),min(Class2_train_data(:,2)),min(Class3_train_data(:,2))]); 
 y2=max([max(Class1_train_data(:,2)),max(Class2_train_data(:,2)),max(Class3_train_data(:,2))]);
 Ymin=y1-5; Ymax=y2+5;
 Xmin=min(Xmin,Ymin); Ymin=min(Xmin,Ymin);
 Xmax=max(Xmax,Ymax), Ymax=max(Xmax,Ymax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Finding Mean and Variance
u1=mean(Class1_train_data);
u2=mean(Class2_train_data);
u3=mean(Class3_train_data);
plot(u1(1),u1(2),'ob')   %% Plotting mean point on the graph
hold on
plot(u2(1),u2(2),'or')
plot(u3(1),u3(2),'og')
var1=var(Class1_train_data);var2=var(Class2_train_data);var3=var(Class3_train_data);
Avar=(var1+var2+var3)/3;
Avg_var=mean([Avar(1),Avar(2)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plotting line
%%%% Line between Class1 and Class2
Line1_m=(u2(2)-u1(2))/(u2(1)-u1(1));  
Line1_C=u1(2)-Line1_m*u1(1);
Line1_x=[u1(1),u2(1)];
Line1_y=Line1_m*Line1_x+Line1_C; % Line between mid points of Class1 and Class2
plot(Line1_x,Line1_y)
Line1_midpoint=[(u1(1)+u2(1))/2, (u1(2)+u2(2))/2];
Line1_m2=-1/Line1_m;
Line1_C2=Line1_midpoint(2)-Line1_m2*Line1_midpoint(1);
PerendicularLine1_x=[Xmin:Xmax];
PerpendicularLine1_y=Line1_m2*PerendicularLine1_x+Line1_C2;
plot(PerendicularLine1_x,PerpendicularLine1_y)
hold on
axis equal
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Line between Class2 and Class3
Line2_m=(u3(2)-u2(2))/(u3(1)-u2(1));  
Line2_C=u2(2)-Line2_m*u2(1);
Line2_x=[u2(1),u3(1)];
Line2_y=Line2_m*Line2_x+Line2_C; % Line between mid points of Class1 and Class2
plot(Line2_x,Line2_y)
Line2_midpoint=[(u2(1)+u3(1))/2, (u2(2)+u3(2))/2];
Line2_m2=-1/Line2_m;
Line2_C2=Line2_midpoint(2)-Line2_m2*Line2_midpoint(1);
PerendicularLine2_x=[Xmin:Xmax];
PerpendicularLine2_y=Line2_m2*PerendicularLine2_x+Line2_C2;
plot(PerendicularLine2_x,PerpendicularLine2_y)
hold on
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Line3_m=(u1(2)-u3(2))/(u1(1)-u3(1));  
Line3_C=u3(2)-Line3_m*u3(1);
Line3_x=[u3(1),u1(1)];
Line3_y=Line3_m*Line3_x+Line3_C; % Line between mid points of Class1 and Class2
plot(Line3_x,Line3_y)
Line3_midpoint=[(u3(1)+u1(1))/2, (u3(2)+u1(2))/2];
Line3_m2=-1/Line3_m;
Line3_C2=Line3_midpoint(2)-Line3_m2*Line3_midpoint(1);
PerendicularLine3_x=[Xmin:Xmax];
PerpendicularLine3_y=Line3_m2*PerendicularLine3_x+Line3_C2;
plot(PerendicularLine3_x,PerpendicularLine3_y)
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% This calculates absolute g1(x), g2(x),g3(x) for all points in 2D space
%%% Used for region separation by assigning all points in the space to one
%%% of the 3 classes. Used instead of fill/patch

W1=1/Avg_var*u1;
W10=(-1/(2*Avg_var)*(u1*u1'))+log(1/3);
W2=1/Avg_var*u2;
W20=(-1/(2*Avg_var)*(u2*u2'))+log(1/3);
W3=1/Avg_var*u3;
W30=(-1/(2*Avg_var)*(u3*u3'))+log(1/3);

 Class1_Point=[]; Class2_Point=[]; Class3_Point=[];
 
 for i=Xmin:0.5:Xmax
     for j=Ymin:0.5:Ymax
         x=[i,j]';
         G1=W1*x+W10;
         G2=W2*x+W20;
         G3=W3*x+W30;

        [Gval, Gindx]=max([G1,G2,G3]);
        if Gindx==1
            Class1_Point=[Class1_Point,x];
        elseif Gindx==2
            Class2_Point=[Class2_Point,x];
        else
            Class3_Point=[Class3_Point,x];
        end
        
    end
    
end

Class1_X=Class1_Point(1,:);Class1_Y=Class1_Point(2,:);
Class2_X=Class2_Point(1,:);Class2_Y=Class2_Point(2,:);
Class3_X=Class3_Point(1,:);Class3_Y=Class3_Point(2,:);

%save(strcat(fpath,'Class_data'),'Class1_Point','Class2_Point','Class3_Point','Xmin','Xmax','Ymin','Ymax') 
save(strcat(fpath,'Class_data'))
plot(Class1_X,Class1_Y,'oy')
xlim([Xmin,Xmax]);
ylim([Ymin,Ymax]);
plot(Class2_X,Class2_Y,'oc')
plot(Class3_X,Class3_Y,'om')
%%%% Now plotting oroginal training data points for better view
plot(X1,Y1,'*r')
plot(X2,Y2,'*G')
plot(X3,Y3,'*b')
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



