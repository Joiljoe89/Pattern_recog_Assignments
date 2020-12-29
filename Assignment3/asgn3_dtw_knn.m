clc; close all; clear all;

w = 4;
%training mat path
fpath1= 'D:\Seafile\Seafile\My Library\IIT Mandi\even_course_feb18\CS669_PR\assignment3\scene image\train\coast\';
fpath2= 'D:\Seafile\Seafile\My Library\IIT Mandi\even_course_feb18\CS669_PR\assignment3\scene image\train\kennel\';
fpath3= 'D:\Seafile\Seafile\My Library\IIT Mandi\even_course_feb18\CS669_PR\assignment3\scene image\train\volley\';
%testing mat path
fpath4= 'D:\Seafile\Seafile\My Library\IIT Mandi\even_course_feb18\CS669_PR\assignment3\scene image\test\coast\';
fpath5= 'D:\Seafile\Seafile\My Library\IIT Mandi\even_course_feb18\CS669_PR\assignment3\scene image\test\kennel\';
fpath6= 'D:\Seafile\Seafile\My Library\IIT Mandi\even_course_feb18\CS669_PR\assignment3\scene image\test\volley\';

srcFiles1 = dir(strcat(fpath1,'*.mat'));  % the folder in which ur mat file exists
srcFiles2 = dir(strcat(fpath2,'*.mat'));  % the folder in which ur mat file exists
srcFiles3 = dir(strcat(fpath3,'*.mat'));  % the folder in which ur mat file exists
srcFiles4 = dir(strcat(fpath4,'*.mat'));  % the folder in which ur mat file exists
srcFiles5 = dir(strcat(fpath5,'*.mat'));  % the folder in which ur mat file exists
srcFiles6 = dir(strcat(fpath6,'*.mat'));  % the folder in which ur mat file exists
%fprintf('Total mat files in the folder:');disp(length(srcFiles))


%%%DTW btw coastal and all training set
for a = 1:length(srcFiles4)%testing
    for b = 1:length(srcFiles3)%training
        for c = 1:length(srcFiles2)%training
            for d = 1:length(srcFiles1)%training
                x3 = strcat(fpath1,srcFiles1(d).name);
                y = strcat(fpath4,srcFiles4(a).name);
                x3 = load(x3);
                x3 = x3.BC;
                y = load(y);
                y = y.BC;
                d1_1(a,d)=dtw_new(x3,y,w);
            end
            x2 = strcat(fpath2,srcFiles2(c).name);
            x2 = load(x2);
            x2 = x2.BC;
            d1_2(a,c)=dtw_new(x2,y,w);
        end
        x1 = strcat(fpath1,srcFiles1(b).name);
        x1 = load(x1);
        x1 = x1.BC;
        d1_3(a,b)=dtw_new(x1,y,w);
    end
end
d1 = [d1_1,d1_2,d1_3];

%%%
[sort_coast,index] = sort(d1, 2, 'descend');
index1 = index;
%Labling class to sorted index%%
for v = 1:50
    for h = 1:150
        if index1(v,h)<51
            index1(v,h) = 1;
        elseif index1(v,h)>50&&index1(v,h)<101
            index1(v,h) = 2;
        else
            index1(v,h) = 3;
        end
        h=h+1;
    end
    v=v+1;
end
%%%DTW btw kennel and all training set
for a = 1:length(srcFiles5)%testing
    for b = 1:length(srcFiles3)%training
        for c = 1:length(srcFiles2)%training
            for d = 1:length(srcFiles1)%training
                x3 = strcat(fpath1,srcFiles1(d).name);
                y = strcat(fpath5,srcFiles5(a).name);
                x3 = load(x3);
                x3 = x3.BC;
                y = load(y);
                y = y.BC;
                d2_1(a,d)=dtw_new(x3,y,w);
            end
            x2 = strcat(fpath2,srcFiles2(c).name);
            x2 = load(x2);
            x2 = x2.BC;
            d2_2(a,c)=dtw_new(x2,y,w);
        end
        x1 = strcat(fpath1,srcFiles1(b).name);
        x1 = load(x1);
        x1 = x1.BC;
        d2_3(a,b)=dtw_new(x1,y,w);
    end
