function [V,ms,s,flag] = checkConnections(map,V)
%Checks whole matrix to see which particles are connected in a cluster and reformat V to
%ensure no double counting. Also reports the mass and size of each new
%cluster.

sz = size(map);
N = sz(1)-1;
connect=0;
h=1;
ms=0;
s=0;
flag=0;
num=max(size(V));

for a = 1:num %Outer loop goes through V
    i = V(a,1);
    j = V(a,2);
    k = V(a,3);
    for b = 1:num%INNER LOOP GOES THROUGH V again TO COMPARE
        l = V(b,1);
        m = V(b,2);
        n = V(b,3);
        index = V(b,4);
        if ((i==l && j==m && (n==k+1 || n==k-1)) || (i==l && k==n && (m==j+1 ||m==j-1)) || (k==n && m==j &&(i==l+1 || i==l-1))) && (V(a,4) ~= index)
            V(b,4) = V(a,4); %make it part of the cluster
            connect=1;
            for c=1:num
                if V(c,4)==index %and make the whole cluster
                    V(c,4)=V(a,4); %part of the new cluster
                end
            end
        elseif ((i==1 && j==m && l==i+N && n==k) || (i==1 && j==m && l==i && n==k+N) || (i==1 && m==j && l==i && n==k-N) ||(i==1 && l==i && m==j+N && n==k) || (i==1 && l==i && m==j-N && n==k)) && (V(a,4) ~= index)
            V(b,4) = V(a,4); %make it part of the cluster
            connect=1;
            for c=1:num
                if V(c,4)==index %and make the whole cluster
                    V(c,4)=V(a,4); %part of the new cluster
                end
            end
        elseif ((i+1>sz(1) && j==m &&l==i-N && n==k) || (i+1>sz(1) && m==j && l==i && n==k+N) || (i+1>sz(1) && m==j && l==i && n==k-N) || (i+1>sz(1) && l==i &&m==j+N &&n==k) || (i+1>sz(1) && l==i && m==j-N && n==k)) && (V(a,4) ~= index)
            V(b,4) = V(a,4); %make it part of the cluster
            connect=1;
            for c=1:num
                if V(c,4)==index %and make the whole cluster
                    V(c,4)=V(a,4); %part of the new cluster
                end
            end
        elseif ((j==1 &&i==l && m==j+N && n==k) || (j==1 && i==l &&m==j && n==k+N) || (j==1 && i==l && m==j &&n==k-N) || (j==1 && l==i+N && m==j && n==k) || (i==1 && l==i-N && m==j && n==k)) && (V(a,4) ~= index)
            V(b,4) = V(a,4); %make it part of the cluster
            connect=1;
            for c=1:num
                if V(c,4)==index %and make the whole cluster
                    V(c,4)=V(a,4); %part of the new cluster
                end
            end
        elseif ((j+1>sz(1) && i==l && m==j-N && n==k) || (j+1>sz(1) && i==l && m==j && n==k+N) || (j+1>sz(1) && i==l && m==j && n==k-N) || (j+1>sz(1) && l==i-N && m==j && n==k) || (j+1>sz(1) && l==i+N && m==j && n==k)) && (V(a,4) ~= index)
            V(b,4) = V(a,4); %make it part of the cluster
            connect=1;
            for c=1:num
                if V(c,4)==index %and make the whole cluster
                    V(c,4)=V(a,4); %part of the new cluster
                end
            end
        elseif ((k==1 && i==l &&m==j-N &&n==k) || (k==1 && l==i &&m==j &&n==k+N) || (k==1 && l==i && m==j+N && n==k) || (k==1 && l==i+N && m==j && n==k) || (k==1 && l==i-N && m==j && n==k)) && (V(a,4) ~= index)
            V(b,4) = V(a,4); %make it part of the cluster
            connect=1;
            for c=1:num
                if V(c,4)==index %and make the whole cluster
                    V(c,4)=V(a,4); %part of the new cluster
                end
            end
        elseif ((k+1>sz(1) && l==i && m==j && n==k-N) || (k+1>sz(1) && l==i+N && m==j && n==k) || (k+1>sz(1) && l==i-N && m==j &&n==k) || (k+1>sz(1) && l==i && m==j+N && n==k) || (k+1>sz(1) &&l==i && m==j-N && n==k)) && (V(a,4) ~= index)
            V(b,4) = V(a,4); %make it part of the cluster
            connect=1;
            for c=1:num
                if V(c,4)==index %and make the whole cluster
                    V(c,4)=V(a,4); %part of the new cluster
                end
            end
        end
    end
    if connect ==1 %if cluster found a succcessful connection, measure mass and size
        [sze,flag] = findSize(V,V(a,4),map);
        mass = findMass(V,V(a,4));
        ms(h) = mass;
        s(h)=sze;
        h=h+1;
        connect=0;
    end
end
