function [feature_vector, labels] = extraureFeaturesEtiquetades(blocs, idxBlocsFons, idxBlocsObjecte)
    
    % Aquesta funcio calcula el feature_vector per a cada un dels individus
    % (fons o objecte), i els etiqueta en el vector de cells labels. Ja que
    % nomes tenim 2 possibilitats 0 sera el fons i 1 el objecte.
    
    [numBlocsFons, ~] = size(idxBlocsFons);
    [numBlocsObjecte, ~] = size(idxBlocsObjecte);
        
    % Farem servir 4 caracteristiques, fem un prealloc de les estructures.
    
    nFeatures = 4;

    fonsFeatures = zeros(numBlocsFons, nFeatures);
    objecteFeatures = zeros(numBlocsObjecte, nFeatures);
    
    for i=1:max(numBlocsFons, numBlocsObjecte)
    
        if i < numBlocsFons
            
            bloc_fons = cell2mat(blocs(idxBlocsFons(i)));
            
            [f1, f2, f3, f4] = getFeatureVector(bloc_fons);
            fonsFeatures(i, 1) = f1;
            fonsFeatures(i, 2) = f2;
            fonsFeatures(i, 3) = f3;
            fonsFeatures(i, 4) = f4;
            
        end
        
        if i < numBlocsObjecte
            
            bloc_obj = cell2mat(blocs(idxBlocsObjecte(i)));
            
            [f1, f2, f3, f4] = getFeatureVector(bloc_obj);
            objecteFeatures(i, 1) = f1;
            objecteFeatures(i, 2) = f2;
            objecteFeatures(i, 3) = f3;
            objecteFeatures(i, 4) = f4;

            
        end
        
    
    end
    
    feature_vector = [fonsFeatures; objecteFeatures];
    
    labels = zeros(numBlocsFons + numBlocsObjecte, 1);
    labels(numBlocsFons:size(labels)) = 1;
    
end