function [mu_1,sigma_1,pi_1,N_k,ll,IL]=gussianMixMod(data,K,iteration)

% data=feature vectors.every row is a feature vector
% K=no of mix/no of Gaussians
% iteration=no of iteration
% mu_1=mean vctor. every row is a mean vector.
% sigma_1=(3X1) cells. every cell contains one co variance matrix
% pi_1=Mixing coefficient. row vector. every kth value gives kth mix coeff
% N_k = Effective no of examples in K no of mix
% ll = log likelyhood of every train set.scalar
% IL= Iteration and loglikelyhood

di=size(data,2); % dimension of data
N=size(data,1);

%%%%%%%%%%%% Initialization   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [CD,mu_0]=kmeans1(data,K);   % Finding initial means using k-means
[ids,mu_0]=kmeans(data,K);
CD=cell(K,1);
for i=1:1:K
CD{i,1}=data(ids==1,:);
end
sigma_0=cell(K,1);

for i=1:1:K    % Initial covariance matrix calculation and mixing coefficient claculation
    cl=size(CD{i,1},1);   % cluster length
    sigma_0{i,1}=((CD{i,1}-repmat(mu_0(i,:),cl,1))'*(CD{i,1}-repmat(mu_0(i,:),cl,1)))/cl;  %Covariance matrix calculation
     sigma_0{i,1}=eye(di,di).*sigma_0{i,1};
    pi_0(i)=cl/N;
end
% initial loglikelihood

ll_o=0;
for i=1:1:N  % for N no of feature vectors
    d1=data(i,:);   
    l_g=0;
    for j=1:1:K   %for k no of mix
        l_g=l_g+pi_0(j)*(1/((2*pi)^(di/2))*((det(sigma_0{j,1}))^0.5))*exp(-0.5*(d1-mu_0(j,:))*inv(sigma_0{j,1})*(d1-mu_0(j,:))');       
    end
    ll_o=ll_o+log(l_g);
    
end
ll_o;
it=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Evaluate responsibilits %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IL=[];
while it<=iteration     % Iteration starts

for i2=1:1:N
    d1=data(i2,:);   
    
    for i3=1:1:K
        g(i2,i3)=pi_0(i3)*(1/((2*pi)^(di/2))*((det(sigma_0{i3,1}))^0.5))*exp(-0.5*(d1-mu_0(i3,:))*inv(sigma_0{i3,1})*(d1-mu_0(i3,:))');
        
    end
    
end
g_sum=repmat(sum(g,2),1,K);
ga=g./g_sum;    % gama(responsibilitis). Length is data length,Every column for very k.

%%%%%%%%%%%%%%%%%%%%%%%%% Re-estimation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N_k=sum(ga,1);

for i4=1:1:K
    mu_1(i4,:)=(1/N_k(i4))*sum(repmat(ga(:,i4),1,di).*data,1);
    s_temp=zeros(di,di);
    for i5=1:1:N
        s_temp=s_temp+ga(i5,i4)*(data(i5,:)-mu_1(i4,:))'*(data(i5,:)-mu_1(i4,:));
    end
    sigma_1{i4,1}=(1/N_k(i4))*s_temp;
     sigma_1{i4,1}=eye(di,di).*sigma_1{i4,1};
    pi_1(i4)=N_k(i4)/N;
end

mu_0=mu_1;   % Reassign
sigma_0=sigma_1;
pi_0=pi_1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Log likelihood calculation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ll=0;
for j=1:1:N  % for N no of feature vectors
    d1=data(j,:);   
    l_g=0;
    for j1=1:1:K   %for k no of mix
        l_g=l_g+pi_0(j1)*(1/((2*pi)^(di/2))*((det(sigma_0{j1,1}))^0.5))*exp(-0.5*(d1-mu_0(j1,:))*inv(sigma_0{j1,1})*(d1-mu_0(j1,:))');       
    end
    ll=ll+log(l_g);
    
end
it=it+1;
 ll_o;
 ll;
sc=abs((ll-ll_o)/ll_o);
IL=[IL;it ll];
if(sc<=0.01)
    break;
end
    
ll_o=ll;

% figure(5)
% plot(it,ll,'linewidth',2);
% hold on
end
it
end