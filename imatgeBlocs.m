function [blocs, numBlocs] = imatgeBlocs(IM, tamanyBloc)
    % donada una imatge i un tamany de bloc retornem una matriu
    % tridimensional indexada amb el identificador del bloc.

    [n, m, ~] = size(IM);
        
    blocs = cell(tamanyBloc, tamanyBloc, 3);
    blocIdx = 1;
    
    for i=1:tamanyBloc:n
       upperN = min(i+tamanyBloc, n);
       for j=1:tamanyBloc:m
        upperM = min(j+tamanyBloc, m);
        blocs(blocIdx) = mat2cell(IM(i:upperN-1, j:upperM-1, :), min(tamanyBloc, upperN-i), min(tamanyBloc, upperM-j), 3);
        blocIdx = blocIdx + 1;
       end
    end
    
    blocs = blocs(~cellfun('isempty', blocs)); % eliminar cel.les buides
    numBlocs = blocIdx - 1;
end