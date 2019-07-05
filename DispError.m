%% Error Display
function E = DispError(Y,D,X,verbb)
if ~exist('verbb','var'); verbb = 0; end
E = norm(Y - D*X,'fro')/norm(Y,'fro');
if verbb
    fprintf('Error: %0.4f\n',E);
end
end