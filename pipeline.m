function out = pipeline(IM)
    
    tamanyBloc = 20; % podriem ferho depenent de la imatge
    tamanySubBloc = ceil(tamanyBloc/4);
    
    %trobar la mascara aproximada
    [objecte, mask] = selectaVaca(IM, tamanyBloc, tamanySubBloc);

    % un bloc son tamanyBloc*tamanyBloc. Considerarem que un objecte a de
    % ser minim constituit per 4 blocs...
    mask_p1 = bwareaopen(mask, tamanyBloc*tamanyBloc*4); % ferho depenent del tamany de bloc estaria be.
    
    mask_p2 = imfill(mask_p1, 'holes');
    
    se = strel("square", tamanySubBloc);
    
    bigger_mask_p1 = imdilate(mask_p2, se);
    boundary = bigger_mask_p1 - mask_p2;
    boundary = boundary(:, :, 1);
    
    vaquetaonets = imoverlay(objecte, boundary, 'red');
    
    out = vaquetaonets;
    
end