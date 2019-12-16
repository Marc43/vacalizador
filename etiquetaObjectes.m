function etiquetaObjectes(IM, bbox)
    tamanyBloc = 25;
    [n, m, ~] = size(IM);

    [blocs, numBlocs, esObjecte] = imatgeBlocs(IM, bbox, tamanyBloc);
        
    %donats els blocs i si es objecte, dibuixem punts per tal de verificar
    %que shan determinat els blocs pertanyents al objecte correctament
    
    imshow(IM);
    hold on;

     for i=1:size(esObjecte)
         plot(esObjecte(i, 1), esObjecte(i, 2), 'ob')
         hold on 
     end

    histos = extractFeatures(blocs, numBlocs);
    
    idxBlocsFons = find(~esObjecte(:, 1));
    idxBlocsObjecte = find(esObjecte(:, 1));
    
    [numBlocsFons, ~] = size(idxBlocsFons);
    [numBlocsObjecte, ~] = size(idxBlocsObjecte);
    
    b_histo_avg_r = zeros(256, 1); % Foreground histogram average Red channel
    b_histo_avg_g = zeros(256, 1); % Foreground histogram average Green channel
    b_histo_avg_b = zeros(256, 1); % Foreground histogram average Blue channel
    
    for i=1:numBlocsFons
        
        b_histo_avg_r = b_histo_avg_r + squeeze(histos(idxBlocsFons(i), 1, :));
        b_histo_avg_g = b_histo_avg_g + squeeze(histos(idxBlocsFons(i), 2, :));
        b_histo_avg_b = b_histo_avg_b + squeeze(histos(idxBlocsFons(i), 3, :));
        
    end
    
    b_histo_avg_r = b_histo_avg_r/numBlocsFons;
    b_histo_avg_g = b_histo_avg_g/numBlocsFons;
    b_histo_avg_b = b_histo_avg_b/numBlocsFons;
    
    b_histo_avg = cat(3, b_histo_avg_r, b_histo_avg_g, b_histo_avg_b);
    
    % hay que permutarlo por que lo almaceno todo un poco raro
    
    mean_dist_backfore = zeros(3, 1);
    for i=1:numBlocsObjecte
        mean_dist_backfore = mean_dist_backfore + comparaHistogrames(b_histo_avg, permute(histos(idxBlocsObjecte(i), :, :), [3 1 2]));
    end
    mean_dist_backfore = mean_dist_backfore/numBlocsObjecte;

end