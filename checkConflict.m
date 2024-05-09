function [conflicts,newV] = checkConflict(V,dx,dy,dz,c,map)
%Checks to see is a desired move will result in an overlap of particles

sz = size(map);
N = sz(1)-1;
num = max(size(V));

%construct new theoretical V
newV=V;
for b=1:num
    if V(b,4)==c %c is the cluster currently moving
        i = V(b,1);
        j = V(b,2);
        k = V(b,3);
        if i+dy==0
            newV(b,1)=i+N;
        elseif i+dy>sz(1)
            newV(b,1)=i-N;
        elseif j+dx==0 
            newV(b,2)=j+N;
        elseif j+dx>sz(1) 
            newV(b,2)=j-N;
        elseif k+dz==0
            newV(b,3)=k+N;
        elseif k+dz>sz(1)
            newV(b,3)=k-N;
        else
            newV(b,1) = V(b,1)+dy; 
            newV(b,2) = V(b,2)+dx;
            newV(b,3) = V(b,3)+dz;
        end
    end
end

conflicts=0;

for a = 1:num %Outer loop goes through new V
    if newV(a,4)==c %we only care about positions that conflict with the cluster we move
        i = newV(a,1);
        j = newV(a,2);
        k = newV(a,3);
        
        for b = 1:num%INNER LOOP GOES THROUGH V
            l = V(b,1);
            m = V(b,2);
            n = V(b,3);
            index = V(b,4);
            if i==l && j==m && k==n && index~= c
                conflicts =1;
            end
        end
    end
end
