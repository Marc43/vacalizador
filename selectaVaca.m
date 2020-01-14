function [objecte, mask, B] = selectaVaca(I, tamanyBloc, tamanySubBloc)
    figure 
    imshow(I)
    out = getrect;
    close
    x = out(1);
    y = out(2);
    w = out(3);
    h = out(4);

    bbox = [x, y, w, h];

    % Partim la imatge en blocs, extraiem les caracteristiques dels blocs
    % i creem un ensemble tree.

    %[blocs, ~, esObjecte] = imatgeBlocs(I, bbox, tamanyBloc);
    [features, labels] = imatgeBlocs(I, bbox, tamanyBloc);
%     idxBlocsFons = find(~esObjecte(:, 1));
%     idxBlocsObjecte = find(esObjecte(:, 1));
    
    %[features, labels] = extraureFeaturesEtiquetades(blocs, idxBlocsFons, idxBlocsObjecte); 

    % afecta a la precisio i a la velocitat d'execucio...
    numArbres = 5;
    
    B = creaBosc(features, labels, numArbres);
    
    fun = @(block_struct) creaMascara(block_struct.data, B);
    
    objecte = I(y:y+h-1, x:x+w-1, :);
    
    % es pot aplicar sobre tota la imatge tambe..
    mask = blockproc(objecte, [tamanySubBloc tamanySubBloc], fun, 'UseParallel', true);

end