end
d2 = [d2_1,d2_2,d2_3];

%%%
[sort_kennel,index] = sort(d2, 2, 'descend');

index2 = index;
%Labling class to sorted index%%
for v = 1:50
    for h = 1:150
        if index2(v,h)<51
            index2(v,h) = 1;
        elseif index2(v,h)>50&&index2(v,h)<101
            index2(v,h) = 2;
        else
            index2(v,h) = 3;
        end
        h=h+1;
    end
    v=v+1;
end
%%%DTW btw volleyball and all training set
for a = 1:length(srcFiles6)%testing
    for b = 1:length(srcFiles3)%training
        for c = 1:length(srcFiles2)%training
            for d = 1:length(srcFiles1)%training
                x3 = strcat(fpath1,srcFiles1(d).name);
                y = strcat(fpath6,srcFiles6(a).name);
                x3 = load(x3);
                x3 = x3.BC;
                y = load(y);
                y = y.BC;
                d3_1(a,d)=dtw_new(x3,y,w);
            end
            x2 = strcat(fpath2,srcFiles2(c).name);
            x2 = load(x2);
            x2 = x2.BC;
            d3_2(a,c)=dtw_new(x2,y,w);
        end
        x1 = strcat(fpath1,srcFiles1(b).name);
        x1 = load(x1);
        x1 = x1.BC;
        d3_3(a,b)=dtw_new(x1,y,w);
    end
end
d3 = [d3_1,d3_2,d3_3];

%%%
[sort_volley,index] = sort(d4, 2, 'descend');

index3 = index;
%Labling class to sorted index%%
for v = 1:50
    for h = 1:150
        if index3(v,h)<51
            index3(v,h) = 1;
        elseif index3(v,h)>50&&index3(v,h)<101
            index3(v,h) = 2;
        else
            index3(v,h) = 3;
        end
        h=h+1;
    end
    v=v+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%required k=1,3,5,9,13
% k=1

for r = 1:50
    ind1 = index1(r,1);
    t=1;
    if ind1 == 1
        cm_k1(1,1) = cm_k1(1,1)+t;
    elseif ind1 == 2
        cm_k1(1,2) = cm_k1(1,2)+t;
    else
        cm_k1(1,3) = cm_k1(1,3)+t;
    end
    r=r+1;
end

for r = 1:50
    ind1 = index2(r,1);
    t=1;
    if ind1 == 1
        cm_k1(2,1) = cm_k1(2,1)+t;
    elseif ind1 == 2
        cm_k1(2,2) = cm_k1(2,2)+t;
    else
        cm_k1(2,3) = cm_k1(2,3)+t;
    end
    r=r+1;
end

for r = 1:50
    ind1 = index3(r,1);
    t=1;
    if ind1 == 1
        cm_k1(3,1) = cm_k1(3,1)+t;
    elseif ind1 == 2
        cm_k1(3,2) = cm_k1(3,2)+t;
    else
        cm_k1(3,3) = cm_k1(3,3)+t;
    end
    r=r+1;
end
% k=3
for r = 1:50
    ind3 = index1(r,1:3);
    ind1 = mode(ind3,2);
    t=1;
    if ind1 == 1
        cm_k3(1,1) = cm_k3(1,1)+t;
    elseif ind1 == 2
        cm_k3(1,2) = cm_k3(1,2)+t;
    else
        cm_k3(1,3) = cm_k3(1,3)+t;
    end
    r=r+1;
end

for r = 1:50
    ind3 = index2(r,1:3);
    ind1 = mode(ind3,2);
    t=1;
    if ind1 == 1
        cm_k3(2,1) = cm_k3(2,1)+t;
    elseif ind1 == 2
        cm_k3(2,2) = cm_k3(2,2)+t;
    else
        cm_k3(2,3) = cm_k3(2,3)+t;
    end
    r=r+1;
end

