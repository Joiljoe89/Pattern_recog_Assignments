function P=cdcP(X,Y,mu,sigma)

[X1,Y1]=meshgrid(X,Y);
X2=X1(:);
Y2=Y1(:);
di=2;
l=length(X2);
for i=1:1:l
    d1=[X2(i) Y2(i)];
    p1(i)=(1/((2*pi)^(di/2))*((det(sigma)^0.5))*exp(-0.5*(d1-mu)*inv(sigma)*(d1-mu)'));
end

    P=reshape(p1,length(X),length(Y));
end