% Normalizes the columns of the given matrix
function D2 = normc(D)
    [n,nD] = size(D);   Bsize = 1000;
    if nD > Bsize
        nB = ceil(nD/Bsize);
        D2 = [D,zeros(n,nB*Bsize-nD)];
        for ii = 1:nB
            indd = (ii-1)*Bsize+1:ii*Bsize;
            DD = D2(:,indd);
            tt = diag(DD'*DD);
            fl = tt == 0 | ~isfinite(tt);
            DD(:,fl) = ones(n,sum(fl));    
            tt(fl) = norm(ones(n,1));
            DD = DD * diag(1./sqrt(tt));
            D2(:,indd) = DD;
        end
    else
        tt = diag(D'*D);
        fl = tt == 0 | ~isfinite(tt);
        D(:,fl) = ones(n,sum(fl));    
        tt(fl) = norm(ones(n,1));
        D2 = D * diag(1./sqrt(tt));
    end
    D2 = D2(:,1:nD);
end