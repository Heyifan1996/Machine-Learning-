function [ y ] = byspred( x,P,pk )
k=length(pk);
score=zeros(k,1);
for i=1:k
    score(i)=pk(i)*P(1,x(1),i)*P(2,x(2),i)*P(3,x(3),i)*P(4,x(4),i);   
end
[~,y]=max(score);
end

