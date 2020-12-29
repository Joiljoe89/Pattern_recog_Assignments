function [CD,mu1]=kmeans1(data,k)
%data=Total input data.Every row is a feature vector
%k=no of clusters
%CD=Clustered data in cell
%mu1=Mean.Every row is a mean vector
    
    l1=length(data(:,1));
    flag=0;
    ini_ids=randi([1 l1],1,k);
    
    for i=1:1:k
        id=ini_ids(i);
        mu(i,:)=data(id,:);
    end
    
% %     n11=floor(l1/k); % no of feature vectors in each cluster for initialization only
% %     for i=1:1:k
% %         mu(i,:)=mean(data(((i-1)*n11)+1:((i-1)*n11)+n11,:),1);
% %         
% %     end
    
    iteration=0;
    while iteration<=16
        CD=cell(k,1);
        for i1=1:1:l1
            fe=repmat(data(i1,:),k,1);
            d=sqrt(sum((fe-mu).*(fe-mu),2));
            [min1,min_id]=min(d);
            CD{min_id,1}=[CD{min_id,1};data(i1,:)];  % Data is being kept in ifferent cluster
        
        end
        for ii=1:1:k
            if(isempty(CD{ii,1})==1)
                flag=1;
                break;
            end
        end
  
       if(flag==1)
           if(ii>1)
           CD{ii,1}=(1/2)*(mean(CD{ii-1},1)+mean(CD{ii+1},1));
           end
           msgbox(sprintf('%d th cluster is empty',ii));
           break;
       end
        
        for i2=1:1:k
            mu1(i2,:)=mean(CD{i2,1},1);        
        end
        iteration=iteration+1;
        flag=sum(abs(mu(:)-mu1(:)));
        if(flag<0.0005)
        %if(iteration==10)
            break;
        else
            
            mu=mu1;
        end
        
    end
    CD;
    mu1;
end