# -*- coding: utf-8 -*-
"""
Created on Sat May 26 23:29:17 2018

@author: Joe Johnson

task: SVM, kernal=linear ,dataset=2,scene image
classes:all classes
visualization=decision boundary,test data
confusion matrix
"""
import pandas as pd
#lib for analysis
import numpy as np
from sklearn import svm
#lib for visuals
#import matplotlib.pyplot as plt
import seaborn as sns; sns.set(font_scale=1.2)

#read training data
tr_all_class = pd.read_csv('D:/Seafile/Seafile/My Library/IIT Mandi/even_course_feb18/CS669_PR/assignment4/matlab code/pr_asgn4/group2_joe/ds2/tr_all.csv',delimiter=',')
#read testing data
ts_all_class = pd.read_csv('D:/Seafile/Seafile/My Library/IIT Mandi/even_course_feb18/CS669_PR/assignment4/matlab code/pr_asgn4/group2_joe/ds2/Tr_all.csv' ,delimiter=',')
#create label for all classes
classes = tr_all_class[['x1','x2','x3','x4','x5','x6','x7','x8','x9','x10','x11',
                        'x12','x13','x14','x15','x16','x17','x18','x19','x20','x21',
                        'x22','x23','x24','x25','x26','x27','x28','x29','x30','x31','x32']].as_matrix()
c1 = np.zeros(50)
c2 = np.ones(50)
c3 = 2*np.ones(50)
type_label = np.concatenate((c1,c2,c3),axis=0)

#Fit the model
#model = svm.SVC(kernel='linear',C=2.37**-5)
model = svm.SVC(kernel='poly',degree=2)
#model = svm.SVC(kernel='linear',decision_function_shape='ovr')#one vs rest
#model = svm.SVC(kernel='linear',decision_function_shape='ovo')#one vs one
#model = svm.SVC(kernel='rbf', C=1, gamma=.0009)#radial basis function
model.fit(classes, type_label)
print('%s' %model)
#Predict New Case

#confusion matrix
cm_ls = np.zeros((3,3))

# Create a function to guess when a input is a class1 or a class2 or a class3
def class1_or_class2_or_class3_test(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,
                       x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32):
    if(model.predict([[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,
                       x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32]]))==0:
        #print('belong to class1!!')
        #update confusion matrix
        if(c_ts)=='coast':
            cm_ls[0][0]=cm_ls[0][0]+1
        elif(c_ts)=='kennel':
            cm_ls[1][0]=cm_ls[1][0]+1
        else:
            cm_ls[2][0]=cm_ls[2][0]+1
    elif(model.predict([[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,
                       x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32]]))==1:
        #print('belong to class2!!')
        #update confusion matrix
        if(c_ts)=='kennel':
            cm_ls[1][1]=cm_ls[1][1]+1
        elif(c_ts)=='coast':
            cm_ls[0][1]=cm_ls[0][1]+1
        else:
            cm_ls[2][1]=cm_ls[2][1]+1
    else:
        #print('belong to class3!')
        #update confusion matrix
        if(c_ts)=='vollyball':
            cm_ls[2][2]=cm_ls[2][2]+1
        elif(c_ts)=='kennel':
            cm_ls[2][1]=cm_ls[2][1]+1
        else:
            cm_ls[2][0]=cm_ls[2][0]+1

#input test data
for i in range(len(ts_all_class)):
    x1=ts_all_class['x1'][i]
    x2=ts_all_class['x2'][i]
    x3=ts_all_class['x3'][i]
    x4=ts_all_class['x4'][i]
    x5=ts_all_class['x5'][i]
    x6=ts_all_class['x6'][i]
    x7=ts_all_class['x7'][i]
    x8=ts_all_class['x8'][i]
    x9=ts_all_class['x9'][i]
    x10=ts_all_class['x10'][i]
    x11=ts_all_class['x11'][i]
    x12=ts_all_class['x12'][i]
    x13=ts_all_class['x13'][i]
    x14=ts_all_class['x14'][i]
    x15=ts_all_class['x15'][i]
    x16=ts_all_class['x16'][i]
    x17=ts_all_class['x17'][i]
    x18=ts_all_class['x18'][i]
    x19=ts_all_class['x19'][i]
    x20=ts_all_class['x20'][i]
    x21=ts_all_class['x21'][i]
    x22=ts_all_class['x22'][i]
    x23=ts_all_class['x23'][i]
    x24=ts_all_class['x24'][i]
    x25=ts_all_class['x25'][i]
    x26=ts_all_class['x26'][i]
    x27=ts_all_class['x27'][i]
    x28=ts_all_class['x28'][i]
    x29=ts_all_class['x29'][i]
    x30=ts_all_class['x30'][i]
    x31=ts_all_class['x31'][i]
    x32=ts_all_class['x32'][i]
   
    c_ts=ts_all_class['Type'][i]
    class1_or_class2_or_class3_test(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,
                       x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32)

#performance of classifier
print(cm_ls)
#Recall
recall_c1 = cm_ls[0,0]/(cm_ls[0,0]+cm_ls[1,0]+cm_ls[2,0])
recall_c2 = cm_ls[1,1]/(cm_ls[0,1]+cm_ls[1,1]+cm_ls[2,1])
recall_c3 = cm_ls[2,2]/(cm_ls[0,2]+cm_ls[1,2]+cm_ls[2,2])
mean_recall = (recall_c1+recall_c2+recall_c3)/3
print('mean_recall is: ',mean_recall)
#Precision
precision_c1 = cm_ls[0,0]/(cm_ls[0,0]+cm_ls[0,1]+cm_ls[0,2])
precision_c2 = cm_ls[1,1]/(cm_ls[1,0]+cm_ls[1,1]+cm_ls[1,2])
precision_c3 = cm_ls[2,2]/(cm_ls[2,0]+cm_ls[1,2]+cm_ls[2,2])
mean_precision = (precision_c1+precision_c2+precision_c3)/3
print('mean_precision is: ',mean_precision)
#F-Score
f_score_c1 = (2*(precision_c1*recall_c1))/(precision_c1+recall_c1)
f_score_c2 = (2*(precision_c2*recall_c2))/(precision_c2+recall_c2)
f_score_c3 = (2*(precision_c3*recall_c3))/(precision_c3+recall_c3)
mean_f_score = (f_score_c1+f_score_c2+f_score_c3)/3
print('mean_f_score:',  mean_f_score)
#Accuracy
acc = ((cm_ls[0,0]+cm_ls[1,1]+cm_ls[2,2])*100)/(cm_ls[0,0]+cm_ls[0,1]+cm_ls[0,2]
+cm_ls[1,0]+cm_ls[1,1]+cm_ls[1,2]+cm_ls[2,0]+cm_ls[1,2]+cm_ls[2,2])
print('Accuracy is: ',acc)
