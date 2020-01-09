function [meanHue, meanSat, meanValue, meanStdDev] = getFeatureVector(IM)
    
        hsv_fons = rgb2hsv(IM);
        
        meanHue = mean2(hsv_fons(:,:,1));
        meanSat = mean2(hsv_fons(:,:,2));
        meanValue = mean2(hsv_fons(:,:,3));
        sdImage = stdfilt(hsv_fons(:,:,3));
        meanStdDev = mean2(sdImage);
    
end