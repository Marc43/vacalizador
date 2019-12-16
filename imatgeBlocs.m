function [blocs, numBlocs, PixelsObjecte] = imatgeBlocs(IM, bbox, tamanyBloc)
    % donada una imatge i un tamany de bloc retornem una matriu
    % tridimensional indexada amb el identificador del bloc.

    [n, m, ~] = size(IM);

    bbox_x = bbox(1);
    bbox_y = bbox(2);
    w = bbox(3);
    h = bbox(4);
        
    blocs = cell(tamanyBloc, tamanyBloc, 3);
    blocIdx = 1;
    
    PixelsObjecte = [];
    
    for i=1:tamanyBloc:n
       upperN = min(i+tamanyBloc, n);
       for j=1:tamanyBloc:m
        upperM = min(j+tamanyBloc, m);
        blocs(blocIdx) = mat2cell(IM(i:upperN-1, j:upperM-1, :), min(tamanyBloc, upperN-i), min(tamanyBloc, upperM-j), 3);

        cond1 = i >= bbox_y && (upperN-1) <= (bbox_y+h-1);
        cond2 = j >= bbox_x && (upperM-1) <= (bbox_x+w-1);
        
        if (cond1 && cond2)
            PixelsObjecte = [PixelsObjecte; [j, i]];    
        else
            PixelsObjecte = [PixelsObjecte; [0 0]];
        end
        
        blocIdx = blocIdx + 1;
       end
    end
    
    blocs = blocs(~cellfun('isempty', blocs)); % eliminar cel.les buides
    numBlocs = blocIdx - 1;
end