function trobaObjecte(IM, classifier)
    hogCellSize = [64 64];
    lbpCellSize = [128 128];

    hog = extractHOGFeatures(IM, 'CellSize', hogCellSize);
    lbp = extractLBPFeatures(IM, 'CellSize', lbpCellSize, 'Upright', false);

    X = [hog, lbp];

    [pred, score] = predict(classifier, X)
    
end