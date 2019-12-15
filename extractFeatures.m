function features = extractFeatures(data, numBlocs)

    histo_rs = zeros(numBlocs, 1, 256);
    histo_gs = zeros(numBlocs, 1, 256);
    histo_bs = zeros(numBlocs, 1, 256);
    
    for i=1:numBlocs
       bloc = cell2mat(data(i));
       histo_rs(i, :, :) = imhist(bloc(:, :, 1));
       histo_gs(i, :, :) = imhist(bloc(:, :, 2));
       histo_bs(i, :, :) = imhist(bloc(:, :, 3));
    end
    
    features = {histo_rs, histo_gs, histo_bs};
    
end