%%Ayush Kaushik 101903619 3COE24 Weighted sum
clc
clear all;

mocost=[3 2 0;2 3 0] 
w=1/size(mocost,1) 
socost=sum(mocost.*w) 
C=socost
A=[-1 -1 1 -2]
BV=[3]
answer=[0 0 0]
zjcj=[0 0 0 0] 

RUN=true;
while RUN
    for i=1:size(A,2)-1 
        zjcj(i)=sum(C(BV)*A(:,i))-C(i);
    end
    if any(A(:,size(A,2))<0)
        disp('the current BFS is not feasible')
        [lval, pvt_row]=min(A(:,size(A,2))) 
        for i=1:size(A,2)-1
            if A(pvt_row,i)<0 
                m(i)=zjcj(i)/A(pvt_row,i)
            else m(i)=-inf 
            end
        end
        [ent_val, pvt_col]=max(m) 
        A(pvt_row,:)=A(pvt_row,:)/A(pvt_row,pvt_col) 
        for i=1:size(A,1)
            if i~=pvt_row 
                A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:)
            end
        end
        BV(pvt_row)=pvt_col; 
    else
        RUN=false;
        disp('current BFS is Feasible and Optimal\n') 
        answer(BV)=A(:,size(A,2))
    end
end