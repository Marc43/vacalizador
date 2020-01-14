function pipeline()
    
    % ------------- 1ra fase del pipeline
    
    [path_img_usr_segmenta, user_canceled] = imgetfile;

    if user_canceled
        error("No has seleccionat pas cap imatge.");
    end
    
    img_usr_segmenta = imread(path_img_usr_segmenta);
    [n, m, ~] = size(img_usr_segmenta);
    
    
    %trobar la mascara aproximada
    [mask, treeBosc, bbox, tamanyBloc, tamanySubBloc] = selectaVaca(img_usr_segmenta);

    x = bbox(1);
    y = bbox(2);
    w = bbox(3);
    h = bbox(4);
    
    
    boundary = post_proc_mask(mask);
    
    zerapios = zeros(n, m);
    zerapios(y:y+h-1, x:x+w-1) = boundary;
    
    objecte = imoverlay(img_usr_segmenta, zerapios, 'red');

    imshow(objecte);
    pause;
    retall = objecte;
                  
    % --------------- 2na fase del pipeline
    tamany = tamanyBloc;
    
    
    user_canceled = false;
    while ~ user_canceled
        [path_img_trobar_obj, user_canceled] = imgetfile;
        img_trobar_obj = imread(path_img_trobar_obj);
        fun = @(block_struct) creaMascara(block_struct.data, treeBosc);
        mascaraObj_2 = blockproc(img_trobar_obj, [tamany tamany], fun, 'UseParallel', false);
        mask = post_proc_mask(mascaraObj_2);
        [y, x] = find(mask(:, :, 1));
        up = min(y);
        bot = max(y);
        right = max(x);
        left = min(x);
        imshow(img_trobar_obj);
        rectangle('Position', [left, up , (right - left), (bot - up)], 'Edgecolor', 'r');
        pause;
    end
    error('adeu')
end

function proc_mask = post_proc_mask(mask)
    % un bloc son tamanyBloc*tamanyBloc. Considerarem que un objecte a de
    % ser minim constituit per 4 blocs...
    mask = mask(:, :, 1);
    
    out = bwconncomp(mask);
    llistaPixels = out.PixelIdxList(:);
    [nrows, ~] = cellfun(@size, llistaPixels);
    [~, index] = max(nrows);
    
    llistaPixels = out.PixelIdxList(index);
    llistaPixels = cell2mat(llistaPixels);
    
    aux_mask = zeros(out.ImageSize(1), out.ImageSize(2));
    aux_mask(llistaPixels(:)) = 1;
    
    
    mask_p2 = imfill(aux_mask, 'holes');
    
    se = strel("square", 5);
    
    bigger_mask_p1 = imdilate(mask_p2, se);
    proc_mask = bigger_mask_p1 - mask_p2;
    
end

function outBlock = creaMascara(inBlock, bosc)
    
    % En el nostre classificador 0 es el fons i 1 l'objecte
    [f1, f2, f3, f4, f5, f6, f7, f8] = getFeatureVector(inBlock);
    feature_vector = [[f1, f2, f3, f4, f5, f6, f7, f8]];
    predictedClass = predict(bosc,feature_vector);
    
    if predictedClass == 0
        outBlock = zeros(size(inBlock));
    else
        outBlock = ones(size(inBlock));
    end
    
end