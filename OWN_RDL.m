% Robust DL version 1
% A different alpha for each vector of the residual matrix
% Alpha calculations for each atom only once
% Set the beta and alpha carefully according to the experiment
function [D,X,Err] = OWN_RDL(Y,D,X,noIt,lambda,alpha,delta,verb)
    if ~exist('verb','var');    verb = 0;   end
    wei = @(aa,e) (exp(-aa./2.*(e.^2)));
    [n,N] = size(Y);    len = n*N;
    K = size(D,2);      fact = max(1,ceil(delta*n));
    DD = D; % for camparison
%     figure;
    Err = zeros(1,noIt);
    for it = 1:noIt
        if it == 1
            W = ones(n,N);
        elseif alpha 
            EE = Y - D*X;
            EE_ = sort(EE.^2,'descend');
            tt = EE_(fact,:);
            alpha_ = alpha*(-2*log(0.5)./tt);
            W = wei(alpha_,EE);
        else
            W = ones(n,N);
            alpha_ = alpha;
        end
%         rP = randperm(K);
        for k = 1:K        %1:K
            Ek = Y - D*X + D(:,k)*X(k,:);
            d = 0;  jj = 0;
            while norm(d - D(:,k)) > 10^-4 && jj < 5
                d = D(:,k);     jj = jj + 1;    %[k,jj]
                gamma = (d.^2'*W) .\ sum(d.*W.*Ek);
                lam = lambda ./ (d.^2'*W);
                X(k,:) = sign(gamma).*max(0,abs(gamma) - lam);     
                D(:,k) = normc(sum(W.*X(k,:).^2,2).\sum(X(k,:).*W.*Ek,2));
            end
        end
        Diff = norm(D - DD,'fro')/sqrt(K);
        if verb   
            Err(it) = DispError(Y,D,X,0);
            fprintf('Iteration: %2d, Error: %0.3f, DConv: %0.3f, Sparsity: %0.3f\n',...
                it,Err(it),norm(D - DD,'fro')/sqrt(K),nnz(X)/N);            
        end
        if Diff < 0.01
            break;
        end
        DD = D;
    end    
end