for r = 1:50
    ind3 = index3(r,1:3);
    ind1 = mode(ind3,2);
    t=1;
    if ind1 == 1
        cm_k3(3,1) = cm_k3(3,1)+t;
    elseif ind1 == 2
        cm_k3(3,2) = cm_k3(3,2)+t;
    else
        cm_k3(3,3) = cm_k3(3,3)+t;
    end
    r=r+1;
end

%k=5
for r = 1:50
    ind5 = index1(r,1:5);
    ind1 = mode(ind5,2);
    t=1;
    if ind1 == 1
        cm_k5(1,1) = cm_k5(1,1)+t;
    elseif ind1 == 2
        cm_k5(1,2) = cm_k5(1,2)+t;
    else
        cm_k5(1,3) = cm_k5(1,3)+t;
    end
    r=r+1;
end

for r = 1:50
    ind5 = index2(r,1:5);
    ind1 = mode(ind5,2);
    t=1;
    if ind1 == 1
        cm_k5(2,1) = cm_k5(2,1)+t;
    elseif ind1 == 2
        cm_k5(2,2) = cm_k5(2,2)+t;
    else
        cm_k5(2,3) = cm_k5(2,3)+t;
    end
    r=r+1;
end

for r = 1:50
    ind5 = index3(r,1:5);
    ind1 = mode(ind5,2);
    t=1;
    if ind1 == 1
        cm_k5(3,1) = cm_k5(3,1)+t;
    elseif ind1 == 2
        cm_k5(3,2) = cm_k5(3,2)+t;
    else
        cm_k5(3,3) = cm_k5(3,3)+t;
    end
    r=r+1;
end

%k=9
for r = 1:50
    ind9 = index1(r,1:9);
    ind1 = mode(ind9,2);
    t=1;
    if ind1 == 1
        cm_k9(1,1) = cm_k9(1,1)+t;
    elseif ind1 == 2
        cm_k9(1,2) = cm_k9(1,2)+t;
    else
        cm_k9(1,3) = cm_k9(1,3)+t;
    end
    r=r+1;
end

for r = 1:50
    ind9 = index2(r,1:9);
    ind1 = mode(ind9,2);
    t=1;
    if ind1 == 1
        cm_k9(2,1) = cm_k9(2,1)+t;
    elseif ind1 == 2
        cm_k9(2,2) = cm_k9(2,2)+t;
    else
        cm_k9(2,3) = cm_k9(2,3)+t;
    end
    r=r+1;
end

for r = 1:50
    ind9 = index3(r,1:9);
    ind1 = mode(ind9,2);
    t=1;
    if ind1 == 1
        cm_k9(3,1) = cm_k9(3,1)+t;
    elseif ind1 == 2
        cm_k9(3,2) = cm_k9(3,2)+t;
    else
        cm_k9(3,3) = cm_k9(3,3)+t;
    end
    r=r+1;
end

%k=11
for r = 1:50
    ind11 = index1(r,1:11);
    ind1 = mode(ind11,2);
    t=1;
    if ind1 == 1
        cm_k11(1,1) = cm_k11(1,1)+t;
    elseif ind1 == 2
        cm_k11(1,2) = cm_k11(1,2)+t;
    else
        cm_k11(1,3) = cm_k11(1,3)+t;
    end
    r=r+1;
end

for r = 1:50
    ind11 = index2(r,1:11);
    ind1 = mode(ind11,2);
    t=1;
    if ind1 == 1
        cm_k11(2,1) = cm_k11(2,1)+t;
    elseif ind1 == 2
        cm_k11(2,2) = cm_k11(2,2)+t;
    else
        cm_k11(2,3) = cm_k11(2,3)+t;
    end
    r=r+1;
end

for r = 1:50
    ind11 = index3(r,1:11);
    ind1 = mode(ind11,2);
    t=1;
    if ind1 == 1
        cm_k11(3,1) = cm_k11(3,1)+t;
    elseif ind1 == 2
        cm_k11(3,2) = cm_k11(3,2)+t;
    else
        cm_k11(3,3) = cm_k11(3,3)+t;
    end
    r=r+1;
end
