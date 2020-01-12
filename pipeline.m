function pipeline()
    
    % ------------- 1ra fase del pipeline
    
    [path_img_usr_segmenta, user_canceled] = imgetfile;

    if user_canceled
        error("No has seleccionat pas cap imatge.");
    end
    
    img_usr_segmenta = imread(path_img_usr_segmenta);

    tamanyBloc = 100; % podriem ferho depenent de la imatge
    tamanySubBloc = ceil(tamanyBloc/4);
    
    %trobar la mascara aproximada
    [objecte, mask, treeBosc] = selectaVaca(img_usr_segmenta, tamanyBloc, tamanySubBloc);

    % un bloc son tamanyBloc*tamanyBloc. Considerarem que un objecte a de
    % ser minim constituit per 4 blocs...
    mask_p1 = bwareaopen(mask, tamanyBloc*tamanyBloc*4); % ferho depenent del tamany de bloc estaria be.
    
    mask_p2 = imfill(mask_p1, 'holes');
    
    se = strel("square", tamanySubBloc);
    
    bigger_mask_p1 = imdilate(mask_p2, se);
    boundary = bigger_mask_p1 - mask_p2;
    boundary = boundary(:, :, 1);
    
    vaquetaonets = imoverlay(objecte, boundary, 'red');

    imshow(vaquetaonets);

    retall = objecte;
    retall(mask_p1 == 0) = 0;
                    
    % --------------- 2na fase del pipeline
    
    [f, c] = size(retall);
    
    hogCellSize = [64 64];
    lbpCellSize = [128 128];
    
    retall = rgb2gray(retall);

    model.hog = extractHOGFeatures(retall, 'CellSize', hogCellSize);
    model.lbp = extractLBPFeatures(retall, 'CellSize', lbpCellSize, 'Upright', false);
    
    X = [model.hog, model.lbp];
    Y = 0;
    
    t = templateSVM('Standardize', 1);
    SVM = fitcecoc(X, Y, 'Learners', t);

    [path_img_trobar_obj, user_canceled] = imgetfile;
    
    if user_canceled
        error("No has seleccionat pas cap imatge.");
    end
    
    img_trobar_obj = imread(path_img_trobar_obj);
   % img_trobar_obj = rgb2gray(img_trobar_obj);
    
    fun = @(block_struct) creaMascara(block_struct.data, treeBosc);
        
    mascaraObj_2 = blockproc(img_trobar_obj, [tamanySubBloc tamanySubBloc], fun, 'UseParallel', true);
                   
    maskPixelsList = find(mascaraObj_2(:, :, 1));
    
    rightmost = max(maskPixelsList);
    leftmost = min(maskPixelsList);
    
    imshow(vaca_trobada);
    
%     fun = @(block_struct) trobaObjecte(block_struct.data, SVM);
%     retallEnNovaImatge = blockproc(img_trobar_obj, [f c], fun, 'UseParallel', true);
    
end