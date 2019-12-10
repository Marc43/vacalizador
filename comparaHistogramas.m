function result = comparaHistogramas(im1, im2)
    R1 = im1(:,:,1);
    G1 = im1(:,:,2);
    B1 = im1(:,:,3);
    R2 = im2(:,:,1);
    G2 = im2(:,:,2);
    B2 = im2(:,:,3);
    hr1 = imhist(R1);
    hr2 = imhist(R2);
    hg1 = imhist(G1);
    hg2 = imhist(G2);
    hb1 = imhist(B1);
    hb2 = imhist(B2);
    result = zeros(3, 1);
    [x, y] = size(hr1);
    for i=1:x
        result(1) = result(1) + pdist2(hr1(i),hr2(i),'squaredeuclidean')*(1/x);
        result(2) = result(2) + pdist2(hg1(i),hg2(i),'squaredeuclidean')*(1/x);
        result(3) = result(3) + pdist2(hb1(i),hb2(i),'squaredeuclidean')*(1/x);
    end
end