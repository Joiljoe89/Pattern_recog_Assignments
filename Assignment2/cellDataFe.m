function [fe]=cellDataFe(I)

I=double(I);               
[r1,c1]=size(I);
 m1=7;m2=7;
 n1=ceil(r1/m1); n2=ceil(c1/m2); 
 %r=m1*n1;c=m2*n2;
 r=266;c=266
 Ir=imresize(I,[r c]);
                
 fe=[];
 for k=1:1:r-m1
     for l=1:1:c-m2
         I1=Ir(k:k+m1-1,l:l+m2-1);               
         mu=sum(I1(:))/length(I1(:));
         var=sum((I1(:)-(repmat(mu,length(I1(:)),1))).^2)/(length(I1(:))-1);
         fe=[fe;mu var];               
      end
 end
end