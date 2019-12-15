function result = comparaCellHistogrames(histo1, histo2)
    % r g b, numBlocs histogrames per a cada conjunt d'histogrames.
    
    [numBlocs, x, ~] = size(histo1(1));
        
    result = zeros(3, 1);

    histo1_r = cell2mat(histo1(1));
    histo1_g = cell2mat(histo1(2));
    histo1_b = cell2mat(histo1(3));
    
    histo2_r = cell2mat(histo2(1));
    histo2_g = cell2mat(histo2(2));
    histo2_b = cell2mat(histo2(3));
    
    j = 10;
    
   % for j=1:1
        histo1_r_bloc = histo1_r(j);
        histo1_g_bloc = histo1_g(j);
        histo1_b_bloc = histo1_b(j);
        
        
        histo2_r_bloc = histo2_r(j);
        histo2_g_bloc = histo2_g(j);
        histo2_b_bloc = histo2_b(j);
        
        for i=1:x
            result(1) = result(1) + pdist2(histo1_r_bloc(i), histo2_r_bloc(i),'squaredeuclidean')*(1/x);
            result(2) = result(2) + pdist2(histo1_g_bloc(i), histo2_g_bloc(i),'squaredeuclidean')*(1/x);
            result(3) = result(3) + pdist2(histo1_b_bloc(i), histo2_b_bloc(i),'squaredeuclidean')*(1/x);
        end
%         
%         result(1) = result(1)*(1/numBlocs);
%         result(2) = result(2)*(1/numBlocs);
%         result(3) = result(3)*(1/numBlocs);
   % end
end