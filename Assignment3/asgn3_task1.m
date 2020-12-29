clear;clc;close all;
w = 4;
cm_k1 = zeros(3,3);
cm_k3 = zeros(3,3);
cm_k5 = zeros(3,3);
cm_k9 = zeros(3,3);
cm_k11 = zeros(3,3);
%For coast training data
for j = 0:49
    for k = 0:49
        load('train_coast_data');
        %load('train_kennel_outdoor_data');
        %load('train_volleyball_court_indoor_data');
        a = RGB_24bins((1+(k*64)):(64+(k*64)),:);
        load('test_coast_data');
        b = RGB_24bins((1+(j*64)):(64+(j*64)),:);
        d1((j+1),(k+1))=dtw_new(a,b,w);
    end
end
%fprintf('Using Matlab version: distance=%f\n',d1);
%for Kennel outdoor test data
for j = 0:49
    for k = 0:49
        load('train_coast_data');
        %load('train_kennel_outdoor_data');
        %load('train_volleyball_court_indoor_data');
        a = RGB_24bins((1+(k*64)):(64+(k*64)),:);
        load('test_kennel_outdoor_data');
        b = RGB_24bins((1+(j*64)):(64+(j*64)),:);
        d2((j+1),(k+1))=dtw_new(a,b,w);
    end
end
%for volleyball court indoor test data
for j = 0:49
    for k = 0:49
        load('train_coast_data');
        %load('train_kennel_outdoor_data');
        %load('train_volleyball_court_indoor_data');
        a = RGB_24bins((1+(k*64)):(64+(k*64)),:);
        load('test_volleyball_court_indoor_data');
        b = RGB_24bins((1+(j*64)):(64+(j*64)),:);
        d3((j+1),(k+1))=dtw_new(a,b,w);
    end
end
d4 = [d1,d2,d3];
%%%
[sort_coast,index] = sort(d4, 2, 'descend');

index1 = index;
%Labling class to sorted index
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For kennel outdoor training data
for j = 0:49
    for k = 0:49
        %load('train_coast_data');
        load('train_kennel_outdoor_data');
        %load('train_volleyball_court_indoor_data');
        a = RGB_24bins((1+(k*64)):(64+(k*64)),:);
        load('test_coast_data');
        b = RGB_24bins((1+(j*64)):(64+(j*64)),:);
        d1((j+1),(k+1))=dtw_new(a,b,w);
    end
end
%fprintf('Using Matlab version: distance=%f\n',d1);
%for Kennel outdoor test data
for j = 0:49
    for k = 0:49
        %load('train_coast_data');
        load('train_kennel_outdoor_data');
        %load('train_volleyball_court_indoor_data');
        a = RGB_24bins((1+(k*64)):(64+(k*64)),:);
        load('test_kennel_outdoor_data');
        b = RGB_24bins((1+(j*64)):(64+(j*64)),:);
        d2((j+1),(k+1))=dtw_new(a,b,w);
    end
end
%for volleyball court indoor test data
for j = 0:49
    for k = 0:49
        %load('train_coast_data');
        load('train_kennel_outdoor_data');
        %load('train_volleyball_court_indoor_data');
        a = RGB_24bins((1+(k*64)):(64+(k*64)),:);
        load('test_volleyball_court_indoor_data');
        b = RGB_24bins((1+(j*64)):(64+(j*64)),:);
        d3((j+1),(k+1))=dtw_new(a,b,w);
    end
end
d4 = [d1,d2,d3];
%%%
[sort_kennel_outdoor,index] = sort(d4, 2, 'descend');

index2 = index;
%Labling class to sorted index
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For volleyball court indoor training data
for j = 0:49
    for k = 0:49
        %load('train_coast_data');
        %load('train_kennel_outdoor_data');
        load('train_volleyball_court_indoor_data');
        a = RGB_24bins((1+(k*64)):(64+(k*64)),:);
        load('test_coast_data');
        b = RGB_24bins((1+(j*64)):(64+(j*64)),:);
        d1((j+1),(k+1))=dtw_new(a,b,w);
    end
end
%fprintf('Using Matlab version: distance=%f\n',d1);
%for Kennel outdoor test data
for j = 0:49
    for k = 0:49
        %load('train_coast_data');
        %load('train_kennel_outdoor_data');
        load('train_volleyball_court_indoor_data');
        a = RGB_24bins((1+(k*64)):(64+(k*64)),:);
        load('test_kennel_outdoor_data');
        b = RGB_24bins((1+(j*64)):(64+(j*64)),:);
        d2((j+1),(k+1))=dtw_new(a,b,w);
    end
end
%for volleyball court indoor test data
for j = 0:49
    for k = 0:49
        %load('train_coast_data');
        %load('train_kennel_outdoor_data');
        load('train_volleyball_court_indoor_data');
        a = RGB_24bins((1+(k*64)):(64+(k*64)),:);
        load('test_volleyball_court_indoor_data');
        b = RGB_24bins((1+(j*64)):(64+(j*64)),:);
        d3((j+1),(k+1))=dtw_new(a,b,w);
    end
end
d4 = [d1,d2,d3];
%%%
[sort_volleyball_court_indoor,index] = sort(d4, 2, 'descend');

index3 = index;
%Labling class to sorted index
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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