% Function for background subtraction display
function [II,DD] = Disp_BGS(Y,D,X,imgsize)
    N = size(Y,2);  K = size(D,2);
    E = Y - D*X;    %E(abs(E)<0.1) = 0;
    E = E - repmat(min(E,[],1),size(Y,1),1);
    YR = D*X;       YR = YR - repmat(min(YR,[],1),size(YR,1),1);
%     figure;
    for ii = 1:N
        I = [reshape(Y(:,ii),imgsize), reshape(YR(:,ii)./max(YR(:,ii)),imgsize), ...
            reshape(E(:,ii)./max(E(:,ii)),imgsize)];
        II(:,:,ii) = I;
%         imshow(I); pause(0.03);
    end
    Da = D - repmat(min(D,[],1),size(D,1),1);
    for ii = 1:K
        I = reshape(Da(:,ii)./max(Da(:,ii)),imgsize);   %imshow(I);
%         pause(0.03);
        DD(:,:,ii) = I;
    end
    
end