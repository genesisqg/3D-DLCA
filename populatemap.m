function [num,V,map,m,s] = populatemap(sz,phi0)
%randomly populates a 3D grid with size, sz, with desired phi0. Returns the
%number of points in the grid and the indexed locations of each point on
%the grid.

%phi0=N/sz^2 phi0 is proportional to the probablility that we will find a
%particle in a given location

map = zeros(sz);
num = 0;
for i=1:sz
    for j=1:sz
        for k = 1:sz
            R = rand(1);
            if R<= phi0
                map(i,j,k) = 1;
                num = num+1;
                V(num,1) = i;
                V(num,2) = j;
                V(num,3) = k;
                V(num,4) = num;
                
            end
        end
    end
end
[V,m,s,~] = checkConnections(map,V);