function result = comparaHistogrames(histo1, histo2)
    % compara histograma histo1 amb histo2.
    
    [x, ~] = size(histo1);
        
    histo1_r = histo1(:, :, 1);
    histo1_g = histo1(:, :, 2);
    histo1_b = histo1(:, :, 3);
    
    histo2_r = histo2(:, :, 1);
    histo2_g = histo2(:, :, 2);
    histo2_b = histo2(:, :, 3);
    
    result = zeros(3, 1);

    for i=1:x
        result(1) = result(1) + pdist2(histo1_r(i), histo2_r(i), 'squaredeuclidean')*(1/x);
        result(2) = result(2) + pdist2(histo1_g(i), histo2_g(i), 'squaredeuclidean')*(1/x);
        result(3) = result(3) + pdist2(histo1_b(i), histo2_b(i), 'squaredeuclidean')*(1/x);
    end
    
end