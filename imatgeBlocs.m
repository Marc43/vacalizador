%function [blocs, numBlocs, PixelsObjecte] = imatgeBlocs(IM, bbox, tamanyBloc)
function [features, labels] = imatgeBlocs(IM, bbox, tamanyBloc)
    % donada una imatge i un tamany de bloc retornem una matriu
    % tridimensional indexada amb el identificador del bloc.

    [n, m, ~] = size(IM);

    bbox_x = bbox(1);
    bbox_y = bbox(2);
    w = bbox(3);
    h = bbox(4);
    
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
                    features = [features; [meanHue, meanSat, meanValue, meanStdDev, meanR, meanG, meanB, meanGray]];
                    labels = [labels;estaDintre(i, j, i+tamanyBloc, j+tamanyBloc, bbox_x, bbox_y, w, h)];
                else
                    retall = IM(i:i+tamanyBloc, j:m, :);
                    [meanHue, meanSat, meanValue, meanStdDev, meanR, meanG, meanB, meanGray] = getFeatureVector(retall);
                    features = [features; [meanHue, meanSat, meanValue, meanStdDev, meanR, meanG, meanB, meanGray]];
                    labels = [labels;estaDintre(i, j, i+tamanyBloc, m, bbox_x, bbox_y, w, h)];
                end
                j = j + tamanyBloc;
            end
        else
            while j<m
                if(j+tamanyBloc < m)
                    retall = IM(i:n, j:j+tamanyBloc, :);
                    [meanHue, meanSat, meanValue, meanStdDev, meanR, meanG, meanB, meanGray] = getFeatureVector(retall);
                    features = [features; [meanHue, meanSat, meanValue, meanStdDev, meanR, meanG, meanB, meanGray]];
                    labels = [labels;estaDintre(i, j, n, j+tamanyBloc, bbox_x, bbox_y, w, h)];
                else
                    retall = IM(i:n, j:m, :);
                    [meanHue, meanSat, meanValue, meanStdDev, meanR, meanG, meanB, meanGray] = getFeatureVector(retall);
                    features = [features; [meanHue, meanSat, meanValue, meanStdDev, meanR, meanG, meanB, meanGray]];
                    labels = [labels;estaDintre(i, j, n, m, bbox_x, bbox_y, w, h)];
                end
                j = j + tamanyBloc;
            end
        end
        i = i + tamanyBloc;
    end
end

function bool = estaDintre(a,b,c,d,x,y,w,h)
    if(x+10<b & d-10<x+w & y+10<a & c-10<y+h)
        bool = 1;
    else
        bool = 0;
    end
end