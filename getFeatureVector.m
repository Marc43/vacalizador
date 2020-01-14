function [meanHue, meanSat, meanValue, meanStdDev, meanR, meanG, meanB, meanGray] = getFeatureVector(IM)
    
        hsv_fons = rgb2hsv(IM);
        gray = rgb2gray(IM);
        
        meanHue = mean2(hsv_fons(:,:,1));
        meanSat = mean2(hsv_fons(:,:,2));
        meanValue = mean2(hsv_fons(:,:,3));
        sdImage = stdfilt(hsv_fons(:,:,3));
        meanStdDev = mean2(sdImage);
        meanR = mean2(IM(:,:,1));
        meanG = mean2(IM(:,:,2));
        meanB = mean2(IM(:,:,3));
        meanGray = mean2(gray);
end