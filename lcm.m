clc;
clear all;
%% Initialisation 
c=[2 10 4 5; 6 12 8 11; 3 9 5 7];
a=[12; 25; 20];
b=[25; 10; 15; 5];

%% Making balanced TP if not balanced
[m,n]=size(c);

if sum(a) ==sum(b)
    fprintf('T.P. is balanced');
else fprintf('T.P. is unbalanced');
    if sum(a)>sum(b)
        c(:,end+1)=zeros(m,1);
        b(end+1) = sum(a)-sum(b);
    else
        c(end+1,:)=zeros(1,n);
        a(end+1)= sum(b)-sum(a);
    end
end
[m,n]=size(c);
%% Iterating

IC=c; %%initial cost matrix
X=zeros(m,n); %%Allocation matrix

for i=1:m
    for j=1:n
        cpq=min(c(:));  %%Minimum cost
        [row_in col_in]=find(cpq==c);%position
        x11=min(a(row_in),b(col_in));        
        [value index]=max(x11);%max allocation value
        ii=row_in(index);
        jj=col_in(index);
        a(ii)=a(ii)-value;
        b(jj)=b(jj)-value;
        X(ii,jj)=value;
        c(ii,jj)=inf;
    end
end

z=0;

z=sum(sum(IC.*X));
z