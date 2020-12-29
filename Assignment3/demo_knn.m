load('train_coast_data');
d_t = RGB_24bins; %training_data
L =  [ones(1,50),2*ones(1,50),3*ones(1,50)]; %label
load('test_coast_data');
d =  [RGB_24bins;RGB_24bins;RGB_24bins]; %testing
est_L = KNN_(3,d_t,L,d);