function outBlock = creaMascara(inBlock, bosc)
    
    % En el nostre classificador 0 es el fons i 1 l'objecte
    [f1, f2, f3, f4] = getFeatureVector(inBlock);
    feature_vector = [[f1, f2, f3, f4]];
    
    predictedClass = str2double(bosc.predict(feature_vector));
    
    % una unica dimensio
    % outBlock = (inBlock(:, :, 1)) & logical(predictedClass);
    
    if predictedClass == 0
        outBlock = zeros(size(inBlock));
    else
        outBlock = ones(size(inBlock));
    end
    
end