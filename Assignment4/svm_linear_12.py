# -*- coding: utf-8 -*-
"""
Created on Sat May 26 22:20:49 2018

@author: Joe Johnson

task: SVM, kernal=linear ,dataset=1,linear separable
classes:1and2
visualization=supportvector,decision boundary

"""
import pandas as pd
#lib for analysis
import numpy as np
from sklearn import svm
#lib for visuals
import matplotlib.pyplot as plt
import seaborn as sns; sns.set(font_scale=1.2)
a='D:/Seafile/Seafile/My Library/IIT Mandi/even_course_feb18/CS669_PR/assignment4/matlab code/pr_asgn4/group2_joe/ds1/ls//training/Tr_12.csv'
tr_class_13 = pd.read_csv(a,delimiter=',')
#tr_class_13 = pd.read_csv('C:/Users/Pinnacle/Desktop/pr_asgn4/ds1/ls/training/Tr_12.csv',delimiter=',')


classes = tr_class_13[['a','b']].as_matrix()

c1 = np.zeros(375)
c2 = np.ones(375)
type_label = np.concatenate((c1,c2),axis=0)

#Fit the model
model = svm.SVC(kernel='linear',C=1)
#model = svm.SVC(kernel='linear')
#model = svm.SVC(kernel='linear',decision_function_shape='ovr')#one vs rest
#model = svm.SVC(kernel='linear',decision_function_shape='ovo')#one vs one
#model = svm.SVC(kernel='rbf', C=1, gamma=2**-5)#radial basis function
model.fit(classes, type_label)

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
sns.lmplot('a','b',data=tr_class_13,hue='Type',palette='Set1',fit_reg=False,scatter_kws={'s':70})
plt.plot(xx, yy, linewidth=2, color='black');

# Look at the margins and support vectors
sns.lmplot('a','b',data=tr_class_13,hue='Type',palette='Set1',fit_reg=False,scatter_kws={'s':70})
plt.plot(xx, yy, linewidth=2, color='black')
plt.plot(xx, yy_down, 'k--')
plt.plot(xx, yy_up, 'k--')
plt.scatter(model.support_vectors_[:, 0], model.support_vectors_[:, 1],
            s=80, facecolors='cyan');
plt.show()
