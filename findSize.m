function [s,flag] = findSize(V,c,map)
%V is the matrix with indeces of all monomers, c is the cluster we want to
%find the size of (3-D)
sz = size(map);
N = sz(1)-1;
flag=0;
l = max(size(V));
j=1;

for i=1:l
    if V(i,4)==c
        y(j)=V(i,1);
        x(j)=V(i,2);
        z(j)=V(i,3);
        j=j+1;
    end
end
num=max(size(y));
maxy = max(y);
miny = min(y);
maxx = max(x);
minx = min(x);
maxz = max(z);
minz = min(z);
avgy = mean(y);
avgx = mean(x);
avgz = mean(z);

count1=1;
count2=1;

%if cluster crosses a boundary
if minx==1 && maxx==sz(1) %need to find new minx and maxx
    for i = 1:num
        scaled_x=x(i)-sz(1)/2; %this will scale the cluster
        if scaled_x>0
            posx(count1)=scaled_x;
            index1(i,1) = count1;  %index keeps track of each location of xi
            index1(i,2) = 1; %so we can rearrange later....
            count1=count1+1;
        elseif scaled_x<0
            negx(count2)=scaled_x;
            index1(i,1) = count2;
            index1(i,2) = -1;
            count2=count2+1;
        end 
    end
    [xvec,l] = findVec(posx,negx,index1,map,c,'x');
elseif minx==maxx
    l=1;
    for i = 1:num
        xvec(i) = 0;
    end
else
    l=abs(maxx-minx+1);
    for i = 1:num
        xvec(i) = (x(i) - avgx)^2;
    end
end

count1=1;
count2=1;
%do the same for y direction
if miny==1 && maxy==sz(1) %need to find new miny and maxx
    for i = 1:num
        scaled_y=y(i)-sz(1)/2; %this will scale the cluster
        if scaled_y>0
            posy(count1)=scaled_y;
            index2(i,1)=count1;
            index2(i,2)=1;
            count1=count1+1;
        elseif scaled_y<0
            negy(count2)=scaled_y;
            index2(i,1)=count2;
            index2(i,2)=-1;
            count2=count2+1;
        end 
    end
    [yvec,h] = findVec(posy,negy,index2,map,c,'y');
elseif maxy==miny
    h=1;
    for i = 1:num
        yvec(i) = 0;
    end
else
    h=abs(maxy-miny+1);
    for i = 1:num
        yvec(i) = (y(i) - avgy)^2;
    end
end


count1=1;
count2=1;
%do the same for z direction
if minz==1 && maxz==sz(1) %need to find new miny and maxx
    for i = 1:num
        scaled_z=z(i)-sz(1)/2; %this will scale the cluster
        if scaled_z>0
            posz(count1)=scaled_z;
            index3(i,1)=count1;
            index3(i,2)=1;
            count1=count1+1;
        elseif scaled_z<0
            negz(count2)=scaled_z;
            index3(i,1)=count2;
            index3(i,2)=-1;
            count2=count2+1;
        end 
    end
    [zvec,w] = findVec(posz,negz,index3,map,c,'z');
elseif maxz==minz
    w=1;
    for i = 1:num
        zvec(i) = 0;
    end
else
    w=abs(maxz-minz+1);
    for i = 1:num
        zvec(i) = (z(i) - avgz)^2;
    end
end

if (h > sz(1)/2) || (l > sz(1)/2) || (w > sz(1)/2)
    flag=1;
end

%so theoretically we now have the height and length, need Rg
R_squared = xvec+yvec+zvec;
Rg = sqrt(mean(R_squared));
a = 0.5; % a is the radius of one particle
s=Rg/a;

end