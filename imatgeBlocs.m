%function [blocs, numBlocs, PixelsObjecte] = imatgeBlocs(IM, bbox, tamanyBloc)
function [features, labels] = imatgeBlocs(IM, bbox, tamanyBloc)
    % donada una imatge i un tamany de bloc retornem una matriu
    % tridimensional indexada amb el identificador del bloc.

    [n, m, ~] = size(IM);

    bbox_x = bbox(1);
    bbox_y = bbox(2);
    w = bbox(3);
    h = bbox(4);
        
    blocs = cell(tamanyBloc, tamanyBloc, 3);
    blocIdx = 1;
    
    %PixelsObjecte = [];
    i = 1;
    features = [];
    labels = [];
    while i < n
        j = 1;
        if(i+tamanyBloc < n)
            while j<m
                if(j+tamanyBloc < m)
                    retall = IM(i:i+tamanyBloc, j:j+tamanyBloc, :);
                    [meanHue, meanSat, meanValue, meanStdDev, meanR, meanG, meanB, meanGray] = getFeatureVector(retall);
                    features = [features; [meanHue, meanSat, meanValue, meanStdDev]];%, meanR, meanG, meanB, meanGray]];
                    labels = [labels;estaDintre(i, j, i+tamanyBloc, j+tamanyBloc, bbox_x, bbox_y, w, h)];
                else
                    retall = IM(i:i+tamanyBloc, j:m, :);
                    vector = getFeatureVector(retall);
                    features = [features; [meanHue, meanSat, meanValue, meanStdDev]];%, meanR, meanG, meanB, meanGray]];
                    labels = [labels;estaDintre(i, j, i+tamanyBloc, m, bbox_x, bbox_y, w, h)];
                end
                j = j + tamanyBloc;
            end
        else
            while j<m
                if(j+tamanyBloc < m)
                    retall = IM(i:n, j:j+tamanyBloc, :);
                    [meanHue, meanSat, meanValue, meanStdDev, meanR, meanG, meanB, meanGray] = getFeatureVector(retall);
                    features = [features; [meanHue, meanSat, meanValue, meanStdDev]];%, meanR, meanG, meanB, meanGray]];
                    labels = [labels;estaDintre(i, j, n, j+tamanyBloc, bbox_x, bbox_y, w, h)];
                else
                    retall = IM(i:n, j:m, :);
                    [meanHue, meanSat, meanValue, meanStdDev, meanR, meanG, meanB, meanGray] = getFeatureVector(retall);
                    features = [features; [meanHue, meanSat, meanValue, meanStdDev]];%, meanR, meanG, meanB, meanGray]];
                    labels = [labels;estaDintre(i, j, n, m, bbox_x, bbox_y, w, h)];
                end
                j = j + tamanyBloc;
            end
        end
        i = i + tamanyBloc;
    end
%     for i=1:tamanyBloc:n
%        upperN = min(i+tamanyBloc, n);
%        for j=1:tamanyBloc:m
%         upperM = min(j+tamanyBloc, m);
%         
%         xBloc = min(tamanyBloc, upperN-i);
%         yBloc = min(tamanyBloc, upperM-j);
%         
%         blocs(blocIdx) = mat2cell(IM(i:i+xBloc-1, j:j+yBloc-1, :), xBloc, yBloc, 3);
% 
%         cond1 = i >= bbox_y && (upperN-1) <= (bbox_y+h-1);
%         cond2 = j >= bbox_x && (upperM-1) <= (bbox_x+w-1);
%         
%         if (cond1 && cond2)
%             PixelsObjecte = [PixelsObjecte; [j, i]];    
%         else
%             PixelsObjecte = [PixelsObjecte; [0 0]];
%         end
%         
%         blocIdx = blocIdx + 1;
%        end
%     end
    
    %blocs = blocs(~cellfun('isempty', blocs)); % eliminar cel.les buides
    %numBlocs = blocIdx - 1;
end

function bool = estaDintre(a,b,c,d,x,y,w,h)
    if(x<b & d<x+w & y<a & c<y+h)
        bool = 1;
    else
        bool = 0;
    end
end