load 'data.mat';
B=rand(10,4);%B是用随机函数randn生成的10*4的随机矩阵
A=data(:,1:4);%作为聚类样本
% A=A(randperm(length(A)),:);
k=4;%聚类类别个数
m=length(A);%样本数
n=4;%样本维数
%初始化模型参数
% u=zeros(k,n);%均值向量
u=B(1:k,:);%取B的前k行作为初始均值向量
maxiter=100;%最大迭代次数
for iter=1:maxiter
distance=zeros(m,k);
for i=1:m
    for j=1:k
        distance(i,j)=norm(A(i,:)-u(j,:));
    end    
end
[~,L]=max(distance');
L=L';
C=horzcat(A,L);
C1=C(L==1,:);
C2=C(L==2,:);
 C3=C(L==3,:);
%三个均值向量
u(1,:)=sum(C1(:,1:4))/length(C1);
u(2,:)=sum(C2(:,1:4))/length(C2);
u(3,:)=sum(C3(:,1:4))/length(C3);

end
%后面都是画图和计算算法的性能参数
figure(1);
plot3(u(:,1),u(:,2),u(:,3),'ro');hold on
plot3(C1(:,1),C1(:,2),C1(:,3),'b*');hold on;
plot3(C2(:,1),C2(:,2),C2(:,3),'c+');hold on;
plot3(C3(:,1),C3(:,2),C3(:,3),'k.');hold on;
% title('分布图');hold off;
% figure(2);
% plot(1:maxiter,LLD);
% xlabel('迭代次数');
% ylabel('后验概率对数');
% title('优化函数图');
true_L=data(:,5);
  jc_a=0;
  jc_b=0;
  jc_c=0;
  jc_d=0;
for i=1:m-1
    for j=i:m      
 
  if true_L(i)==true_L(j)&&L(i)==L(j)
      jc_a=jc_a+1;
  elseif true_L(i)==true_L(j)&&L(i)~=L(j)
      jc_b=jc_b+1;
  elseif true_L(i)~=true_L(j)&&L(i)==L(j)
      jc_c=jc_c+1;
  elseif true_L(i)~=true_L(j)&&L(i)~=L(j)
      jc_d=jc_d+1;
  end
    end
end
JC=jc_a/(jc_a+jc_b+jc_c);%jaccard系数