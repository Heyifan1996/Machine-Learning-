load 'bys.mat';
l=zeros(50,1);
for t=1:50
m=length(A.data);
Y=zeros(m,1);
for i=1:m%格式转换L,B,R转换为1，2，3
   if strcmp(A.textdata(i),'L')==1
       Y(i)=1;
   elseif strcmp(A.textdata(i),'B')==1
       Y(i)=2;
   else
       Y(i)=3;
  end
end
data=horzcat(A.data,Y);
label=unique(data(:,end));%不同的标记
a=randperm(length(data));%随机生成625的随机序列
train=data(a(1:round(0.8*length(a))),:);%训练集
test=data(a(1+round(0.8*length(a)):end),:);%测试集
p=zeros(3,1);
p(1)=length(find(train(:,end)==1));
p(2)=length(find(train(:,end)==2));
p(3)=length(find(train(:,end)==3));
pk=p/length(train);
P=zeros(4,5,3);
for k=1:3
    for n=1:4
        for i=1:5
            P(n,i,k)=length(find(train(:,end)==k&train(:,n)==i))/p(k);
        end
    end
end
predict=zeros(length(test),1);
for i=1:length(test)
    predict(i)=byspred(test(i,:),P,pk);
end
B=horzcat(test(:,end),predict);
error=B(:,1)-B(:,2);
mingzhonglv=length(find(error==0))/length(test);
l(t)=mingzhonglv;
end
L=sum(l)/length(l);