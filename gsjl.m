load 'data.mat';
A=data(:,1:4);%作为聚类样本
% A=A(randperm(length(A)),:);
k=3;%聚类类别个数
m=length(A);%样本数
n=4;%样本维数
%初始化模型参数
a=repmat(1/k,1,k);%混合系数
u=zeros(k,n);%均值向量
u(1,:)=A(6,:);
u(2,:)=A(66,:);
u(3,:)=sum(A(101:150,:))/50;
covs=zeros(n,n,k);%协方差矩阵
for i=1:k
    covs(:,:,i)=0.1*eye(4);
end
maxiter=100;
threshold=1e-10;
LLD=zeros(1,maxiter);
for iter=1:maxiter
r=zeros(m,k);%计算后验概率的对数
for i=1:m
    for j=1:k
        r(i,j)=p(A(i,:),u(j,:),n,covs(:,:,j));
    end
end
r1=r.*repmat(a,m,1);
LLD(iter)=sum(log(sum(r1,2))); %对数似然
r0=r1./repmat(sum(r1,2),1,k);%rij由第j个类生成的后验概率
%  if LLD(iter)<threshold
%      break
%  end
for i=1:k%更新所有参数
    covs(:,:,i)=zeros(n);
    for j=1:m
     covs(:,:,i)=covs(:,:,i)+r0(j,i)*(A(j,:)-u(i,:))'*(A(j,:)-u(i,:));  
    end
     covs(:,:,i)=covs(:,:,i)/sum(r0(:,i));
    u(i,:)=sum(repmat(r0(:,i),1,n).*A)/sum(r0(:,i));
    a(i)=sum(r0(:,i))/m;   
end
end
[~,L]=max(r0');
L=L';
B=horzcat(A,L);
B1=B(L==1,:);
B2=B(L==2,:);
B3=B(L==3,:);

figure(1);
plot3(u(:,1),u(:,2),u(:,3),'ro');hold on
plot3(B1(:,1),B1(:,2),B1(:,3),'b*');hold on;
plot3(B2(:,1),B2(:,2),B2(:,3),'c+');hold on;
plot3(B3(:,1),B3(:,2),B3(:,3),'k.');hold on;
% title('分布图');hold off;
figure(2);
plot(1:maxiter,LLD);
xlabel('The number of iterations');
ylabel('The logarithm of the posteriori probability ');
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
