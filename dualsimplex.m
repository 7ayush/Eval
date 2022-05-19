% Ayush Kaushik 101903619 3COE24 DUAL SIMPLEX

format short
clear all;
clc

Variables={'x_1','x_2','x_3','s_1','s_2','sol'};

Cost= [-2 0 -1 0 0 0];
Info= [-1 -1 1; -1 2 -4];
b=[-5; -8];
s= eye(size(Info,1));
A= [Info s b];
BV=[];

for j=1:size(s,2)
 for i=1:size(A,2)
    if A(:,i)==s(:,j)
    BV=[BV i];
    end
 end
end

fprintf('Basic Variables=')
disp(Variables(BV));
zjcj= Cost(BV)*A-Cost;
zcj=[zjcj;A];
SimpTable=array2table(zcj);
SimpTable.Properties.VariableNames(1:size(zcj,2))= Variables
RUN = true;
while RUN
 SOL=A(:,end);
 if any(SOL<0);
 fprintf('The Current BFS is not Feasible \n');
 [LeaVal, pvt_row]= min(SOL);
 fprintf('Leaving Row= %d \n',pvt_row);
 
 ROW = A(pvt_row,1:end-1);
 ZJ= zjcj(:,1:end-1);
 for i=1:size(ROW,2)
 if ROW(i)<0
 ratio(i)=abs(ZJ(i)./ROW(i));
 else
 ratio(i)=inf;
 end
 end
 
 [minVal,pvt_col]=min(ratio);
 fprintf('Entering Variable= %d \n',pvt_col);
 
 BV(pvt_row)=pvt_col;
 fprintf('Basic Variables =')
 disp(Variables(BV));
 
 pvt_key = A(pvt_row,pvt_col);
 A(pvt_row,:)=A(pvt_row,:)./pvt_key;
 
 for i=1:size(A,1)
 if i~=pvt_row
 A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
 end
 end
 
 zjcj= Cost(BV)*A-Cost;
 zcj=[zjcj;A];
 SimpTable=array2table(zcj);
 SimpTable.Properties.VariableNames(1:size(zcj,2))= Variables
 else
 RUN=false;
 fprintf('Current BFS is feasible and optimal \n');
 end
end

Final_BFS=zeros(1,size(A,2));
Final_BFS(BV)=A(:,end);
Final_BFS(end)=sum(Final_BFS.*Cost);
OptimalBFS= array2table(Final_BFS);
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS,2))=Variables