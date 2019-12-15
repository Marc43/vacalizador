function [rh, gh, bh] = blockprocRGB(IM, nBlocks)

    [x, y, ~] = size(IM);
    
    r = round(x/nBlocks);
    c = round(y/nBlocks);
    
    n = round(x/r);
    m = round(y/c);
    realNumBlocks = n*m;
    
    R_IM = IM(:, :, 1);
    G_IM = IM(:, :, 2);
    B_IM = IM(:, :, 3);
    
    fun = @(block_struct) extractFeatures(block_struct.data(:), block_struct.location);
    histo1 = blockproc(R_IM, [r c], fun);
    rh = histo1;
    
    histo2 = blockproc(G_IM, [r c], fun);
    gh = histo2;
    
    histo3 = blockproc(B_IM, [r c], fun);
    bh = histo3;
    
    % rh, gh, bh contenen els histogrames per a cada canal de color
    % La imatge ha estat dividida en nBlocks*nBlocks (potser al arrodonir algun
    % mes).
    
end