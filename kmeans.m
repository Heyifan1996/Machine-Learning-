load 'data.mat';
B=rand(10,4);%B�����������randn���ɵ�10*4���������
A=data(:,1:4);%��Ϊ��������
% A=A(randperm(length(A)),:);
k=4;%����������
m=length(A);%������
n=4;%����ά��
%��ʼ��ģ�Ͳ���
% u=zeros(k,n);%��ֵ����
u=B(1:k,:);%ȡB��ǰk����Ϊ��ʼ��ֵ����
maxiter=100;%����������
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
%������ֵ����
u(1,:)=sum(C1(:,1:4))/length(C1);
u(2,:)=sum(C2(:,1:4))/length(C2);
u(3,:)=sum(C3(:,1:4))/length(C3);

end
%���涼�ǻ�ͼ�ͼ����㷨�����ܲ���
figure(1);
plot3(u(:,1),u(:,2),u(:,3),'ro');hold on
plot3(C1(:,1),C1(:,2),C1(:,3),'b*');hold on;
plot3(C2(:,1),C2(:,2),C2(:,3),'c+');hold on;
plot3(C3(:,1),C3(:,2),C3(:,3),'k.');hold on;
% title('�ֲ�ͼ');hold off;
% figure(2);
% plot(1:maxiter,LLD);
% xlabel('��������');
% ylabel('������ʶ���');
% title('�Ż�����ͼ');
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
JC=jc_a/(jc_a+jc_b+jc_c);%jaccardϵ��