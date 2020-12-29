# -*- coding: utf-8 -*-
"""
Created on Sat May 26 23:29:17 2018

@author: Joe Johnson

task: SVM, kernal=linear ,dataset=1,linear non-separable
classes:all classes
visualization=decision boundary,test data
confusion matrix
"""
import pandas as pd
#lib for analysis
import numpy as np
from sklearn import svm
#lib for visuals
import matplotlib.pyplot as plt
import seaborn as sns; sns.set(font_scale=1.2)

#read training data
tr_all_class = pd.read_csv('C:/Users/Pinnacle/Desktop/pr_asgn4/group2_joe/ds1/nls/nls_tr.csv',delimiter=',')
#read testing data
ts_all_class = pd.read_csv('C:/Users/Pinnacle/Desktop/pr_asgn4/group2_joe/ds1/nls/nls_ts.csv' ,delimiter=',')
#create label for all classes
classes = tr_all_class[['a','b']].as_matrix()
c1 = np.zeros(375)
c2 = np.ones(375)
c3 = 2*np.ones(375)
type_label = np.concatenate((c1,c2,c3),axis=0)

#Fit the model
#model = svm.SVC(kernel='linear',C=1)
#model = svm.SVC(kernel='poly', C=1, gamma=1.54, degree=5)
#model = svm.SVC(kernel='linear',decision_function_shape='ovr')#one vs rest
#model = svm.SVC(kernel='linear',decision_function_shape='ovo')#one vs one
model = svm.SVC(kernel='rbf', C=1, gamma=1)#radial basis function
model.fit(classes, type_label)

#Predict New Case

# The data of the plot will be added in these lists
x_data_c1=[]
y_data_c1=[]
x_data_c2=[]
y_data_c2=[]
x_data_c3=[]
y_data_c3=[]

#confusion matrix
cm_ls = np.zeros((3,3))

# Create a function to guess when a input is a class1 or a class2 or a class3
def class1_or_class2_or_class3_test(x_ts, y_ts):
    if(model.predict([[x_ts, y_ts]]))==0:
        #print('belong to class1!!')
        #plt.plot(x_a,x_b,'rs',hold=True)
        # Save the new points for x and y
        x_data_c1.append(x_ts)
        y_data_c1.append(y_ts)
        #update confusion matrix
        if(c_ts)=='class1':
            cm_ls[0][0]=cm_ls[0][0]+1
        elif(c_ts)=='class2':
            cm_ls[1][0]=cm_ls[1][0]+1
        else:
            cm_ls[2][0]=cm_ls[2][0]+1
    elif(model.predict([[x_ts, y_ts]]))==1:
        #print('belong to class2!!')
        # Save the new points for x and y
        x_data_c2.append(x_ts)
        y_data_c2.append(y_ts)
        #update confusion matrix
        if(c_ts)=='class2':
            cm_ls[1][1]=cm_ls[1][1]+1
        elif(c_ts)=='class1':
            cm_ls[0][1]=cm_ls[0][1]+1
        else:
            cm_ls[2][1]=cm_ls[2][1]+1
    else:
        #print('belong to class3!')
        # Save the new points for x and y
        x_data_c3.append(x_ts)
        y_data_c3.append(y_ts)
        #update confusion matrix
        if(c_ts)=='class3':
            cm_ls[2][2]=cm_ls[2][2]+1
        elif(c_ts)=='class2':
            cm_ls[2][1]=cm_ls[2][1]+1
        else:
            cm_ls[2][0]=cm_ls[2][0]+1

x_all_c1=[]
y_all_c1=[]
x_all_c2=[]
y_all_c2=[]
x_all_c3=[]
y_all_c3=[]
def class1_or_class2_or_class3_all_points(x_a, x_b):
    if(model.predict([[x_a, x_b]]))==0:
        #print('belong to class1!!')
        #plt.plot(x_a,x_b,'rs',hold=True)
        # Save the new points for x and y
        x_all_c1.append(x_a)
        y_all_c1.append(x_b)
    elif(model.predict([[x_a, x_b]]))==1:
        #print('belong to class2!!')
        # Save the new points for x and y
        x_all_c2.append(x_a)
        y_all_c2.append(x_b)
    else:
        #print('belong to class3!')
        # Save the new points for x and y
        x_all_c3.append(x_a)
        y_all_c3.append(x_b)
        
#range using float
def frange(start, step, stop):
    i = start
    while i < stop:
        yield i
        i += step
    
for x_all in frange(-2,.1,5):
    for y_all in frange(-2,.1,2):
        x_a= x_all
        x_b= y_all
        class1_or_class2_or_class3_all_points(x_a,x_b)

for i in range(len(ts_all_class)):
    x_ts=ts_all_class['a'][i]
    y_ts=ts_all_class['b'][i]
    c_ts=ts_all_class['Type'][i]
    class1_or_class2_or_class3_test(x_ts,y_ts)

plt.plot(x_all_c1,y_all_c1,'C2s',x_all_c2,y_all_c2,'C5s',x_all_c3,y_all_c3,'C7s',
         x_data_c1, y_data_c1, 'rs', x_data_c2, y_data_c2, 'bs', x_data_c3, y_data_c3, 'gs')
plt.xlabel('x1')
plt.ylabel('x2')
plt.title('2D linearly separable data')
#plt.legend(['Sine', 'Cosine'])
plt.show()

# to print kernel used
print('%s' %model)

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
