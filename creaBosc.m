function B = creaBosc(features, labels, numTrees)   

    B = TreeBagger(numTrees, features, labels, 'Method', 'classification');
    
end