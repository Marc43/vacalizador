function [mask, B, bbox, t1, t2] = selectaVaca(I)
    figure 
    imshow(I)
    out = getrect;
    close
    x = out(1);
    y = out(2);
    w = out(3);
    h = out(4);
    t1 = max(ceil((w)* (h) / 10000), 10)
    t2 = ceil(t1/4)
    bbox = [x, y, w, h];

    % Partim la imatge en blocs, extraiem les caracteristiques
    [features, labels] = imatgeBlocs(I, bbox, t1);

%   numArbres = 5;
%     
%   B = creaBosc(features, labels, numArbres);
    B = fitcnb(features, labels);
    fun = @(block_struct) creaMascara(block_struct.data, B);
    
    objecte = I(y:y+h-1, x:x+w-1, :);
    
    %es pot aplicar sobre tota la imatge tambe..
    mask = blockproc(objecte, [t2 t2], fun, 'UseParallel', false);

end