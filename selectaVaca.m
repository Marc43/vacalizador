function ans = selectaVaca(I)
    figure 
    imshow(I)
    out = getrect;
    close
    x = out(1);
    y = out(2);
    w = out(3);
    h = out(4);
    
%     L = superpixels(I, w*h);
%     figure
%     imshow(I)
%     h1 = drawpolygon(gca,'Position',[x, y; (x+w-1), y; (x+w-1), (y+h-1); x, (y+h-1);]);
%     roiPoints = h1.Position;
%     %roiPoints = [y, x; y, (x+w-1); (y+h-1), (x+w-1); (y+h-1), x;];
%     roi = poly2mask(roiPoints(:,1), roiPoints(:,2), size(L,1), size(L,2));
%     BW = grabcut(I, L, roi);
%     figure
%     imshow(BW)
    etiquetaObjectes(I, [x, y, w, h]);
    
    ans = [x, y, w, h];
    %ans = I(y:y+h-1, x:x+w-1, :);
    %ans = detector(I);
end