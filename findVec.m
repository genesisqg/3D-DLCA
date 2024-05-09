function [vecx,l] = findVec(posx,negx,index,map,c,type)
%for a cluster that exists across a boundary, this will calculate the rms
%for each monomer in the cluster and the length of the cluster 2-D

type
N = size(map);
negx = negx+N(1); %scale the negative values by the size of the matrix so 
% we get a whole cluster with all positive values, not on a Boundary
sz = max(size(posx));

scaled_x = [posx negx];
minx = min(scaled_x);
maxx=max(scaled_x);
l=abs(maxx-minx+1);
avgx = mean(scaled_x);
num = max(size(scaled_x))
j=1;

for i= 1:num
    if i<=sz
        posvecx(i) = (scaled_x(i)-avgx)^2;
    else
        negvecx(j) = (scaled_x(i)-avgx)^2;
        j=j+1;
    end
end
c
p=max(size(posvecx));
n=max(size(negvecx));
p+n

%need to reorganize so that each xi matches up with yi
s = max(size(index))
for i = 1:s
    if index(i,2)==1 
        vecx(i) = posvecx(index(i,1));
    elseif index(i,2) == -1
        vecx(i)=negvecx(index(i,1));
    end
end

