%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%                         Genesis Quiles-Galarza                         %
%                           CBE 641: Transport                           %
%                   Diffusion Limited Cluster Aggregation  (3D)          %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz = 10;
phi0=0.1;
time=0;

[num,V,map,m,s] = populatemap(sz,phi0);
figure(1)
scatter3(V(:,1),V(:,2),V(:,3),'filled')
clusters=unique(V(:,4));
Nclusters = max(size(clusters));
     
while Nclusters > 1
    [map,V,m2,s2,flag] = move(map,V);
    scatter3(V(:,1),V(:,2),V(:,3),'filled')
    drawnow;
    m=[m m2];
    s=[s s2];
    clusters=unique(V(:,4));
    Nclusters = max(size(clusters));
    time=time+1;
end

clusters=unique(V(:,4));
Nclusters = max(size(clusters));

figure(2)
scatter(s,m)
set(gca,'xscale','log')
set(gca,'yscale','log')

%resize for excel
m=reshape(m, [max(size(m)) 1]);
s=reshape(s, [max(size(s)) 1]);