# -*- coding: utf-8 -*-
"""
Created on Sat May 26 09:41:58 2018

@author: Joe Johnson
"""
import pandas as pd

#read training data
#tr_class1 = pd.read_csv('C:/Users/Pinnacle/Desktop/pr_asgn4/ds1/ls/training/Train_data_class1.txt',sep=' ' ,delimiter=',')
tr_class1 = pd.read_csv('C:/Users/Pinnacle/Desktop/pr_asgn4/ds1/ls/training/Tr1.csv',delimiter=',')
#q = tr_class1.head()
tr_class2 = pd.read_csv('C:/Users/Pinnacle/Desktop/pr_asgn4/ds1/ls/training/Tr2.csv',delimiter=',')
tr_class3 = pd.read_csv('C:/Users/Pinnacle/Desktop/pr_asgn4/ds1/ls/training/Tr3.csv',delimiter=',')
tr_all_class = pd.read_csv('C:/Users/Pinnacle/Desktop/pr_asgn4/ds1/ls/training/Tr_all.csv',delimiter=',')

#read testing data
ts_class1 = pd.read_csv('C:/Users/Pinnacle/Desktop/pr_asgn4/ds1/ls/testing/Ts1.csv' ,delimiter=',')
ts_class2 = pd.read_csv('C:/Users/Pinnacle/Desktop/pr_asgn4/ds1/ls/testing/Ts2.csv' ,delimiter=',')
ts_class3 = pd.read_csv('C:/Users/Pinnacle/Desktop/pr_asgn4/ds1/ls/testing/Ts3.csv' ,delimiter=',')
ts_all_class = pd.read_csv('C:/Users/Pinnacle/Desktop/pr_asgn4/ds1/ls/testing/Ts_all.csv' ,delimiter=',')
#lib for analysis
import numpy as np
from sklearn import svm
#lib for visuals
import matplotlib.pyplot as plt
import seaborn as sns; sns.set(font_scale=1.2) #Seaborn is a Python visualization
# library based on matplotlib. It provides a high-level interface for drawing
# attractive statistical graphics.

#data visualization
#sns.lmplot('a','b',data=tr_all_class,hue='Type',palette='Set1',fit_reg=False,scatter_kws={'s':70})

classes = tr_all_class[['a','b']].as_matrix()
c1 = np.zeros(375)
c2 = np.ones(375)
c3 = 2*np.ones(375)
type_label = np.concatenate((c1,c2,c3),axis=0)
#type_label = np.where(tr_all_class['Type']=='class2', 0, 1)

#Fit the model
#model = svm.SVC(kernel='linear',C=2**5)
#model = svm.SVC(kernel='linear')
model = svm.SVC(kernel='linear',decision_function_shape='ovr')#one vs rest
#model = svm.SVC(kernel='linear',decision_function_shape='ovo')#one vs one
#model = svm.SVC(kernel='rbf', C=1, gamma=2**-5)#radial basis function
model.fit(classes, type_label)
'''
#Visualize Results
# Get the separating hyperplane
w = model.coef_[0]
a1 = -w[0] / w[1]
xx = np.linspace(-12, 30)
yy = a1 * xx - (model.intercept_[0]) / w[1]

# Plot the parallels to the separating hyperplane that pass through the support vectors
b1 = model.support_vectors_[0]
yy_down = a1 * xx + (b1[1] - a1 * b1[0])
b2 = model.support_vectors_[-1]
yy_up = a1 * xx + (b2[1] - a1 * b2[0])

# Plot the hyperplane
sns.lmplot('a','b',data=tr_all_class,hue='Type',palette='Set1',fit_reg=False,scatter_kws={'s':70})
plt.plot(xx, yy, linewidth=2, color='black');

# Look at the margins and support vectors
sns.lmplot('a','b',data=tr_all_class,hue='Type',palette='Set1',fit_reg=False,scatter_kws={'s':70})
plt.plot(xx, yy, linewidth=2, color='black')
plt.plot(xx, yy_down, 'k--')
plt.plot(xx, yy_up, 'k--')
plt.scatter(model.support_vectors_[:, 0], model.support_vectors_[:, 1],
            s=80, facecolors='cyan');
'''
#Predict New Case
# Create a function to guess when a input is a class1 or a class2
def class1_or_class2_or_class3(x_a, x_b):
    if(model.predict([[x_a, x_b]]))==0:
        print('belong to class1!!')
    elif(model.predict([[x_a, x_b]]))==1:
        print('belong to class2!!')
    else:
        print('belong to class3!')
        
# Predict if 50 parts flour and 20 parts sugar
class1_or_class2_or_class3(-4, 8)

# Plot the point to visually see where the point lies
sns.lmplot('a','b',data=tr_all_class,hue='Type',palette='Set1',fit_reg=False,scatter_kws={'s':70})
#plt.plot(xx, yy, linewidth=2, color='black')
plt.plot(-4, 8, 'yo', markersize='9');

