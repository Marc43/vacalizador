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

function B = creaBosc(features, labels, numTrees)   
    B = TreeBagger(numTrees, features, labels, 'Method', 'classification');
end

function outBlock = creaMascara(inBlock, bosc)
    
    % En el nostre classificador 0 es el fons i 1 l'objecte
    [f1, f2, f3, f4, f5, f6, f7, f8] = getFeatureVector(inBlock);
    feature_vector = [[f1, f2, f3, f4, f5, f6, f7, f8]];
    predictedClass = predict(bosc,feature_vector);
    
    if predictedClass == 0
        outBlock = zeros(size(inBlock));
    else
        outBlock = ones(size(inBlock));
    end
    
end