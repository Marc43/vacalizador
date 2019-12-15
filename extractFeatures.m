function features = extractFeatures(data, location);
        idx = num2str(location);
        hist = imhist(data);
        
        features.idx = idx;
        features.hist = hist;
end